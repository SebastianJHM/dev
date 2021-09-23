'use strict';

class LikeButton extends React.Component {
    constructor(props) {
        super(props);
        this.state = { liked: false };
    }

    render() {
        if (this.state.liked == true) {
            // return 'You liked comment number ' + this.props.commentID;
            return React.createElement(
               'div',
               {},
               'You liked comment number ' + this.props.commentID
            );
        } else {
            return React.createElement(
                'button',
                { onClick: () => this.setState({ liked: true }) },
                'Like'
            );
        }

    }
}

// Find all DOM containers, and render Like buttons into them.
document.querySelectorAll('.like_button_container')
    .forEach(domContainer => {
        // Read the comment ID from a data-* attribute.
        const commentID = parseInt(domContainer.dataset.commentid, 10);
        ReactDOM.render(
            React.createElement(LikeButton, { commentID: commentID }),
            domContainer
        );
    });