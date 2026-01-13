Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CAED2D10F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 14:31:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3512B4028C;
	Tue, 13 Jan 2026 15:31:48 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 82B4940276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:31:46 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso46009935e9.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 06:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768314706;
 x=1768919506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmDgjmUJqxE1ouRsCDKB0PCbtHaSYq9jvyYQxSGmXA8=;
 b=WbiSBydaQcoUCv19hg/b1pD/bd2SLanvF34KNuWS0w9StaRpRyhac0bHUcVlfo9T7I
 bXyfU4qurDXZNaIexaUkgp+65uFxDVxslAVILMPzl/fV/PqIJM1cUrHTSwHHt/y09PA3
 W2wGUaHUxPb0hBCq3uyRBD8SodJ0tSdVgq5l8mEOPTK1nZaBOwl16gAL3K+eEPwKLkcj
 XChcfhbYlejF7mQIp4exusU5Wr03QZa3rYwploU3IxYx+8i4cjGFFMoGJ2J0EFCZnWeX
 WLf3mSmLZYHsqfPYOf5z0LqfVCspXCNfQEuGeOcOOhRC6TJQoLZm1VE5WsJUQxHroY/F
 uPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768314706; x=1768919506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AmDgjmUJqxE1ouRsCDKB0PCbtHaSYq9jvyYQxSGmXA8=;
 b=E/EtECOhGu2nZ0hzww7krUgPiRwM7lEXPg19O9+hjl58ZgShAWYzPETFLaBf5sP9EG
 mjSBADx2BXT+w5jkXlH5rg5NiLFAowt7hPm+CN4IttEhi68dag75TPJBkD+E0YvkvIlo
 7dqu6Ofne0aDrE6IIAz991BAKO3dflzhNdE5a446BsKiZy7fD5OVf17qUc79yua6JXhr
 y4tJyjmS56FDgNiDuv4PJ8b8nHjZ83mDat2cFR8VJ22WrO8YsTAgUKRAO+8Vvg1pYeWf
 v/VeGeCAxc8KWFeORTdFx1Xu8eFj8ls7xADXqwDLIeBLLQWtXoKcDdVXE1vCui+bzbn/
 4liQ==
X-Gm-Message-State: AOJu0Yz+u7AXc+OWdF0tVSH4Iwb+zqaIwqkUnvt4iBbg69CECTVoFp51
 m1jcWMVFmuUwdRA0o4404iwtilgKkXI0x7xAEKHRYd1+ukgXWouEHOiTV5bD/+dZBjo=
X-Gm-Gg: AY/fxX50XrilS6Yy3BkIs5NEsN7qmiPb8CRvCjVzGmT2kr0VjXF7DcAguwrbiM91/NQ
 u+xXpuO8EhafWqSj1rpupb7vAoz3hmN/FgMlF7XJrOZqn8qtm0HShi7SftZHFOhuGMrn6m7iP//
 WQZ1cK/8FiomvVecFXIHPErZQUcD1+Tgrc/MeRPpiJykeS4wccXYtNaj17PksaIvtKvBCOiUiM+
 dvr0Ms7EAYsvhqrAOJOFrv8ceRgWMWfbbXgOf+dDBnYYBuaDN/9lLBRY1wI1skiDNXb5qkPYog+
 RhdRdQhme+yowK50vgdRSthAC1wYpVvoGJfcXJCaARCA12kjNXsxqq1G0PSreu5E5dyifHqtb89
 nAQ2t03+sU79DApY5oOrFDwoiFgDIKFl5NyA/wHLojRuB44jOFZJn3R5jfJyW5JRZnNw7vyto4R
 YZzXZjZp68H4AzIVEz1Uk6kGow3jCd1YWjOqVAX0V5onYJPrG549AH
X-Google-Smtp-Source: AGHT+IH75ZsDfBYA3LLl5U69WkaYwO8qHe9tLXJDyVehPUCub7IbrG8i+jt4B33Ik/jQinzQO5fKRA==
X-Received: by 2002:a05:600c:3556:b0:477:63b5:6f76 with SMTP id
 5b1f17b1804b1-47d84b3b3d7mr253527115e9.25.1768314705365; 
 Tue, 13 Jan 2026 06:31:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda5784e4sm15303095e9.18.2026.01.13.06.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 06:31:45 -0800 (PST)
Date: Tue, 13 Jan 2026 06:31:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konrad Sztyber <konrad.sztyber@gmail.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Konrad Sztyber <konrad.sztyber@intel.com>,
 stable@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Peng Zhang <peng.zhang@corigine.com>, Long Wu
 <long.wu@corigine.com>, Zerun Fu <zerun.fu@corigine.com>, Chaoyong He
 <chaoyong.he@corigine.com>
Subject: Re: [PATCH v4] bus/pci: don't open uio device in secondary process
Message-ID: <20260113063138.3382281c@phoenix.local>
In-Reply-To: <20260113123617.1736483-1-ksztyber@nvidia.com>
References: <20241011111533.20746-1-konrad.sztyber@intel.com>
 <20260113123617.1736483-1-ksztyber@nvidia.com>
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

On Tue, 13 Jan 2026 13:35:43 +0100
Konrad Sztyber <konrad.sztyber@gmail.com> wrote:

> From: Konrad Sztyber <konrad.sztyber@intel.com>
>=20
> The uio_pci_generic driver clears the bus master bit when the device
> file is closed. So, when the secondary process terminates after probing
> a device, that device becomes unusable in the primary process.
>=20
> To avoid that, the device file is now opened only in the primary process
> and the secondary gets it over UNIX domain socket via SCM_RIGHTS.
>=20
> Fixes: 847d78fb9530 ("bus/pci: fix FD in secondary process")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Konrad Sztyber <konrad.sztyber@intel.com>
> ---

AI code review spotted one minor issue

## DPDK Patch Review: bus/pci: don't open uio device in secondary process

### Summary
This patch fixes a bug where the `uio_pci_generic` driver clears the bus ma=
ster bit when the secondary process closes its UIO device file, rendering t=
he device unusable in the primary process. The fix requests the fd from the=
 primary process via SCM_RIGHTS instead of opening it directly in the secon=
dary.

---

### Commit Message Review

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 50 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| Correct prefix | =E2=9C=85 Pass | `bus/pci:` is correct for `drivers/bus/=
pci/` |
| Imperative mood | =E2=9C=85 Pass | "don't open" |
| No trailing period | =E2=9C=85 Pass | |
| No forbidden punctuation | =E2=9C=85 Pass | |
| Body =E2=89=A475 chars | =E2=9C=85 Pass | All lines within limit |
| Body doesn't start with "It" | =E2=9C=85 Pass | Starts with "The" |
| `Fixes:` tag present | =E2=9C=85 Pass | `Fixes: 847d78fb9530 ("bus/pci: f=
ix FD in secondary process")` |
| `Fixes:` uses 12-char SHA | =E2=9C=85 Pass | |
| `Cc: stable@dpdk.org` | =E2=9C=85 Pass | Present for backport |
| `Signed-off-by:` present | =E2=9C=85 Pass | Real name and valid email |
| Tag order correct | =E2=9C=85 Pass | Fixes =E2=86=92 Cc =E2=86=92 (blank)=
 =E2=86=92 Signed-off-by |

---

### Code Style Review

| Check | Status | Notes |
|-------|--------|-------|
| Lines =E2=89=A4100 chars | =E2=9C=85 Pass | |
| Function return type on own line | =E2=9C=85 Pass | `pci_uio_send_fd`, `p=
ci_uio_request_fd` |
| Explicit NULL comparisons | =E2=9C=85 Pass | `dev =3D=3D NULL`, `dev !=3D=
 NULL` |
| Explicit integer comparisons | =E2=9C=85 Pass | `fd < 0`, `rc !=3D 0`, `p=
ci_uio_dev_count =3D=3D 0` |
| Naming conventions | =E2=9C=85 Pass | lowercase with underscores througho=
ut |
| Comment style | =E2=9C=85 Pass | Multi-line block comment properly format=
ted |
| Include order | =E2=9C=85 Pass | DPDK includes grouped appropriately |
| No trailing whitespace | =E2=9C=85 Pass | |

---

### Warnings (should fix)

**1. Use of `assert()` instead of RTE_ASSERT or proper error handling**

```c
if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
    assert(pci_uio_dev_count > 0);
```

Standard C `assert()` is disabled when `NDEBUG` is defined and isn't consis=
tent with DPDK style. Consider:
- Using `RTE_ASSERT(pci_uio_dev_count > 0);` for debug builds, or
- Adding explicit error handling if this is a condition that could occur in=
 production

---

### Info (consider)

**1. Silent error handling in `pci_uio_send_fd`**

When the device isn't found or the fd is invalid, the function logs an erro=
r but sends an empty reply (num_fds=3D0). While the secondary process detec=
ts this, consider whether the reply should include an explicit error code i=
n the param field for better diagnostics.

**2. Missing header include**

The code uses `assert()` but doesn't show `<assert.h>` being added. If `ass=
ert()` is retained, ensure the header is included. If switching to `RTE_ASS=
ERT()`, `<rte_debug.h>` may be needed.

---

### Technical Review

The implementation approach is sound:

1. **Primary process**: Opens the UIO device and registers an MP action han=
dler to send the fd to secondary processes
2. **Secondary process**: Requests the fd from primary via `rte_mp_request_=
sync` instead of opening it directly
3. **Cleanup**: Properly unregisters the MP action when the last UIO device=
 is freed

The use of `rte_mp_*` infrastructure and SCM_RIGHTS for fd passing is the c=
orrect pattern for DPDK multi-process communication.

---

### Verdict

**Acceptable with minor changes** =E2=80=94 The patch is well-structured an=
d addresses a real bug correctly. The only substantive issue is the use of =
`assert()` which should be changed to DPDK-style error handling or `RTE_ASS=
ERT()`.
