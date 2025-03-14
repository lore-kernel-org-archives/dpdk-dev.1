Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3699DC35FF1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 15:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9643C402F2;
	Fri, 14 Mar 2025 16:38:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6931E40289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 16:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741966736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gl/I6BeM9UQ/40P8xXfBUyuQkkRQTZanzDf3i/muwE=;
 b=MXi+GUtOTmTbtG6qG17a0Kx/vlVG5IpLtPwpwoU+C0T8SrRCTKUkluFPWxQVEPu7+Hqd5k
 9le+YBGDrDh5d1z09zIK4jE0OJJxUhQhNhte80sHjlkWuxC+W9o9AegyDpuEG2hlsumrIw
 SHqgzEs7x8anQLRgfVdypkcl1dEuNqI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-DA2LAtAVMICvvGG2pgDYhg-1; Fri, 14 Mar 2025 11:38:55 -0400
X-MC-Unique: DA2LAtAVMICvvGG2pgDYhg-1
X-Mimecast-MFC-AGG-ID: DA2LAtAVMICvvGG2pgDYhg_1741966734
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-549979903c8so1207364e87.1
 for <dev@dpdk.org>; Fri, 14 Mar 2025 08:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966734; x=1742571534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gl/I6BeM9UQ/40P8xXfBUyuQkkRQTZanzDf3i/muwE=;
 b=gdlB0+ZQKBFbLCp2yoZcJuIBfSmMZfRf3J2tk01OiBF9V8lwEuPzj1s5Q9RFnJw+ao
 ye3cUxWWx33xX1WdPRnAUV/nPLbzL+p1B3vbOScq0xySsvXq7n2NUVNM3RoiXP23Nh1+
 muJxm3MP0+A9xLHuSv3zllWTIdBLg5p4jihT7FzV8jfwg/wtebPfY2Sklq1gv1wcTxFe
 gjm7ZdfFyixZWcpgYonEDmS3MbVw3VkHUsbVUokMQQlyu5pjk9ih5dUJJ+Sn5nYqQy6o
 ydtxrV5FT+9ZUAzrQ9zxORfpPynF5YmI7PCNK6z0cpPLB/88CBDXL4UZRgA8dwqdO66P
 tIFg==
X-Gm-Message-State: AOJu0YyyKy/mq0s5mdr8eXjOkhYSS/vkH4/egEE3GdtMAC4P/eFvL7y9
 MbL/OUZVRhjPX01eL11DPrfSt1sWs3B2gi/IfOa903axBWQIYPgG2AVyFnDadCt4Be2VB2C2Fjk
 CUbhgph5JHgCGMPEkGnOMTmiX7Wu3rBYeju0hUpzUqn0x03FVFQhV9NZvSHobH1n2mEQigpPWpG
 gH+C4UuONtvH9ABu0=
X-Gm-Gg: ASbGncvFxgwqV4CBrf8+7TFy5fWemjwbgCQRQCOXnXvoQum7/k/Qa5Nlq1h0qKTAgHJ
 A1MOzSul95pfm3kPY8WGnEq6qnec78nmy5twaDqlKzTFEFtT0MV0vFJBnev/+CDOIhwsyry1wzf
 0=
X-Received: by 2002:a05:6512:3091:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-549c3989ac9mr1263243e87.49.1741966734017; 
 Fri, 14 Mar 2025 08:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8d9v7GdfjR9mcvsPpQ73rQWrTL/M+pc2Anc9YPyLf92bBHFtQKjJdlDQccDiyF+qOV/F4i1pysiY8VBKmhOY=
X-Received: by 2002:a05:6512:3091:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-549c3989ac9mr1263233e87.49.1741966733680; Fri, 14 Mar 2025
 08:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-6-david.marchand@redhat.com>
 <3431217.izSxrag8PF@thomas>
In-Reply-To: <3431217.izSxrag8PF@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 14 Mar 2025 16:38:41 +0100
X-Gm-Features: AQ5f1Jo1GUQP5gB-VRHUDnMzLwu_ARvzRu8m7bVSG77l1Y-wWr0I135u-dGvphE
Message-ID: <CAJFAV8xcfTjKLoAwWj2JPboytXNRqut3_Eyn5FWHFHEd2--G3g@mail.gmail.com>
Subject: Re: [RFC v3 5/8] build: generate symbol maps
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BQi3Loa-kbr-YqEc56pyBabQjZ_XRWewDWWzHCCuMYA_1741966734
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

On Fri, Mar 14, 2025 at 3:24=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 11/03/2025 10:56, David Marchand:
> > +        if is_ms_linker
> > +            link_mode =3D 'msvc'
>
> It can be MSVC or clang.
> mslinker may be a better naming.
>
> > +        elif is_windows
> > +            link_mode =3D 'mingw'
> > +        else
> > +            link_mode =3D 'gnu'
> > +        endif

+1.


--=20
David Marchand

