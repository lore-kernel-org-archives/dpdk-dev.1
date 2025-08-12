Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0853CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 12:50:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7111C402EF;
	Tue, 12 Aug 2025 14:50:28 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id C3A85402A7
 for <dev@dpdk.org>; Tue, 12 Aug 2025 14:50:27 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-7074bad03ceso65100736d6.0
 for <dev@dpdk.org>; Tue, 12 Aug 2025 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755003027;
 x=1755607827; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l9lOkPpXqjfIOHK5RIXvACDoT9f633BhVt8HqmCkdbo=;
 b=AzWNgKF+UAlZneTcrFbW30gJYOYumEm6da5uAZ8VKm/5O4hSfakMK0tWs4KaD3W5GN
 3nt08pJuBwpngkJCZokbVRmMSGaXsOvlfxXhYykWkJUxv+2wZs9P/K9xcXLigrnv108i
 B9732cvqutXyG1KwsExNBqeBAcYXDxQa/lN0e4nJssTfwQ6UeGFz/Hx3TmN7R8LFM+Om
 UbRsrcw4eTGWQNR1R9+xQ1pv/EmT2YKadjzO5WNJQllBCFGs6qn01wK6WCUc4LdLLFuv
 L0ZqE8eBfKyKi7B2ITvXQl6Z0NlIdNRfqAHjFysBB9sZUAbZ9ANXra9FZW7c/WFLNZm+
 JLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755003027; x=1755607827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l9lOkPpXqjfIOHK5RIXvACDoT9f633BhVt8HqmCkdbo=;
 b=HuAqZ2pzDi+Nq/5jvo0kVJqGP39KPLHyT/zHG85nvIX2g59OKAcLpxedK0UTJjUPHM
 rgpV4x91XXG4i0ly4m8u4OG78BvtKgHPCvwPE/Zuzsjih+v66oeSiUwUOGqXC2qFJKRU
 UQNJsIxHo7Ha3Scbhx9aoXNaPD41PPPXApzTCZMSbaGHP3NDQMSQyAtk/71kOETBOLIA
 sHOI3NAcawnuHIqVKRO9mht7TtwdE74JVenwI+nD0+2Vg8wg1wrg0mFjt5i1xPkkayh/
 3y2dox/zbjWtC62fcnzeIaech0PX7/OVJJo6QCjkMN2G//ZKASBSG36IRisK3jhO710u
 kAtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd5L25/lRZfIYxZW+9iEPkUm49YpJVO1X4kc19/O2yhHq89Z431dGnVwPGWva1Xil/yQQ=@dpdk.org
X-Gm-Message-State: AOJu0YxZYlrPsfd0+d7Ne2lGeWrf6kO8jBRJ6h9bZCOkF/1IQsyV7Yaa
 pbDtDmOybySIKeLZ00smypw+kb2ViySW7Daav7WHcPB/sF7WmRbdp19/ETjLxdCGBhJertlyTlg
 8koRAN5e/wA+5TH3E8n2K+Ln72L1ukfpui58T+693eA==
X-Gm-Gg: ASbGncurO7ZgCjtauv56O6Bt0wrsAZPPPRgwGEK87UiQh0P4ZdIdtMhSgw+APcqcUpJ
 icibIRnCJbx8AZAQvDpEX8P/N92oCMxviJ1XgBBRbvvfFQmAYHUV4ttnN2fd4BnpC+03WrNgjsJ
 BSuyxw4kpbqD3NRH5dGwT2u3jBrvMULRHxF8QNIIafy4uGzc3AEdycEHs/XDj+5bYIG9bcXKLKq
 k91
X-Google-Smtp-Source: AGHT+IHTwwy1SjVsgfDeaWVkUOWS8HZueOd31VNraxUGRiv9x6+ICXzZehzTA0hrVTYqi4rn0Hena4RFsKeUZSPvJzM=
X-Received: by 2002:ad4:5fce:0:b0:6fa:ab49:4482 with SMTP id
 6a1803df08f44-709d5e05126mr45045966d6.35.1755003027016; Tue, 12 Aug 2025
 05:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
 <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
 <CA++2-x5voCjMDXcO_jJw6vrmvtDzfPaAArABeAT9TGcVzXtoZA@mail.gmail.com>
 <20250811171834.fcyhsgkssyai5uho@ds-vm-debian.local>
 <20250812095145.qw3kl4vl3adc3esh@ds-vm-debian.local>
In-Reply-To: <20250812095145.qw3kl4vl3adc3esh@ds-vm-debian.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 12 Aug 2025 17:50:15 +0500
X-Gm-Features: Ac12FXwZ4hOE-fMFf6XM5WtIAUnER2qArBazFZlmVeaeCkvLWCI_2QmSTj_gkDw
Message-ID: <CA++2-x7M2JzG7F2MLWNVBSzOk7CAuuON08GyB14BASXGk1UmrA@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: ivan.malov@arknetworks.am, viacheslavo@nvidia.com, bingz@nvidia.com, 
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com, dev@dpdk.org, 
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000016843063c2a7c07"
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

--000000000000016843063c2a7c07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dariusz,
Thank you for the update. I have added a newer version of this patch,
please check it.
https://patches.dpdk.org/project/dpdk/patch/20250812124630.2916225-1-14pwcs=
e1224@uetpeshawar.edu.pk/

On Tue, Aug 12, 2025 at 2:53=E2=80=AFPM Dariusz Sosnowski <dsosnowski@nvidi=
a.com>
wrote:

>
> Khadem, please note this patch:
> https://patches.dpdk.org/project/dpdk/patch/20250812094323.712559-1-dsosn=
owski@nvidia.com/
>
> This would allow you to inspect the conntrack action state
> through the following testpmd command:
>
>         flow indirect_action 0 query <action ID>
>

Thanks & Best Regards,
Khadem

--000000000000016843063c2a7c07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Dariusz,=C2=A0</div><div>Thank you for the update.=
 I have added a newer version of this patch, please check it.=C2=A0</div><a=
 href=3D"https://patches.dpdk.org/project/dpdk/patch/20250812124630.2916225=
-1-14pwcse1224@uetpeshawar.edu.pk/">https://patches.dpdk.org/project/dpdk/p=
atch/20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk/</a><br><br><d=
iv class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Tue, Aug 12, 2025 at 2:53=E2=80=AFPM Dariusz Sosnowski &lt;<a =
href=3D"mailto:dsosnowski@nvidia.com">dsosnowski@nvidia.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Khadem, please note this patch: <a href=3D"https://patches.dpdk.org/project=
/dpdk/patch/20250812094323.712559-1-dsosnowski@nvidia.com/" rel=3D"noreferr=
er" target=3D"_blank">https://patches.dpdk.org/project/dpdk/patch/202508120=
94323.712559-1-dsosnowski@nvidia.com/</a><br>
<br>
This would allow you to inspect the conntrack action state<br>
through the following testpmd command:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow indirect_action 0 query &lt;action ID&gt;<=
br></blockquote><div><br></div><div>Thanks &amp; Best Regards,</div><div>Kh=
adem=C2=A0</div></div></div>

--000000000000016843063c2a7c07--
