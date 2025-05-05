Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8FC3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 13:58:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D19540264;
	Mon,  5 May 2025 15:58:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA3364025D
 for <dev@dpdk.org>; Mon,  5 May 2025 15:58:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746453524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPG4htdoPOQdYGsj+M8jUlW/ZFkgDp35ynflJSdmK6w=;
 b=ONMYt/SGR9z7Y+08pQYgWObNQxujmqZ5AhiJVtUefhO2qLnscs5hpGJJ9YM7p9Hxl/CMVO
 HqHtwj7jyOIsERmwkdHr1F/mVTLWZ9lrEQ+AI75elimHcZRZj53gzZAw7H+9l4kpviaTIP
 91079Y+1sctKeYokZntu/Q6WrpedUBg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-BPjFoNw8Ng-qIE0FUo9Yyg-1; Mon, 05 May 2025 09:58:39 -0400
X-MC-Unique: BPjFoNw8Ng-qIE0FUo9Yyg-1
X-Mimecast-MFC-AGG-ID: BPjFoNw8Ng-qIE0FUo9Yyg_1746453518
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30c13a6f641so23774551fa.3
 for <dev@dpdk.org>; Mon, 05 May 2025 06:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746453518; x=1747058318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPG4htdoPOQdYGsj+M8jUlW/ZFkgDp35ynflJSdmK6w=;
 b=kgnI8gesN5+EHRlf7CeBvCTn/zmjkL5lJWKHWrKGZXUizNwosPEuEUV7qfd1evawXM
 SCexq2r/rxi45hV9AhFkehlgiuaPsXwvGWLpPBpgaa4Ax4zVrT4mYwxsy94cICTNWCET
 sbfsPadBGqNfDeZ+6ElFSvr+3rITWb40HseuYbMQyG2SBPMo+E8jULfzj+Kvi16bW5ne
 OuU7kJ/7hmaTyZmvV5F23vLq4DjB/grZOnPEltSMy+hskVbkEGUg0+FNV/tDx+w9ock1
 5X+NF28HDrcOHM9GLWH6rHcJmNZ0nM0IyG/1BIeO4AmXtYmIeKOlop59vKYvhKeK3Jzh
 GpcA==
X-Gm-Message-State: AOJu0Yx5Xpgcp11ztIZwCn4306vW9XW5HhjyG34wL7Q+QNLQlt5c27yB
 xbMS0rTpqAkZx3e99Nfp5B5RGUNxIJmyNwnDD/QjGkJcZ52esXtYjRcpGi2sS4+DPGRdEd8N4c8
 KCTnm88SNSGpgRIPXVOcfZcRhh/s1jagczHgtU/jsdjNtHcWYQB6DB5r7akEmwhKMDvnfIw57Uk
 o+7R11GRZqhbterFQ=
X-Gm-Gg: ASbGnctBKLsTob+3uJRtcAU2l9b9RN7uA+FKkKGSvD/bAk4/zxS/RRjM4kIALsZDPLm
 ubRnEd/rhB6MlLsXYnwiHXlFWU7dllvYQehypQaCezQ6WduSL0LxlDBLc5TDHyVUV3VqzNkc=
X-Received: by 2002:a05:651c:19a5:b0:309:bc3:3a71 with SMTP id
 38308e7fff4ca-32351f25f49mr19708621fa.31.1746453517764; 
 Mon, 05 May 2025 06:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpO9811OL0aYPcL//zzUbiNFCAQC1gtk50qkl+CNYJfVxrp925Nhof2G8iaoFxbxBmXu82nc4hIWUVLXQyFhw=
X-Received: by 2002:a05:651c:19a5:b0:309:bc3:3a71 with SMTP id
 38308e7fff4ca-32351f25f49mr19708541fa.31.1746453517395; Mon, 05 May 2025
 06:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEmGFk9v4-QWRy1-N+jMkdM=iVv69xPRaKUzuxkTuD9OYJa5cQ@mail.gmail.com>
In-Reply-To: <CAEmGFk9v4-QWRy1-N+jMkdM=iVv69xPRaKUzuxkTuD9OYJa5cQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 5 May 2025 15:58:24 +0200
X-Gm-Features: ATxdqUHVpJRbTKJl-J-dkYKVdLoHth_CHqLx0kww2Gg0Voml-m2qs2A4kkMrn7I
Message-ID: <CAJFAV8z6yA39mF963hCRnKvLMfrtZWsOgyZ3sr5UuWOOn9d=qA@mail.gmail.com>
Subject: Re: Addressing ninja build error message
To: vivekanandi <v.o.s.openbook@gmail.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s4J3Y6dKUj5p0LeI8GTZ91IHNWIwZ_JzbyOxFWoSQ0I_1746453518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

On Mon, May 5, 2025 at 2:55=E2=80=AFPM vivekanandi <v.o.s.openbook@gmail.co=
m> wrote:
>
> Hello,
> My name is Vivek. I'm a Computer Science major from Canada.
>
> I was trying to install DPDK but encountered this error. I am familiar wi=
th BPF programming so tried to look into the compat.h file but the build/af=
_xdp directory was empty after I got the error message. I've attached a txt=
 file that shows the terminal output
>
> I ran the following scripts:
> meson build
> ninja -C build
>
> Could you please direct me to the right direction for building DPDK prope=
rly? I am on Linux Mint. Are there dependencies that I should've instaslled=
?

Ciara, Maryam, could you help Vivek?
Thanks.


--=20
David Marchand

