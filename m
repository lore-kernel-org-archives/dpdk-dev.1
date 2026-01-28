Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9215D46C0A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 21:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F0B8402B6;
	Wed, 28 Jan 2026 22:57:28 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 9E8BA402A7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 22:57:27 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso2165855e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769637447;
 x=1770242247; darn=dpdk.org; 
 h=mime-version:content-transfer-encoding:references:in-reply-to
 :subject:to:from:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=riCs27BHOTUyj0B6RdfHcmQIbbtw6OVWjhy8Uv8EFaU=;
 b=vpqZ4kG+xEikXcX9BhUUN7TNYA1IwgVcTZ+6PoCxysV2uoVpf904ODHh35CR2fuB4d
 6y+CmuC7InGCcxmPC9S6UxkkfGJVuVUA0ghSe67fpdvLonC/iie2GF14qj6A9obTn3Yq
 fCSPpCNLADemJBwwCqf/R1bQ+ChFQQTpUWK7aC3+a0dihBQEGSqnXURYdj0yV6aZS87/
 lgZ45DMmZCsGQ6YPPhd2xiU3HHhpJ16/BWhnPIVTIU2KojjLvZZsg1cu5IXmNoEONqXN
 QUBFraVLTtBarVewDDSajJ+JY8brz8aBxa5rJt3GtQg/A73DKqwmyRxFWAwIsiylGWD0
 UXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769637447; x=1770242247;
 h=mime-version:content-transfer-encoding:references:in-reply-to
 :subject:to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=riCs27BHOTUyj0B6RdfHcmQIbbtw6OVWjhy8Uv8EFaU=;
 b=vlXDnluywJNNFFqYCVcVSH5NrMc48ZqqRih4K2H2xLeOQtoSCqn/duJqcRpaVBo4jU
 W+QUlJIqcdH+IUuFCUTnUCtFmQpH/pgzXcoUmGFj60rtWY2iuEl/mvlCHPX1IV3Ri/q8
 JOO547vpHcl3GFKTfxXF5V7lMY0Qq6LC5PK9Ds2bir020aW9WcobpSSqg5HLqWFbN60z
 V8ru9Ygm95BZ4e1Og6ZlYBV5mSSRnqhlR1nE9igfwY+2rhS0PdmMfSfnpLyCATuDUExl
 +tHY851+bM+/vSy26qfUW0p5k/k4jZRzWfgnu4rL4BJpeXcqv1QgiTkoq7cpv2mJExSe
 ZfZQ==
X-Gm-Message-State: AOJu0YxvJKFpyx+eZLFTYab7J64aDkTGieSKS35D/jtcpVTIbAYH33N+
 gG4V42KMCtcojZ+gXNe1PqfD++gTs4LXaZMiSWSjMrXeREzBfZy4eLojap8Q/S5gsLANmVbkvw6
 cOoWN
X-Gm-Gg: AZuq6aJ0W8TYNxw2xT70UWahZQU2YgvDy+r+dOzcpCDZoK+P6BMXO9dPpyLWPEH7AHN
 bUu1r4Drbtq5QGBci7nG62+gexDZYxSblkQtfjY9aMJ2+AmozJi+6DQJWLs3g8yPRsBncZLRg8m
 M3HG5u9u9vKLrC6t+BAnlSJVSMtFSq4O2o4lVY9bIWRVGq5yhYEbCHpWdwafU4TByYMcCYx+Wf9
 r9WV+LStihpTsBrfp/T5wRDD5kTiaUX8q7IRUNVZUbxFsQIgGuqDqJ3RDNCgK5gR6T5PsJILpKY
 iYnYBOIaN8hcNeG3XII2/Df+dOWsOuI7l8qn3W3jd+mXkUmsldDJZOsL6U5Kp/eLrVqiHWTVDbN
 XdcLrE4DQFLw7SmREXgagFpD1AwWYXbDaHsRM+6bq6vnbqvIqwhDlaRPFOImTdn/ZFHz+vbO4qp
 XWRnVifUCw9u1sywi7LVoxL2Q3/W73m9ponlBOhSsOA4HH0WnmCnuveOTIONhWJnw=
X-Received: by 2002:a05:600c:a40e:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-4806ab1f166mr71532965e9.9.1769637446882; 
 Wed, 28 Jan 2026 13:57:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cf16sm10435188f8f.22.2026.01.28.13.57.25
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:57:26 -0800 (PST)
Message-ID: <697a8646.df0a0220.20404.ed58@mx.google.com>
Date: Wed, 28 Jan 2026 13:57:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: [REVIEW] net/af_packet: software checksum
In-Reply-To: <20260128191032.78916-5-scott.k.mitch1@gmail.com>
References: <20260128191032.78916-5-scott.k.mitch1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

AI-generated review of bundle-1708-af-packet-v3.mbox
Reviewed using Claude (claude-opus-4-5-20251101)

This is an automated review. Please verify all suggestions.

---

## DPDK Patch Review: net/af_packet v3 Series

### Overview
This is a 4-patch series improving the AF_PACKET PMD with thread safety fixes=
, performance optimizations, and new features.

---

## Patch 1/4: net/af_packet: fix thread safety and frame calculations

### Commit Message Issues

**Warning: Subject line length**
- Subject is 58 characters, within limit but close to the 60-character maximu=
m.

**Warning: Missing blank line before Reported-by/Suggested-by tags**
- The `Fixes:` and `Cc:` tags should be followed by a blank line before `Sign=
ed-off-by:`.

**Info: Depends-on format**
- The `Depends-on:` line uses `patch-160468` format. The guidelines specify `=
series-NNNNN`. Verify this is the correct format for your workflow.

### Code Issues

**Warning: Use of deprecated memory barrier functions**
```c
static inline uint32_t
tpacket_read_status(const volatile void *tp_status)
{
	rte_smp_rmb();
```
The guidelines state `rte_smp_rmb()` and `rte_smp_wmb()` are forbidden and sh=
ould use `rte_atomic_thread_fence()`. However, the commit message explicitly =
justifies this due to kernel compatibility requirements with non-atomic `tp_s=
tatus`. This justification appears valid given the kernel's memory model.

**Warning: Variable declaration style**
```c
	const int pagesize =3D getpagesize();
	blocksize =3D pagesize;
```
Declaring `pagesize` as `const` at point of use is acceptable C99 style, but =
`blocksize` was already declared earlier. This mixing of styles within the fu=
nction is inconsistent.

**Warning: Static const at file scope**
```c
static const uint16_t ETH_AF_PACKET_FRAME_SIZE_MAX =3D RTE_IPV4_MAX_PKT_LEN;
```
Constants at file scope should use `#define` with `RTE_` prefix per naming co=
nventions, or if a typed constant is needed, use lowercase naming (`eth_af_pa=
cket_frame_size_max`).

**Info: Long lines**
Several lines approach but stay within the 100-character limit. Lines 1231-12=
34 with the warning messages are acceptable.

### Documentation Issues

**Warning: Missing release notes**
This patch fixes regressions and adds validation warnings. Per guidelines, fi=
xes that are backport candidates (`Cc: stable@dpdk.org`) should have release =
notes updated.

---

## Patch 2/4: net/af_packet: RX/TX unlikely, bulk free, prefetch

### Commit Message Issues

**Error: Missing Signed-off-by email format validation**
The Signed-off-by appears correct: `Scott Mitchell <scott.k.mitch1@gmail.com>`

### Code Issues

**Warning: Variable declaration inside for loop scope**
```c
	for (i =3D 0; i < nb_pkts; i++) {
		unsigned int next_framenum =3D framenum + 1;
```
Declaring variables inside loop bodies is valid C99 but mixing with earlier d=
eclaration style (`uint16_t i;` at function start) is inconsistent within the=
 function.

**Warning: Removal of early return check**
```c
-	if (unlikely(nb_pkts =3D=3D 0))
-		return 0;
```
The commit message justifies this removal, but removing defensive checks coul=
d cause issues if callers ever pass 0. The loop handles it correctly, so this=
 is acceptable but worth noting.

**Error: Potential use-after-free with rte_pktmbuf_free_bulk**
```c
	rte_pktmbuf_free_bulk(&bufs[0], i);
```
When packets are dropped (oversized or VLAN insertion failure), they are skip=
ped via `continue` but still freed in the bulk free. The dropped packets shou=
ld still be freed, but the current logic will try to free them even though th=
ey weren't processed. However, looking closer, `i` is the loop counter, so al=
l mbufs from 0 to i-1 will be freed, which includes dropped ones - this is ac=
tually correct behavior.

**Warning: Missing space after comma**
```c
			rte_prefetch0(bufs[i + 1]);
```
This is fine - no issue here.

---

## Patch 3/4: net/af_packet: tx poll control

### Commit Message Issues

**Info: Subject line is clear and within limits (32 chars)**

### Code Issues

**Warning: Including stdbool.h**
```c
+#include <stdbool.h>
```
DPDK typically uses `<stdbool.h>` through EAL includes. Verify this is needed=
 or if `bool` is already available.

**Warning: Uninitialized struct pollfd when txpollnotrdy is false**
```c
	if (pkt_q->txpollnotrdy) {
		memset(&pfd, 0, sizeof(pfd));
		...
	}
```
If `txpollnotrdy` is false, `pfd` is uninitialized but referenced later in th=
e `poll()` call. This is a potential bug - the poll path won't be taken when =
`txpollnotrdy` is false, but the compiler may still warn.

**Error: Inconsistent indentation in function declaration**
```c
rte_pmd_init_internals(struct rte_vdev_device *dev,
                       unsigned int framecnt,
		       unsigned int qdisc_bypass,
```
The continuation lines use mixed spaces/tabs. DPDK uses tabs for indentation,=
 spaces for alignment.

### Documentation Issues

**Info: Documentation updated correctly**
The `doc/guides/nics/af_packet.rst` is properly updated with the new paramete=
r.

---

## Patch 4/4: net/af_packet: software checksum

### Commit Message Issues

**Warning: Subject is vague**
"software checksum" could be more descriptive like "add software checksum off=
load support"

### Code Issues

**Error: New public API function missing experimental tag and export macro**
```c
static inline struct rte_mbuf *
rte_net_ip_udptcp_cksum_mbuf(struct rte_mbuf *mbuf, bool copy)
```
This function is added to a public header (`lib/net/rte_net.h`) with `rte_` p=
refix but:
1. Missing `__rte_experimental` tag for new API
2. Since it's `static inline`, no export macro is needed, but experimental ta=
g is still required for new public APIs

**Warning: Function should be marked experimental**
```c
+__rte_experimental
+static inline struct rte_mbuf *
+rte_net_ip_udptcp_cksum_mbuf(struct rte_mbuf *mbuf, bool copy)
```

**Warning: Variable declarations mixed with code**
```c
	void *l3_hdr =3D rte_pktmbuf_mtod_offset(mbuf, void *, mbuf->l2_len);
```
This is after conditional code blocks. C99 style is acceptable but inconsiste=
nt with function start.

**Warning: Missing Doxygen for all parameters**
The Doxygen comment is present but could be more detailed about error conditi=
ons.

### Documentation Issues

**Error: Missing release notes**
New TX offload capabilities (IPV4_CKSUM, UDP_CKSUM, TCP_CKSUM) and new public=
 API function require release notes entries.

**Warning: Missing feature matrix update**
If af_packet now supports checksum offloads, `doc/guides/nics/features/af_pac=
ket.ini` should be updated.

---

## Summary

| Severity | Count | Key Issues |
|----------|-------|------------|
| Error | 3 | Inconsistent indentation, missing experimental tag, missing rel=
ease notes |
| Warning | 12 | Deprecated barriers (justified), variable declaration style,=
 missing documentation |
| Info | 4 | Minor style preferences |

### Recommended Actions Before Merge

1. **Patch 4**: Add `__rte_experimental` to `rte_net_ip_udptcp_cksum_mbuf()`
2. **Patch 4**: Add release notes for new checksum offload support
3. **Patch 3**: Fix mixed tabs/spaces in function parameter continuation
4. **All patches**: Consider adding release notes entries for the fixes and n=
ew features
5. **Patch 4**: Update af_packet feature matrix if applicable
