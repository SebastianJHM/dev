import React from "react";
import "./styles/Skeleton.css"

function Skeleton() {
    return(
        <li>
            <div className="skeleton-container">
                <div className="s1-skeleton">
                    <div className="icon-skeleton animate-skeleton"></div>
                </div>
                <div className="s2-skeleton">
                    <div className="title-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                </div>
            </div>

            <div className="skeleton-container">
                <div className="s1-skeleton">
                    <div className="icon-skeleton animate-skeleton"></div>
                </div>
                <div className="s2-skeleton">
                    <div className="title-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                </div>
            </div>

            <div className="skeleton-container">
                <div className="s1-skeleton">
                    <div className="icon-skeleton animate-skeleton"></div>
                </div>
                <div className="s2-skeleton">
                    <div className="title-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                    <div className="text-skeleton animate-skeleton"></div>
                </div>
            </div>
        </li>
    );
}

export { Skeleton }