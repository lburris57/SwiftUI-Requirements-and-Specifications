//
//  AddCommentView.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/23/21.
//

import SwiftUI

struct AddCommentView: View
{
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View
    {
        Text("Hello, World from AddCommentView!")
    }
}

struct AddCommentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        AddCommentView()
    }
}
