Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89042F45A11
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 22:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A8DD4021E;
	Sat, 11 Apr 2026 00:50:30 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id D9126400D5
 for <dev@dpdk.org>; Sat, 11 Apr 2026 00:50:28 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ad9516a653so12367735ad.0
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775861428;
 x=1776466228; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHAEyhXqfwODhyX2jJLk8azeqSUdZYJVVz1l79pEbMA=;
 b=cSkZA2Xd4zNajwAnn9J/bIly5o0ZOSbTtLg4ry13FenGg93ABVulYwsF97BANY6s2w
 DEWQojJcl+c87FJeXSbBsz9z5MTvI89GWiuFXXXbGXj8TL+47RU9SgCfsyKMtcHkS5TJ
 gOJmhEUsoLGCYCAPm5onmR2A2eitkMSPc10a1g4h3ZXaKW3S/1W4dOBFl4oHICUPKfFk
 RtpVR4qU8O55sponxS4q8wXxCLniWe4kIvZCrGeL/Kxor5HHkLvBF8ij9UhWq6xA+X0z
 TEv1kqEqZO3x6J7Gm3wzys0BDlUtBlanTAoSWMjkC7M/EBT3T4jZ1OHGvDfzzA1ItriY
 7exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775861428; x=1776466228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xHAEyhXqfwODhyX2jJLk8azeqSUdZYJVVz1l79pEbMA=;
 b=RmA67jYPbvfhZe4ifMRT0rGez93FoNeEoalj6YrUx2TK8hu34ev4OrWGSIM2o5f3Lr
 6n3Zfva4X9gb4vrUvdBJl4dZx9frT3jC9PgVcDr+wxB8OZa5115UUSzxct6c53udB2GP
 xAvMjs8XWcFrxfTPR2910w7ZiH4wJ6zwpnsTEq+WAcW4LKjfQBZTuple1caZ3B/UiPEf
 fIvgoz1U9H41uVX7Rpvsgb78YPjv3f7eh+gacZByHkqJ1WPLSn9b8tntVjaiaP+gexbW
 /zQEFQ2xXohdoNWO+HLP7VcJW+Ej4Q3WpoLmv2Ss56Rs7kZNN6VERg+3sL6Odpx4yTTv
 f81g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu6EHI1FhzAu5SBcpF/U6h8ql2sLCZEJSsyTCj0xadVfYtLoDMdDuVDyf76nnW2Ly7C+s=@dpdk.org
X-Gm-Message-State: AOJu0YwS/XvVhddZ76FgdG/jQqBQfyQItIPwbmrosKYdmVfrR88yokvA
 f4huwofLoZxf60TdmGqekWLKnpETNkgmEafmRgT0E59SjSAlxPLu/hpuFP9YrQXf1GM=
X-Gm-Gg: AeBDies7H4dM7SYM3eoE5bqtA/+e6efSDS2UXLAT6G33o5ygOv6KkBDbCZkqzaGS0Y0
 EvFISoM8Pepf475D+hB9wD4DsBpmGKabSG2Gy7HxNW3UZQbd/fY433Spw39i3Qo9/pVNBaRtTSP
 ldGYD3AhQYAEa/ZgNH9uTrhiRJRRZEZMogYQG9ubKZpcYwr+UbhArrDfgQosRoJhmX/kid+y4Gi
 YOCBlbR7bjHkgCaVxv745wMFpjo3Vpzgkl02V6X7JPiz4jKrDG403HAKEVAkmiBkuhlL38TSMyh
 pijHL8QhIgyAD7IOCPwXCjRWTFEUwfIO/cbcXC33LC9fHYEbwl7Qm/eY2ujAIkEDpaD39P00j/b
 cOl1JQLwMAf/wv6khDshmPhqqTlSLQCERepMu6dq+Icz0mQTJQ+8+ZhdQCu1j3am0ZgskadFXeg
 y+0pkFwuwO6OuF/ewRvcQRGV+pT04scX6ddhU=
X-Received: by 2002:a17:902:bcc2:b0:2b0:9c2b:641d with SMTP id
 d9443c01a7336-2b2d591af7emr38398705ad.2.1775861427851; 
 Fri, 10 Apr 2026 15:50:27 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f48d6csm52075085ad.83.2026.04.10.15.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 15:50:27 -0700 (PDT)
Date: Fri, 10 Apr 2026 15:50:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, David
 Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Robin Jarry <rjarry@redhat.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, Kevin
 Traynor <ktraynor@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "matan@nvidia.com" <matan@nvidia.com>, Wei Hu <weh@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3 0/7] Rework device probing
Message-ID: <20260410155016.521bb3d8@phoenix.local>
In-Reply-To: <LV0PR21MB6670C8CFBCD121494E58FEE2CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
 <20260410103717.5a52289a@phoenix.local>
 <LV0PR21MB6670C8CFBCD121494E58FEE2CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 10 Apr 2026 21:13:36 +0000
Long Li <longli@microsoft.com> wrote:

> >=20
> > We do need it because of the problems with vdev_netvsc.
> > The issue is that vdev_netvsc tries to setup failsafe on all netvsc dev=
ices it sees,
> > and it determines which ones are used by OS based on somewhat fragile OS
> > probes with netlink.
> >=20
> > I would recommend getting rid of vdev_netvsc, or make the the auto scan=
ning
> > there something that has to be forced by devargs.
> > But that really is up to the netvsc maintainers. =20
>=20
> Hi Morten,
>=20
> Can you use --vdev=3Dnet_vdev_netvsc,ignore=3D1? The ignore devarg is alr=
eady supported by the vdev_netvsc PMD =E2=80=94 when set, the probe functio=
n skips all netvsc interface discovery and returns early.
>=20
> Long

The issue is the CI runs on github (Azure) and therefore vdev_netvsc trigge=
rs.
Too much of a nuisance to change every test. The vdev_netvsc hack should be=
 opt-in not opt-out
