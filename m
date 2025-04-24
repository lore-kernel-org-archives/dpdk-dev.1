Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E3FC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 12:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E012400D7;
	Thu, 24 Apr 2025 14:28:35 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 367FE400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 14:28:34 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b03bc416962so623710a12.0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745497713; x=1746102513; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ggq+o3Oo+sIcoUHeoEBMotNJLJfoNA0YucRsMYfUU+M=;
 b=VHqvAR9lIrtpem4CwY6h1Pg6/V2m9G/hGftjwdnzGeG0bRURPlYuGneujkT7ptaVwr
 /Dd7IUYC12qmnK9kN+I+ebtnXJohlmP/PuC7cXVK02GEmEtD63Q5BhYI+FCtmQpMgBuL
 1doeqRBwjpKakdyYZ+5JE9cJxQxZ4nnYYQG74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745497713; x=1746102513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggq+o3Oo+sIcoUHeoEBMotNJLJfoNA0YucRsMYfUU+M=;
 b=UNB/mH4zvNOuBb5IsyEOjgUPjWAVoPyJPzF2we5Gjxzxnd9POdSpBF37HrAJk/j2tj
 vMpbaxnOsaUcLgXjounjxDZg5TExXVz21mMU7s42KSBdtHFenxJx7KFz10NilcuhKir9
 PArr1Lw1IebCYOTKj0XCobhmyAeT0xo7IDmxt26txjwXyHMiTh8Qy+Rca1v5hAARa6Ad
 uF9hJa5d7SgLJJjppLlyaK6SbEViuj1y92MYfBJzTiAmSyZkCJpWKzHL99VEXhKrCL9s
 bhbKDs3rLD8b66/gveEC2dFZp8eD8Xq2d4vfCbybqFm9udKqNKR09pH8oGnFWnQmSNjX
 pC9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJwwaTBN2LGo6w0V2mr1Zg7v10NSQ1kZNiuKl5ZK3/Abn4OntDyKBKPPWSk5Ha6txuFcE=@dpdk.org
X-Gm-Message-State: AOJu0YywG1AuQfdJcWy/LLTJbBXUqkeSTfOJQu+HRYsxYoCQooS3cwRJ
 vZATxZ6PJSma33GEy99G5q4zBDZmAY3WDufuQ2W5Qafru5LJw11APZnRu4De8n4DNP03eKt9oBL
 GKiy2k2F4eCm7r9T48I0WM1OIWhxkbI+CXA1SDg==
X-Gm-Gg: ASbGncvA53JpwROdGN+nXbaR79aFa1MC9cqswPSXzJFt5YzLCdK1Q1vQqeofv7oMcJ3
 nLB053s5DxsAS7znmYotdWeMxUAA5r4E83gObdfmmpxjM9LT5iTXriaR/ymYlx1zydAQg5hP8Df
 1Sab5miLI/QnA+ogGVcitFsdWEMkfRezcDLaI4hAtGFOKB5JZtU74ou+4=
X-Google-Smtp-Source: AGHT+IFu0oRNR8GP/MSgieWNJiLD2Ji0XuaPfAfHej2TlPjXh4Dlrf7Rw8kFsOJmLzJI7OeQSnPvDD1oQR6DQC+7TmQ=
X-Received: by 2002:a17:90a:d64e:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-309ed24bc48mr3558253a91.6.1745497713172; Thu, 24 Apr 2025
 05:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240923154936.15952-1-jspewock@iol.unh.edu>
 <20250220212443.66483-1-dmarx@iol.unh.edu>
 <20250220212443.66483-3-dmarx@iol.unh.edu>
In-Reply-To: <20250220212443.66483-3-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 08:24:10 -0400
X-Gm-Features: ATxdqUEezYz9kHj4yncc3nU049Kwkdwhw2RFnIj_dmPkPHTXtnMLwj4MmgaNCqA
Message-ID: <CAJvnSUAKsM9DbdrPWr5UYv_Zn28dnkAEGKhpmjYmwBjbHJ8-8w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add port stats checks test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: npratte@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000002676760633855b6a"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--0000000000002676760633855b6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:24=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> This patch adds a new test suite to DTS that validates the accuracy of
> the port statistics using testpmd. The functionality is tested by
> sending a packet of a fixed side to the SUT and verifying that the
>

Just updating side to size before I push

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--0000000000002676760633855b6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 20,=
 2025 at 4:24=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">This patch adds a new test suite to DTS that validates th=
e accuracy of<br>
the port statistics using testpmd. The functionality is tested by<br>
sending a packet of a fixed side to the SUT and verifying that the<br></blo=
ckquote><div><br></div><div>Just updating side to size before I push</div><=
div>=C2=A0</div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@=
iol.unh.edu">probb@iol.unh.edu</a>&gt;<div>Tested-by: Patrick Robb &lt;<a h=
ref=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div></div=
></div>

--0000000000002676760633855b6a--
