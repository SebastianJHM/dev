import sys
from leer_instancias_pruebas import read_data_XLSX
import xlsxwriter
from Makespan_MIP import modelo_makespan
import fo_makespan as fo
import socket
socket.getaddrinfo('localhost', 8080)

def principal(argv):
    INSTANCIAS = read_data_XLSX()
    for inst in INSTANCIAS:
        
        workbook = xlsxwriter.Workbook('Results_Makespan_ML Inst('+str(INSTANCIAS.index(inst)+1)+').xlsx')
        
        print("============ Inst: ", INSTANCIAS.index(inst), " ============")
        ## Parámetros de la instancia
        tp = inst.tiempos_procesamiento
        dd = inst.due_dates
        
        ## Obtener secuencia de Modelo Lineal
        secuencia, makespan, tardanza = modelo_makespan(tp, dd)
        print("Secuencia: ", secuencia, "; Makespan: ", makespan, "; Tardanza: ", tardanza )
        
        ## Imprimir archivo
        nombre_hoja = "Inst"+str(INSTANCIAS.index(inst)+1)
        imprimir_XLSX(workbook, nombre_hoja, secuencia, tardanza, makespan )
        
        workbook.close()
    #rof
    
#fed

def imprimir_XLSX(workbook, nombre_hoja, secuencia, tardanza, makespan):
    worksheet = workbook.add_worksheet(nombre_hoja)
    
    worksheet.set_column(1, 1, 9.5)
    
    cell_format_bold = workbook.add_format({
        'bold': 1,
        'align': 'center',
        'valign': 'vcenter'})
    cell_format = workbook.add_format({'align': 'center'})
    
    worksheet.merge_range("B2:D2", "SOLUCIÓN SOLVER GLPK", cell_format_bold)
    worksheet.write("B3", "Secuencia", cell_format_bold)
    
    row = 2
    col = 2
    for s in secuencia:
        worksheet.write(row, col, s, cell_format)
        col += 1
    #rof
    worksheet.write("B4", "Makespan", cell_format_bold)
    worksheet.write("C4", makespan)
    worksheet.write("B5", "Tardanza", cell_format_bold)
    worksheet.write("C5", tardanza)
#fed


if __name__ == "__main__":
    principal(sys.argv)
#fi