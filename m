Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC28C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 14:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA67D42670;
	Mon, 10 Feb 2025 15:05:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B258040268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 15:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739196315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQom/DiQ4VyQ8tKsqJNzet2Vmk3G/NFfqAgHSL8VI5Q=;
 b=f0cX+wJvU8ipw5gyH25Ss2J/4zXRxSDhxFzdIL8Q6PqJ2TpiMt9IhKYxV41EV4XI0xJqm9
 mmrPNygUMoqvcJAY6Qkqt6517KKTLv+/XAzEMhJiovt/85rtElM4Hqy9p8tjOBCbsGk2uy
 mPhGrgrQHw/sBr7BbxYtYIwjjV/x1R4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-D3irrD-4Pm6VTWoW2aIQCA-1; Mon, 10 Feb 2025 09:05:14 -0500
X-MC-Unique: D3irrD-4Pm6VTWoW2aIQCA-1
X-Mimecast-MFC-AGG-ID: D3irrD-4Pm6VTWoW2aIQCA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fa6409c0baso4142779a91.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 06:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739196313; x=1739801113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQom/DiQ4VyQ8tKsqJNzet2Vmk3G/NFfqAgHSL8VI5Q=;
 b=NahdxCC13oHcAw4TNIsJ+ehfrXdmbOGg4psDbNbPCI4+nnAB7cOb0ADp76zS6Oq2uz
 qa/NdiAh8SUMjMytkqVCdYCjq0CeytbMAl2IJr51Hfh0sMmf3B4cRKfYeMlzQpbAi6xI
 OpjY93ScGFSs6GYpOrUx0WZemNykQiYMCL2P21eBrmMt0orcOa/Qy9KGG9wnVLQxolIh
 ilQyhTAH2DivQ5nSQFT8qUq7fLRKQbOTt3VXvLyek2z96LBG6MNeHcNgjQcs4SWMDU+c
 3ZJ2QePFpaZ4/smzrdDUaQVmfvErI87pnzczC+dGX34FL/BO/g/zieQERe78hW++kgdW
 wwfA==
X-Gm-Message-State: AOJu0YzwzXUAWGhSMihJJWod7war0Ca/JWeBFsJfQjuxSV3u5ZybhpCf
 m1jRdEGH65Q30nTewfGzSh5/Mqdv2Bu4N2c7Pdt0nCOjvujQIlO4AsG0F3wXGs+oIpVjd0n+MHj
 yNWJH0NyZZqc4utqfhB8Qp1lJ0Fvxa6xwi6pvlQ51fyxKDe2PDXJqMRJ3Fkd9G3eBg3reMiy1qn
 sbToO/SGdVTSQXAkk=
X-Gm-Gg: ASbGncu74yFb1SbRHk07P3KJ5Euof1fzNOfPxXTuJOjMWQ3zWZ2bzUW1gZPIEj8ZWQN
 y+K4Im+btflUNT9emPAt3DX/ZLJh2LBZra9r2Lq2ySerLIHgYN2kETE5AJj8POAH2
X-Received: by 2002:a17:90b:278c:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2fa243db8e7mr20437064a91.27.1739196313030; 
 Mon, 10 Feb 2025 06:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLC8RAiPboyK9xjPjke6tUeWjF8OJxjtETfFlm+ijDqZYoqyEJTBivBGaHVs0AX+xd1HeEvMg9ekxRlkwHyCQ=
X-Received: by 2002:a17:90b:278c:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2fa243db8e7mr20437023a91.27.1739196312545; Mon, 10 Feb 2025
 06:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250130145849.82003-1-david.marchand@redhat.com>
 <20250130145849.82003-3-david.marchand@redhat.com>
 <BY3PR18MB478513EE8560354EAF1D48FEC8F22@BY3PR18MB4785.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB478513EE8560354EAF1D48FEC8F22@BY3PR18MB4785.namprd18.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 10 Feb 2025 15:04:58 +0100
X-Gm-Features: AWEUYZkzKLymFfSRFn2QVSfD17SGgD4VUetVp_x0qnX4MDbxnol852P7xc_6N1w
Message-ID: <CAJFAV8yqd3Dh7gs61kyzuA0YbtqxDstrcWF_jfoRyqY6Wvn9bg@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v2 3/3] trace: fix undefined behavior in
 register
To: Jerin Jacob <jerinj@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sx7o_TF0IPnfFo1Mp1JUAKTHmk6QB0u0rivUiHkRFNw_1739196313
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

On Mon, Feb 10, 2025 at 2:37=E2=80=AFPM Jerin Jacob <jerinj@marvell.com> wr=
ote:
> > +
> > +#define __RTE_TRACE_POINT(_mode, _tp, _args, ...) \ extern
> > +rte_trace_point_t __##_tp; \ static __rte_always_inline void _tp _args
> > +{ } \ static __rte_always_inline void \ _tp ## _register (void) \ { \
> > +     __rte_trace_point_emit_header_##_mode(&__##_tp); \
> > +     __VA_ARGS__ \
>
> I have not tested this code, Will this calling __rte_trace_point_emit* ve=
rsion of register?
> If not, CTF spec file not generated properly.
> https://github.com/DPDK/dpdk/blob/main/lib/eal/include/rte_trace_point_re=
gister.h#L35

Yes, there are issues with this series that I did not catch until recently.
This will be fixed in a new revision (that will also add babeltrace
calls in CI..).


--=20
David Marchand

