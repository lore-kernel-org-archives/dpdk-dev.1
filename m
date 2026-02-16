Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2231E8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 22:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D595440289;
	Mon, 16 Feb 2026 23:11:10 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 2618E4026C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 23:11:10 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4362c635319so3597052f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 14:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771279870;
 x=1771884670; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3MS98eDXnvOoSNPF5UUmJqUPPsIqjdRSGj4HePEME4=;
 b=WKprcIMhNcPLRcmAByJM64xfKoKHLMMJAeVKxHZPnG+wPUbUNIvxQbWGpMgMCu4Lhn
 P2CqtSNrtdTrWmAY/U8EudTEiOsYw3ZzG1jdQ54/xrV9ziiOOpB7aWxQk4l0UC9gKYze
 Kstk6JOWoiFMMAy4TakX2qqtC3UjF+Umt2CGhMf4Wrlk0TV3ajWqg2jWO2mp/Yenarv0
 Jq4yAGi5XcDGDxMF+pDDr2C0FOcZxbeXuVOz3KXK8oHbZADgUu/8ZERyEYYdPLG4ph4R
 3mMJFR8Z6loDV+LsJMb+0Ysz8s4BqtKU5RUXUJmhP6ivDVge6OuYc9B9uVcoFwiYQwgd
 8cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771279870; x=1771884670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z3MS98eDXnvOoSNPF5UUmJqUPPsIqjdRSGj4HePEME4=;
 b=rOz3WAmxcaI5XvTcaWkeOqsLDq0iHdHOMSqheKHHVjQPDshZ+HxQNWQf2rzraROTF8
 0fllvA2KaL0/4QSiZTRToL9cC5paKqF6GXecPYxF4BjUVZBSzAunxOsoMnOR2EfcLYux
 2rtu61Yy73i4k5zdxbEUDfpojpP/91lR+2ihGLh5IJ0lr94j5TrD5iMOFzfaKqZBHfR+
 zIyuMRn7AQpIdI9OqDgs3rU0iNN0WkepdkXiBrkBuNOUXwSdJWBPAxZOxY8GqDO3fup6
 X2EwetcBiRkoUnA9gfvz1AeARyR/4wivxw+72fR7jzqj2HYbi4zlb2D8qSOPaCWTQjbF
 bNHw==
X-Gm-Message-State: AOJu0Yw5PuQliaUnM63OuXNfzkNp1+HH/KsfoF86+ECk0kG60U6fGU5Y
 yI4SJ00oAwRwHSutZltw/J52lC90HlCcWuruWDSoJsGzontH6s0KqmERf/WkkY0PCUM=
X-Gm-Gg: AZuq6aLOouKlGx8hGf60vwe5t+x/+zEzrCy+6ejqKx3QNjGjiuzp95aHdSXsVHQVajh
 OxYB+SDuCgxqiD3uTJG1MhD2bDW6gc6Q5Dd0/LKSQ9IkPB238qd+PkQX8cQDiXg+glLg4KE9aRO
 AFgod9sBBg5Y7oPxZ8boGKv8xFccwx2VOTdWhM3GG/8386otVW19Kr0I4WDbbXoQS80ecu4oaZb
 TENxVN9r5ejhJEUPFrfp1B3id7LqZTrWMgOElNC1sNhOn6KVQ7XEEdgxkbepMstvHOivPLokhZg
 3xQqgOMj9ecCny/jdOqSWY+vFd03e1xu3hWcgwyY22yA6ITk/ci8EC+kicqzvLFNfmlZ8+seS4U
 fj0ewFnR38sX7ZwSE/W1d78SX1qtEZT0lT1N1jG89eS8cpMI5Pdc5AOUfr2AvBZKiTCRvpLEpKg
 ycCBEc+5O3rlAFVuOUkYjEl5sGoTJhvOC0kHPAcdD9ZW0M9346GfM3rryHw7Oa6+L5aV8wYA0KQ
 iQ=
X-Received: by 2002:a5d:5d05:0:b0:437:6bbf:71be with SMTP id
 ffacd0b85a97d-4379792be7amr24602906f8f.42.1771279869616; 
 Mon, 16 Feb 2026 14:11:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acf5b9sm27340269f8f.34.2026.02.16.14.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 14:11:09 -0800 (PST)
Date: Mon, 16 Feb 2026 14:11:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 0/8] net/nfb: rework to real multiport
Message-ID: <20260216141104.5055879c@phoenix.local>
In-Reply-To: <20260216162506.2702066-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260216162506.2702066-1-spinler@cesnet.cz>
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

On Mon, 16 Feb 2026 17:24:58 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This series implements real multiport for better user experience.
>=20
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
>=20
> ---
> Depends-on: patch-37245 ("doc/nfb: update release notes for nfb driver")

After some feedback to the AI review. It still had minor feedback, do you w=
ant more detail?
I can take this as is or you can send new version.

NFB v9 Review Summary
8 patches, v9 =E2=80=94 Martin Spinler's multi-port NFB driver rework. Over=
all a clean, well-structured series.

Warnings:

Patch 2: If rte_eth_dev_create() succeeds but rte_eth_dev_get_by_name()
returns NULL, the created device is never added to the cleanup TAILQ
and leaks.

Patch 3: nfb_default_dev_path() return value used without NULL check before=
 passing to nfb_open().

Patch 4: The kvargs callback returns errors from input validation (e.g., ba=
d port string) but ifc_params.ret is only set after nfb_eth_dev_create_for_=
ifc, so the caller can overwrite the real error with 0.

Patch 8: Release notes don't mention the new vdev/simulation support from p=
atch 3.
