Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C4C28B20
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Mar 2025 13:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1290A402AB;
	Sun, 30 Mar 2025 15:47:13 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 26F2E402A4
 for <dev@dpdk.org>; Sun, 30 Mar 2025 15:47:12 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-301493f461eso4580539a91.3
 for <dev@dpdk.org>; Sun, 30 Mar 2025 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743342431; x=1743947231; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XgnXbfz5cIUtIQmdYamA54/5z1izjzp2XE1nuXTguPs=;
 b=cKmunXl8xBSIdj9YvDH0ZIGoBDHb/DcpyWwW/7HK92h9MSKwE0fvc09B/JueNqXu3b
 +TSF2PvF545nHyzTKr8EhceZWbYKT0wpFbofY6F7LioKr0sfu2eNBWNtq6uNF1jePp3R
 9CvNYf4/kv1THOf4GNWbyxXOvnRMSAfokvWwTYlZ5SP9Y/WsnQXh3Y6p5sYqvF07fZ6C
 XQeiZDPZSQjVfGP+aGvDfX4iF5tk+XXzgg7ntaVOzxPkjQUidbK/YCwe/xUJe6pM8lHa
 j38ztw6CeIDI1PqNQdDjydGfxABcE1AymZ8IHA43a85zrPzlSvQFb/vx6Onq0i9c870w
 kWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743342431; x=1743947231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XgnXbfz5cIUtIQmdYamA54/5z1izjzp2XE1nuXTguPs=;
 b=UG82cwsiOxTDAOYGOOL3gGP+DITjEhY5uzbomI7/T5c0LNkhT2SiCGp1Icn5+TpaHO
 wgchEOhryv1QdL+4NvnzAys7YNpEbWEzUN708YObLnkEiWuuMZ+9xPcr6fQyk4fQRyXP
 JGC1ebMspv7Q68a5tD6VbB5o8pvtltwmI1dtUhcByNoq0GES0jgvd1mtjrpA/TliuI6a
 qZWOdcatTw76skweEG/NLI4US23ntTcuQ5O5Ue3FJekgWF3tScKdgh5H97h9tZF2C2VJ
 Hl8jjH+Rdi9QCpq+C0G3llwF5EJ0oAPDAOCexNlZgefqlBu/5OMrjYsoQW3dJ5hehmhx
 gNgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu8bJwpebRP3UwPmvxvwaGuBU511qoTtdCW0NZDEi+ppa2MaLPknSg8GtbGO3wqfBkmCY=@dpdk.org
X-Gm-Message-State: AOJu0YznlmNFivccAvidxsARjpVsfR1lJHjfHKy47AZVG1bS2Ng09bJ2
 CLDWK84b9jFLgBmjt6GVbz+dBWk1SCAigEwMJaZKSv0W+gX2l0C3vTsdDt2bLUQkSdswdaxEMYC
 076Y+PGuFsnZMmLsOUlEQbdKedf0=
X-Gm-Gg: ASbGncuVjVQb/gnup7CC+lEAdxnqbkJrQZHD9ZZI7a8cPVa9QNtLL03uVSx4TvDUlOv
 k6SfMEIRQGbH+rH3g6N64JaGJMTeqI/P3AB5iY20t6N4gIxPf1liNBiZ7trmfdED/eD0ApH5Bvo
 FoO8sEQ1+sA/uDaLyQTZJ3yzfLlUY=
X-Google-Smtp-Source: AGHT+IGWN+dy/RvCtAPvHWw6tt2M4lwm1JfYgh8xVNjkU6YzeUk9DHPfHpw1gArgnqTYVLHfR6/uEQab30fmV/AwpWg=
X-Received: by 2002:a17:90a:f946:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-30531f7c875mr7163441a91.1.1743342430596; Sun, 30 Mar 2025
 06:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241024110129.791362-1-mb@smartsharesystems.com>
 <20241104105220.1421305-1-mb@smartsharesystems.com>
 <20241104105220.1421305-2-mb@smartsharesystems.com>
 <f942d7c7-7aa6-4ba0-a624-384d11b118ac@broadcom.com>
 <a28fa969-d4fc-435c-945c-e510a70bf69e@amd.com>
In-Reply-To: <a28fa969-d4fc-435c-945c-e510a70bf69e@amd.com>
From: spyroot <spyroot@gmail.com>
Date: Sun, 30 Mar 2025 17:46:58 +0400
X-Gm-Features: AQ5f1JrX3RebtuUc6x6oFBg5pfhaZIgh-0wmUnqAlXoMlcHaDUFYzTFeW92ny8g
Message-ID: <CABsV3rA0zJYXShScu5i-zXM6L-UGhK4PWYDq3a4cNZWjXbM+ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/vmxnet3: support larger MTU with version 6
To: Ferruh Yigit <ferruh.yigit@amd.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 Ronak Doshi <ronak.doshi@broadcom.com>
Content-Type: multipart/alternative; boundary="0000000000004c390506318f8a7c"
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

--0000000000004c390506318f8a7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Folks, how can you bump them VMXNET3 version, and do we have a VMXNET3
unit test for RSS / Max mtu and 32 queue?

On Wed, Nov 6, 2024 at 8:00=E2=80=AFAM Ferruh Yigit <ferruh.yigit@amd.com> =
wrote:

> On 11/4/2024 9:44 PM, Jochen Behrens wrote:
>
> > On 11/4/24 02:52, Morten Br=C3=B8rup wrote:
> >> Virtual hardware version 6 supports larger max MTU, but the device
> >> information (dev_info) did not reflect this, so it could not be used.
> >>
> >> Fixes: b1584dd0affe ("net/vmxnet3: support version 6")
> >>
> >> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >
> > Acked-by: Jochen Behrens jochen.behrens@broadcom.com
> >
>
> Applied to dpdk-next-net/main, thanks.
>

--0000000000004c390506318f8a7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Folks, how can you=C2=A0bump=C2=A0them VMXNET3 version,=
 and do we have a VMXNET3 unit test for RSS / Max mtu and 32 queue?</div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Nov 6, 2024 at 8:00=E2=80=AFAM Ferruh Yigit &lt;<a =
href=3D"mailto:ferruh.yigit@amd.com">ferruh.yigit@amd.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 11/4/2024 9:44 =
PM, Jochen Behrens wrote:<br>
<br>
&gt; On 11/4/24 02:52, Morten Br=C3=B8rup wrote:<br>
&gt;&gt; Virtual hardware version 6 supports larger max MTU, but the device=
<br>
&gt;&gt; information (dev_info) did not reflect this, so it could not be us=
ed.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: b1584dd0affe (&quot;net/vmxnet3: support version 6&quot;)<b=
r>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsh=
aresystems.com" target=3D"_blank">mb@smartsharesystems.com</a>&gt;<br>
&gt;<br>
&gt; Acked-by: Jochen Behrens <a href=3D"mailto:jochen.behrens@broadcom.com=
" target=3D"_blank">jochen.behrens@broadcom.com</a><br>
&gt;<br>
<br>
Applied to dpdk-next-net/main, thanks.<br>
</blockquote></div>

--0000000000004c390506318f8a7c--
