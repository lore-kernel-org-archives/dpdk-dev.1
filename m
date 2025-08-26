Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418D9CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 07:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 783A740298;
	Tue, 26 Aug 2025 09:31:40 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 70C7D4021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 09:31:38 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4b0faa6601cso79578351cf.1
 for <dev@dpdk.org>; Tue, 26 Aug 2025 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1756193498;
 x=1756798298; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uz+mjfISZ1vd+xvtwbEqu+ve78vGgc6C/mOESTVGdHM=;
 b=FreRsI4hIkK4kYu6wh8TzW9jmehVN4finAxuTHMHgkTFpuRNFvwmzOhpO/AKZiMVh2
 cyMzj/LsnyfqwUY9Oh55XEOIs3ra9b3SSG/5vgKWxcX2g3e6TT7XwLYJa7Ca32WLrU7O
 CsNqc+/FtFN2oA6SYBypk8SOLG+A3wQXObj2xULTcyjFJg1/pHiD7IwQ08RV/7xZsA/p
 4BfhRkwGWMEwADpF39vWYMU08nk3+wQmZlW3mZoiIMket41s17Rn6qNGMpz/JTf49Snr
 Nrd1oesxkNAuZ/7o0d+49eXJwZzIx73hVeD4lMYjLyFx6aO1NgJKfquuVfv2HPo3hV2o
 oCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756193498; x=1756798298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uz+mjfISZ1vd+xvtwbEqu+ve78vGgc6C/mOESTVGdHM=;
 b=D0WhgZtO1cffINSg0/DFKYREeyuIpdOT1KgsTAmLsABnpjXXVLLiH33OyWMzV1rPYd
 d1LjMg+HjmT6h7ntLsXFpbKNtD25Mf5rZjIgmmLmhwVveyXVxy4dcBn9b9w8wC15TqO6
 qJyLEoMGyFWhOugj9CRasbFju3DA0rlr2tvAnB0pUBrhc3CrCiN3Y4Cn4UN3nWiVvVGJ
 +5fLc/zKYhoejESuCtrMbG/FRCYMdjj67j6Yuwcp3XzIhh9Hq+NEJHO3NZHxZkqAVgmp
 D6Me9p4r6dXLxIx6UzdolycbIqPkR1zE89vdKay8jPehjiN2RA6ZzvveRJP8zbp4cVdF
 d0OQ==
X-Gm-Message-State: AOJu0YzYyGXryQLJt7J3A7tUZEedDjOR07xzr+gzTvi5w3tf66awaha/
 uFq+luqWW77QVZ2tM3RxzKXCpRJHWdYn330EApKG6gmCsH5X3hYFBsp+bXcBIBEyImzU4EdInNA
 xKkA9BQvkDgez/MNfE2MwcbW7a1sEIELo6ux9kjiHodpsngWakUlaiqs=
X-Gm-Gg: ASbGncuEHmioefI97HTGgPNS05RUvQGiXu0lSIjnYExiXF7FtVWTX1CITULLIvfTfjT
 4pFGd7iwFFA5bULTWWcvPY7pRcIbH3uLIWfVT7qRvol+mDYhIobtyuubLjJOcehA485GA9Byzo3
 SVMW72wjc6VsYP6jsJq2GTAJLvU/3NEt0z/LjCPKKXyYCthxdQAyUdAF91m3d0tD01xhSYwkxMb
 3KmD46q+cPt+gkZ2IBxUMwjevQAUe7P7lIsHEgt1qmU8phwwN3YNvBmmfTQBkBkdBSsur6B2C1w
 hXcLRgvgtTVaoRJ+gGNh
X-Google-Smtp-Source: AGHT+IG/CRuu8FIg2qgr46Jl+1GXL5wFBJLl4DOf7SghcAgdduQi/nb+MbT9WZnfvWgbwbVPHWv/Zs6Vu7Rb1u8fTCU=
X-Received: by 2002:ac8:7d8f:0:b0:4ae:cc49:e9ac with SMTP id
 d75a77b69052e-4b2e76f6c3amr4260541cf.29.1756193497672; Tue, 26 Aug 2025
 00:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
In-Reply-To: <20250825123548.1177090-4-ciara.loftus@intel.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 26 Aug 2025 12:31:26 +0500
X-Gm-Features: Ac12FXwlkg79_7X5ho5BqPlyQjZW07ARGPw0gOiGhg5v842DZTbYQd9OUdnJ3ik
Message-ID: <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000095ff27063d3fa9bd"
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

--00000000000095ff27063d3fa9bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ciara Loftus,

We may need some legacy support for the SSE path for earlier systems. Or it
will not be a problem ?
As you specified that modern x86 systems all support AVX2, if not AVX-512.
Still, we might need some type of support for the SSE path.


Best Regards,
Khadem

On Mon, Aug 25, 2025 at 5:36=E2=80=AFPM Ciara Loftus <ciara.loftus@intel.co=
m> wrote:

> Modern x86 systems all support AVX2, if not AVX-512, so the SSE path
> is no longer widely used. This change will not result in any feature
> loss, as in the rare cases where the SSE path would have been used in
> the absence of AVX2 or AVX-512, the fallback scalar path will be used
> which has feature parity with SSE.
>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

--00000000000095ff27063d3fa9bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Ciara Loftus, <br><br>We may need some=
 legacy support for the SSE path for earlier systems. Or it will not be a p=
roblem ?=C2=A0<br>As you specified that modern x86 systems all support AVX2=
, if not AVX-512. <br>Still, we might need some type of support for the SSE=
 path. <br><br><br>Best Regards, <br>Khadem <br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, Aug 25, 2025 at 5:36=E2=80=AFPM Ciara Loftus &lt;<a href=3D"mailto:ciara=
.loftus@intel.com">ciara.loftus@intel.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Modern x86 systems all support AVX=
2, if not AVX-512, so the SSE path<br>
is no longer widely used. This change will not result in any feature<br>
loss, as in the rare cases where the SSE path would have been used in<br>
the absence of AVX2 or AVX-512, the fallback scalar path will be used<br>
which has feature parity with SSE.<br>
<br>
Signed-off-by: Ciara Loftus &lt;<a href=3D"mailto:ciara.loftus@intel.com" t=
arget=3D"_blank">ciara.loftus@intel.com</a>&gt;<br>
---=C2=A0</blockquote></div></div>

--00000000000095ff27063d3fa9bd--
