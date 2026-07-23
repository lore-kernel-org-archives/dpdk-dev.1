Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3179C531F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 17:35:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 098FA40658;
	Thu, 23 Jul 2026 19:35:38 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id B340740280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 19:35:36 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cad4170e8eso15073615ad.3
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784828135;
 x=1785432935; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hbOD4jxl67GvzSRfUwd1AdHtlb2dEd6VeVLHafv7V50=;
 b=XRWEr706nku+9gLf32MVzyj9im63wUVP1OXdcr1GGbf9MazaO1P0WeOv9hfA7Hgozg
 r0n5i7c3zBOPfVnTZetH5s/waaqf6GlEqrXdcFyHDHM1Hlq6sK1NfyGtltngqEt0t9Zn
 gkCWQgzq3H3kaFa6/lDsszIK04cXnxuRh3ZhIQ43VhlY9OX9iE/yiSTKlB2AOCYte1w/
 hWrk5Qw/Oo0snRxCH91jVt742pq9aU3oscZ4EdklKw8bRhSAC+S6xCsY5pJzgIVfwPml
 WWObsR7Ezw17CECfgBfEdk6Hrch/RGGWxUCXWwgXKXJBBeRPKIbO6EP1UZEQXmvnSjDR
 h2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828135; x=1785432935;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hbOD4jxl67GvzSRfUwd1AdHtlb2dEd6VeVLHafv7V50=;
 b=f8DiykNrfdWgQs3MxNkMGjiRFGxtWRNxZay6gWSfKnFaxwN/QtY48souey00sOycJf
 73kN9SP7wQyAOK7ELmgqm8bsrwGkM/jVBTDiCLeQ9v/PFMDfR5LLkSW3N2Gs0s1uAb2g
 s24uaAAIOp/LueEArtdgynlL0+dlOOu5YmLqWdtnQYLL3fFPpWJguc434ugPtq3sEkbM
 BubYv5VGI7cBLKEF1pWPcAoyvc59LwCYMlXhq3PEJLoB1jzeVDeLXepGTxUBWM8h9j1J
 d69WgymG1XThsrfshpt3K0RNajjWoDMIQCWg4srMl9pGGkGyAolDpVIEDmfNdkWxzm+p
 KkCQ==
X-Gm-Message-State: AOJu0YwhyYK6fYnUN5irUfVbr0oMmh8SzPQte88TcL34f+qIhKnRzapv
 zsMPaKFDdtdWGLMVK0O5FGSug31Ve5ccpvNqBxIhtryvklLG8IcU28r527DVNOmZGvU=
X-Gm-Gg: AR+sD10UD6ln05gug6+KsqXTSePCMY4d0cSj1TtXSP6LxAFATxcEL/U/+C11S/AwvMT
 8BD/IqmsY9u9SEbfs5gWAkh1eONGvzuPEYE0jCo5+T3mGVdzW74VRYDsQWQQw5ecJMYLTmjiYvl
 dlBFRur0a39kP+NCGXHsAdnGRNX/K55o1IHY1MUCqKaZOZ09HcL6AH6u5GOmx7gaTLf9WHWVeTd
 J/prGnXNJ5WGbPdyJt4/y098pTQs56OJQQ3jQjNz1p0rUTwIyarxHbxim75PQzpdl9GVfjpPeOw
 FBEeSPZGUd8HzTmNNum9mTg5z2S67saqHPybHDiqB1YqZB28t7quZ5eDCRtmJCoBsdP7jiJ3QHm
 6Z95HMU5fbl77I60uhaDVzvB52qhcfDycXOi5IwcA38cqyNMMI+gf/8WJYmwrwsq/xuFF2L8TEX
 wyMhZTgJIF7Qq7ARGOlJXrfV9rwdktc7i2JbK7Ro/K1UM=
X-Received: by 2002:a17:903:3c24:b0:2c8:1f58:55dd with SMTP id
 d9443c01a7336-2cfa6a43f89mr50159745ad.9.1784828135519; 
 Thu, 23 Jul 2026 10:35:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc1a67esm22554848eec.2.2026.07.23.10.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:35:35 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:35:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH v5 08/10] net/mlx5: pass maximum number of unicast MAC
 to common code
Message-ID: <20260723103532.22085253@phoenix.local>
In-Reply-To: <20260723124200.3069410-9-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260723124200.3069410-1-david.marchand@redhat.com>
 <20260723124200.3069410-9-david.marchand@redhat.com>
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

On Thu, 23 Jul 2026 14:41:54 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Isolate how the MAC addresses array is walked through in the common code
> by passing the max index at which a unicast MAC address is stored in
> dev->data->mac_addrs[].
>=20
> In the sync callback, the size of the array allocated on the stack is
> known by the caller, treat the mac_n field as an input parameter too.
>=20
> With this change, only net/mlx5 knows about the max number of
> unicast/multicast MAC addresses.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Deeper AI review found this:

[PATCH v5 08/10] net/mlx5: mlx5_nl_mac_addr_cb no longer accumulates across=
 netlink messages

The refactor makes mac_n a local reset to 0 on every callback invocation an=
d writes data->mac_n =3D mac_n (this-call count) on exit, while data->mac_n=
 on entry is repurposed as the array capacity.

mlx5_nl_recv() calls the callback once per nlmsghdr, and a neighbor dump de=
livers one RTM_NEWNEIGH (one NDA_LLADDR) per message. So with N MAC address=
es on the kernel netdev, the callback runs N times, each time writing to ma=
c[0] and reporting count 1 =E2=80=94 every address except the last is overw=
ritten. mlx5_nl_mac_addr_list() then returns 1, and mlx5_nl_mac_addr_sync()=
 syncs only the last address. The previous code kept data->mac_n as a persi=
stent running counter, so it accumulated correctly.

Confirmed with a standalone harness (3 addresses across 3 invocations): new=
 logic reports count=3D1, mac[0] =3D the 3rd address; old logic reports cou=
nt=3D3 at indices 0/1/2. Works only when the netdev has a single MAC, which=
 is why it can pass basic testing =E2=80=94 and it's precisely the many-add=
ress path that 10/10 then widens to 4096.

The capacity and the running count need to be separate. Keep an input capac=
ity field (e.g. add mac_cap to struct mlx5_nl_mac_addr, set from *mac_n) an=
d leave mac_n as the persistent counter that survives across invocations, c=
hecking data->mac_n =3D=3D data->mac_cap for the full condition =E2=80=94 r=
ather than folding both roles into one field.
