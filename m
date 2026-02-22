Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8367EC636B7
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 19:48:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 752E5402D8;
	Sun, 22 Feb 2026 20:48:48 +0100 (CET)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51]) by mails.dpdk.org (Postfix) with ESMTP id 60AEC402B8
 for <dev@dpdk.org>; Sun, 22 Feb 2026 20:48:47 +0100 (CET)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-40efc77933fso2465148fac.3
 for <dev@dpdk.org>; Sun, 22 Feb 2026 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771789726;
 x=1772394526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Vcv4RD0c4PHuswWaPMSUDdlEIqahcTkf3qeYnkVmls=;
 b=hsfrAuAMuoOl7EqB2hHg+C/Koy3qEC7F1k/KLXkHZK2jlrjvCLutIMAwcPVm+DHyVe
 UwiYzQKm/qeGmpD6lvUfFEn8ljxnBj07MXDzkk4fO/Wi8GGlKutL8smBkCfgesLB9whn
 szuZ94jXPe7CnmYaLo50/dpGiQqofmocAQP+47xHOYg32wHfGQcAYfm5Z9eGuqiDwV/E
 /wKj45s/1UZAx/Dl8IlHL0etbxf4ivZmLvvFPxLmD0g6exOtw3WBv5fR/dj3f0NwLKDG
 Nyx1UydmpeAT6/TjXrRqbkItalgzhT3p20cVjrXVZGd8wUOpPWYVRdlX1cFJbfBe9+XH
 mFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771789726; x=1772394526;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Vcv4RD0c4PHuswWaPMSUDdlEIqahcTkf3qeYnkVmls=;
 b=DyBuFcwIaZh2/aMTxiZ4vrnHfCYX8LDYsbkgdsoX9786FaGJw/G5RF4cIJDT1IxHzx
 iu87IFfrFrbvjVHLLNeQo5EEGsJm19VqrDY198X+Sf0liLrNI8YUw211DpEOteozmfFo
 sqbLJkExTZAbB+IGmwRPv+enOQ5G/O8HJGIAMBkUUu4NxVSHhGdQIjvaz76V6OeML3vQ
 wXfvoEbqjK8eXmEg4zkHeL3aknb4z9YzrUttmZFR1+VTHu9XOMPjbaPeWCuYhz+Hk6FQ
 xiXtsCSm8yqZ0LRu0xxSS3qFXpzl4LPl7wnPm+gVDN2/B8mJE49/tQ0Z1gWIRfJuPhIp
 kVcA==
X-Gm-Message-State: AOJu0YybmphpCUJjqWUtVg5VeV9x1ffRFcAQT38p1mv9TCtJyvChPH+G
 81jG8Ji69va+plbxEKPU2JYN4PWY+Hz9vPL59Bz5GMGzQPjMtNovyy3b0+B1cpHZ/UwQnD1sqFf
 5fGCA
X-Gm-Gg: AZuq6aILfCZ3/ys2vTifd+fWtGTItBS0J+ukiNhh0aNA0K41EuAWf7AZs7pQbx6zvKK
 ayU/xijZjXjp72EijUHKYWX4rLi3GiNwkYFoXEhZoJVmfmEyWNq6UWgRt8vIlO2UNCfKyljxpVk
 ISeBSWQQALvwQzCAZVQfGwqrpykYYk0FFDIX0h1WNKRGqV6OvjWc6Wj6hCIPvfQ+iemkoemjCLJ
 jNo7Lf80R9bkuCcTfIvUP5zL/AP/PJeuVrbRovuJRjbYOx/h5vniLY9MoP2g8mf1RsX+spuaiWD
 P5USXVEt4lPK1Rusl1gzqMmEKIl5yIC5jt1IkBeDUe+JSfQY8T9kJh9+aZepTDY4cvSlxdnBlpI
 38EKRb4/dY2pB1S36BcyBSHZltrU8wzEvQBjsfVFbZE/MEpGDHTYPlo/Q2iGMFEKXGzAUZSx8aS
 5ujcQ3RATWDMtaX2AiDeaA/70adX5h+59byMe40GbXzdAvdGs+1+UFVU5VwKyn5S6TXTFTB4d5k
 90=
X-Received: by 2002:a05:6871:78d:b0:40e:dcc9:c3a9 with SMTP id
 586e51a60fabf-4157abed3cemr3461230fac.3.1771789726470; 
 Sun, 22 Feb 2026 11:48:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d3a9121sm5584288fac.19.2026.02.22.11.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 11:48:46 -0800 (PST)
Date: Sun, 22 Feb 2026 11:48:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
Subject: Bug: github actions triggering bug in vdev_netvsc
Message-ID: <20260222114843.0f27db7f@phoenix.local>
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

There are multiple unrelated patches failing in github action automated
testing. Not sure where this should live in Bugzilla, since not DTS but pro=
blem
with github action.

The root cause is that github container is deciding to pick up
the vdev_netvsc PMD when it should not.

Long winded AI details...

# eal_flags_vdev_opt_autotest failure on Azure/Hyper-V CI runners

## Summary

`eal_flags_vdev_opt_autotest` fails on GitHub Actions (Azure/Hyper-V VMs)
because `net_vdev_netvsc` auto-probes and crashes when a ring ethdev has
been created via the `nodeaction` parameter.

## Environment

- GitHub Actions runner (Azure Hyper-V VM)
- DPDK v26.03-rc1, shared library build
- VMBUS device present: `7ced8d63-dd7e-7ced-8d63-dd7e7ced8d63`
- PCI device: `c4c8:00:02.0` (mlx5)

## Details

The test spawns three child processes with `--no-huge`:

1. `--vdev eth_dummy` =E2=80=94 correctly fails (invalid device) =E2=9C=93
2. `--vdev net_ring0,args=3Dtest` =E2=80=94 succeeds, exits cleanly =E2=9C=
=93
3. `--vdev net_ring0,nodeaction=3Dr1:0:CREATE` =E2=80=94 child process cras=
hes =E2=9C=97

Because the runner is a Hyper-V VM, `vdev_netvsc_scan_callback` (triggered
by `RTE_INIT` when `rte_hypervisor_get() =3D=3D RTE_HYPERVISOR_HYPERV`)
automatically injects `net_vdev_netvsc` as a vdev to probe alongside the
user-requested `net_ring0`.

In run 2, `args=3Dtest` is an unknown key =E2=80=94 `net_ring0` creates a d=
efault
device and `net_vdev_netvsc` probes without issue.

In run 3, `nodeaction=3Dr1:0:CREATE` causes `net_ring0` to create a named
ring ethdev via `eth_dev_ring_create()`. When `net_vdev_netvsc` then
auto-probes, it hits `rte_intr_fd_get: Interrupt instance unallocated`
and the child process dies (no EAL cleanup messages are printed, indicating
a crash rather than a graceful exit).

The same `rte_intr_fd_get` errors appear in run 2 but are non-fatal there,
suggesting the additional ethdev state from nodeaction CREATE triggers a
fatal code path in the netvsc/interrupt interaction.

## Suggested fixes

- Fix `net_vdev_netvsc` probe to handle unallocated interrupt instances
  gracefully instead of crashing.
- Alternatively, the test could suppress auto-probing by passing
  `--vdev=3Dnet_vdev_netvsc,ignore=3D1` to its child processes.

