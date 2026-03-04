Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF37EF8FFD
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:59:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C518402A9;
	Wed,  4 Mar 2026 16:59:55 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 567B44027F
 for <dev@dpdk.org>; Wed,  4 Mar 2026 16:59:53 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cb40149037so725236585a.2
 for <dev@dpdk.org>; Wed, 04 Mar 2026 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772639992;
 x=1773244792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLqICM591PtdD9tUe93vz35Fs9dCN8tuX8j/3uv+ePI=;
 b=JWYfi9QkgIpIFKgJg9TM97YQ+RYVO+1TN/2hufdMxLkqBmnlUQtmtDXKnM1to55uvR
 O5W1zvggbpUMol7Ed6dEHg+ODCNUh/hg5JVSU4Dq+2g9610Cnho/bbqNvac913yTtaKd
 eLcaHi4LvG4SzJ//eWqALcMo1Sp67GznUEJUIXsyc/LU2bPnNymEBljOr9dLXL/SNYiK
 D/EXF1Vqio+0el0KIg1m2EA6UapDT8U18a/6upFHQbSZ/2HkyxRHL+jQ0h7RrrOeaFAa
 hhSoNoOikPeb71kPnVuu9oBAZ5BjObw6vhUxj/NP7yejyFCGpSIbcQ9blM4clK1aJOac
 amqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772639992; x=1773244792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gLqICM591PtdD9tUe93vz35Fs9dCN8tuX8j/3uv+ePI=;
 b=Cq+OIroPn+bEsjraHw3FS2GVaG471k4WIX8APGK5y++gcz6A0VQlQ3FXUFp+ruhvyX
 NKq7J6QdArdvaVs+T/iiYdpmzsVhQqIz1yun30PlX6/ZYoIUNfjtA/ooMObDjMIy7xvb
 ctE7E2Jshnd0NpnkDADWLk72HJNopVazCcFnFxCIyM96Wfl62AOqTV+BJ1Q4WchnPi24
 VQuzoYu4TQ649404KOZTBk87k0iyuxcd+JFuaLb4+vRtVkShGiVyCURlXgCgVSRT/fwd
 4ZtUJRax8kXwKWePeNZFXJhqB0WxN/txqiffGtMTUiLnQNJYZ33vbzkzkZNctLz+4YVN
 OptA==
X-Gm-Message-State: AOJu0Ywvdt2Hk6TzDBKF2w0UwbE569/I1rjvud6eqSlKnb6tLJE48IGU
 WHnAlYmDjS81UkDw6gewhtGIFnwn1Z8Eg+1OrPhSNDXr+dt7BLS0HuYdxlMzOvWQcVE=
X-Gm-Gg: ATEYQzydNdGZ7eIVu5f/7cmjqo2geDDkAPW/ZY+8LgaF/oZv7U77ol+kToSQJaassSD
 XCFUt4nnykEz+tmF1gX6SxTuGSCm/nxfsCxZFhuQuRHv4tMNxoIMcKoBo2rMgukrZm+tS7kFVTr
 76D8GiAtB6YJUYU2KVFrbbkjG6t2SHqbSjv+kOVyGQl9dT25rhgTl5AA7Gq/pz+eR+m7mHsVo9z
 2YDMW/nqWCm3j0gY3fok2MDlRF9DpG2o/8PqA92KkN4vAYNxNZZjEgKceuyp2apToaDWLjXA0qP
 Zo1Od6sRHUYszJ9sMnm49sLe1gXrLRB+aCgWgg0a+DGibctjyduF9f36QhkuFHAikahDM7jA+6S
 hfMaFVDX8lHWpt5OS4wCf39Xy0Yn4LLKNauJoz5xKhEeJiqsCBz6Ik66l6EYU73asuvOwxE5Lx6
 X8ryOk2vKYv7Z60Jg8MtiGVPI+6GzJW3OS6bsK+DGJ/bcplMzQokVH/UdBS5maqfBo
X-Received: by 2002:a05:620a:2847:b0:8ca:110b:38cc with SMTP id
 af79cd13be357-8cd5aefc668mr304188385a.27.1772639992360; 
 Wed, 04 Mar 2026 07:59:52 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf717f2bsm1649768585a.35.2026.03.04.07.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:59:52 -0800 (PST)
Date: Wed, 4 Mar 2026 07:59:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH v4 0/4] net/gve: add flow steering support
Message-ID: <20260304075949.07e75d93@phoenix.local>
In-Reply-To: <20260304045033.1340269-1-jtranoleary@google.com>
References: <20260304014624.1297874-1-jtranoleary@google.com>
 <20260304045033.1340269-1-jtranoleary@google.com>
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

On Wed,  4 Mar 2026 04:50:29 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> This patch series adds flow steering support to the Google Virtual
> Ethernet (gve) driver. This functionality allows traffic to be directed
> to specific receive queues based on user-specified flow patterns.
>=20
> The series includes foundational support for extended admin queue
> commands needed to handle flow rules, the specific adminqueue commands
> for flow rule management, and the integration with the DPDK rte_flow
> API. The series adds support flow matching on the following protocols:
> IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.
>=20
> Patch Overview:
>=20
> 1. "net/gve: add flow steering device option" checks for and enables
>    the flow steering capability in the device options during
>    initialization.
> 2. "net/gve: introduce extended adminq command" adds infrastructure
>    for sending extended admin queue commands. These commands use a
>    flexible buffer descriptor format required for flow rule management.
> 3. "net/gve: add adminq commands for flow steering" implements the
>    specific admin queue commands to add and remove flow rules on the
>    device, including handling of rule IDs and parameters.
> 4. "net/gve: add rte flow API integration" exposes the flow steering
>    functionality via the DPDK rte_flow API. This includes strict
>    pattern validation, rule parsing, and lifecycle management (create,
>    destroy, flush). It ensures thread-safe access to the flow subsystem
>    and proper resource cleanup during device reset.
>=20
> Jasper Tran O'Leary (2):
>   net/gve: add adminq commands for flow steering
>   net/gve: add rte flow API integration
>=20
> Vee Agarwal (2):
>   net/gve: add flow steering device option
>   net/gve: introduce extended adminq command
>=20
>  doc/guides/nics/features/gve.ini       |  12 +
>  doc/guides/nics/gve.rst                |  27 +
>  doc/guides/rel_notes/release_26_03.rst |   1 +
>  drivers/net/gve/base/gve.h             |   3 +-
>  drivers/net/gve/base/gve_adminq.c      | 118 ++++-
>  drivers/net/gve/base/gve_adminq.h      |  57 +++
>  drivers/net/gve/gve_ethdev.c           |  83 +++-
>  drivers/net/gve/gve_ethdev.h           |  46 ++
>  drivers/net/gve/gve_flow_rule.c        | 658 +++++++++++++++++++++++++
>  drivers/net/gve/gve_flow_rule.h        |  65 +++
>  drivers/net/gve/meson.build            |   1 +
>  11 files changed, 1066 insertions(+), 5 deletions(-)
>  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
>  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h
>=20


Applied to next-net

The detailed review report if you are interested.

Reviewed the v4 series. Overall this is well-structured =E2=80=94 locking
discipline is sound, create/destroy/flush paths handle errors
correctly with proper resource cleanup, and the bitmap slot is
restored on adminq failure. Patches 1/4 and 2/4 are clean.

A few items on 3/4 and 4/4:

Patch 3/4:

  [Warning] struct gve_flow_spec has a padding hole after the
  tos/tclass u8 field (37 bytes of data, padded to 40 by the
  compiler). Callers zero-initialize today so no live bug, but
  consider adding GVE_CHECK_STRUCT_LEN for gve_flow_spec and
  gve_flow_rule_params to guard against future changes, consistent
  with other adminq structures.

Patch 4/4:

  [Warning] In gve_setup_flow_subsystem, the rte_zmalloc failure
  path does goto free_flow_rule_bmp which calls
  gve_flow_free_bmp(priv). This is safe (rte_free(NULL) is a
  no-op) but misleading =E2=80=94 the label says "free" when there's
  nothing to free. Cleaner to just return -ENOMEM directly on the
  first failure.

  [Warning] gve_dev_reset tears down the flow subsystem and
  re-initializes via gve_init_priv, but does not destroy/recreate
  flow_rule_lock. This works today because
  gve_teardown_flow_subsystem doesn't destroy the mutex (only
  gve_dev_close does), but it's worth a comment to document this
  invariant.
