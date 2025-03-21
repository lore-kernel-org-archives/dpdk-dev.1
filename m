Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DBAC36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 15:53:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDC2640B9D;
	Fri, 21 Mar 2025 16:53:13 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1A6DC40B9D
 for <dev@dpdk.org>; Fri, 21 Mar 2025 16:53:12 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2264aefc45dso17033695ad.0
 for <dev@dpdk.org>; Fri, 21 Mar 2025 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742572391;
 x=1743177191; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBycOz1CjBNm+/tDRkBF9sBGJfBdz8otknmpWaP/IWY=;
 b=Hd4+6mk4BPiQLRC+R/RfXcUC88FO/Vn9QQcYrC4O70zLGz1ZoocFC0yybueBuioaWf
 ShSBuSnrcBMujppylnNSDntLwl8XbNpHqpF1qsNt7S32mFNFq6ThlH3x2mapT5zUCU4h
 ScI8F7ZIgFSPZOmAaYGhGFsk/g0gSak9BVCDeed+1+oFBFdnlqJJUS9Gd+qxu8ULDTIe
 IvYx66MeEYOTzXOJg7BJQSDSSpoQHODVcP75Q/y8c3oOtFwIwye00sUsQN84DLAvilKl
 nKhcJhKL4+VtJBJUV04u95TPNwpHIWWkSYjyFuqubmKNrur0kmZNHbwyKKjbioMGuGab
 Wrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572391; x=1743177191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBycOz1CjBNm+/tDRkBF9sBGJfBdz8otknmpWaP/IWY=;
 b=me6KM0Z1H96fYKlTfoPuJyd8PSCQvMnw7fSBJ9vP7f7PFZFKPTG3vEJg45Gm3+WdDR
 7gvp3KJMe5S7nHF5jDt6ihnDQIUkJ3idEhUP2g3lN9X7FVlIFltdDcePJ4bmZbVIfktn
 Uike1JuwF9Aaf3qvV0CUDUWPqq4qjWucn363DTMY8WkYvJbjarX1LYDm4hiCpi4RQlrK
 2j4vx8rPla/SLmnAkR6vCbO0fxDZBYVUPTGYsbbpisM6efYbijBZz1rxnnL6Y/dNNE3t
 B3jD8grQT8TIczmDT+wXNpLoIzq1xV8EaI6God+Iuqo/vTDjMDdnimZqKN1KMA/4cmDW
 aWkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqG0cuNEzcwc4U1VzFCBEjhhYivc/XNKWxGQXAcuDsE1FLfCVHa7bKvjgE0kIwUsXql2w=@dpdk.org
X-Gm-Message-State: AOJu0YzDmZOIeSLYRzZHgEAt5LgLqF4bg4Re4zARiNkMTzTMptHg7QiO
 mjdwjEZcvpjUxwaYoli3K+NNOOK50ws/KY61OSoSDjFRIWpRVF5OpokI3HeW/dM=
X-Gm-Gg: ASbGncsK9uApQ+K8MRm8U5QDEtQD2pZKsGDdP/perN0lqsdPulED7pWB7OF7na1w1zi
 lYM0ICP1wFCSgde6KlLxhkvGLO6ijVKlBsiruuOYyNPSgOsAgeNJ7f/V4T2ZElVioiR9s9QsHp8
 kDJuLaKTaPPqwHQOv5jAdEXDTwbTcwEaY/rDOx6FTWQ/exxBIqxO6ldkjKFhIHWeDpGrLCkyWL7
 6tbBf4nS23XE8IHf4z4POxqnbV6nkZL2CX17ejtIwSQcsTLSrYa/7ouV2tTLjgg/TlpoTUjpg4y
 O/TLTf9q3DOtxw+utr3KBpw+msIUIQConf1JkVv1bB9O/4NcP1OHhe7Etppk2O6dueIp5zZgcwK
 qIhhJ+krqZtiaFKP3UcsmKQ==
X-Google-Smtp-Source: AGHT+IGSS2SD+ayTP3r6QrchLRW+J7pAYjWftJMaSWjPIRmZu3+5U6mlLExfltoO9yw3tzL2SAjT3g==
X-Received: by 2002:a17:902:cec8:b0:223:668d:eba9 with SMTP id
 d9443c01a7336-22780c5587bmr78586165ad.10.1742572391107; 
 Fri, 21 Mar 2025 08:53:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f45f35sm18594965ad.90.2025.03.21.08.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 08:53:10 -0700 (PDT)
Date: Fri, 21 Mar 2025 08:52:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Cody Cheng" <ccheng@iol.unh.edu>, "Kevin Traynor"
 <ktraynor@redhat.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 <techboard@dpdk.org>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, "David Marchand"
 <david.marchand@redhat.com>, <dev@dpdk.org>, "Ali Alnubani"
 <alialnu@nvidia.com>, <galco@nvidia.com>
Subject: Re: Clarification on Minimum Supported Kernel Version for DPDK
Message-ID: <20250321085259.095bd234@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
References: <CAMEVEZvCoVpMjFpmY29-x0zB2tQvNrJsTacs6-Zzx4jJB_GsoQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
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

On Fri, 21 Mar 2025 07:28:45 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> @Kevin, @Stephen, @Bruce,
>=20
> I cannot reliably answer Cody's question, and it may need further discuss=
ion.
>=20
> What is your opinion on minimum Linux kernel version requirements?
>=20
> @Thomas: In the future, the DPDK release notes should mention the minimum=
 Linux kernel requirements.
>=20
> > From: Cody Cheng [mailto:ccheng@iol.unh.edu]
> > Sent: Thursday, 20 March 2025 21.28
> >=20
> > Hi Morten,
> >=20
> > I am in the process of setting up a test environment at the UNH DPDK
> > Community Test Lab that follows the minimum supported kernel version
> > for DPDK. According to the DPDK documentation, the minimum supported
> > kernel version is 4.19. However, the oldest long term stable kernel
> > version listed on kernel.org is 5.4.291.
> >=20
> > Should the test environment be set up on kernel version 4.19 or
> > 5.4.291? =20
>=20
> The kernel 4.19 support stems from still supporting RHEL/CentOS 7.
> I wonder if this exception mentioned in the documentation [1] is still va=
lid, or if we should bump it to RHEL/CentOS 8, which ships with kernel 4.18=
 [1].
>=20
> RHEL/CentOS 7 support was discussed at by tech board long ago [2], but I =
cannot find a conclusion about the kernel version; the discussion was mostl=
y about compiler support.
>=20
> [1]: https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-software
> [2]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/=
html-single/8.0_release_notes/index#overview
> [3]: https://mails.dpdk.org/archives/dev/2023-February/263516.html

My opinion has always been that DPDK only offers certain guarantees about t=
esting:
  - oldest current LTS
  - oldest supported version of Redhat/Ubuntu/SUSE enterprise kernels

after that in the embedded space, the user is likely to be ok but any kernel
related issues are their problem not the communities to deal with.

The two parts most likely to cause issues are vfio-pci and vhost related st=
uff.
There is also small chance of issues with the memory handling in EAL.

