Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9F9109C03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C22A4402CE;
	Wed, 25 Mar 2026 17:40:24 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id A30A64028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 17:40:23 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-127380532eeso31960c88.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774456823;
 x=1775061623; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3PAYNVo+CWOPSV9is3puov9bJtq01epWROnaHTAbBU=;
 b=xKEJhzupg4KTKQiAES9Qvus9XNsexnTc/uOljo+rmNJmW3bSj8/25I1yqNFsPEQMVO
 y6r/GVHEZGjM99TblTzOObv1BqEEUoFa0VgN9EqnS50T8d6aiFEi/hGwTConeDmmKX7y
 fDBzXCXRgJGrQM035QBzwH9DAwGAusG2Xhl2VtU5vRswsZpSKyV0pMvk0z04esSO4hHV
 cj9K1CrYJOfLUM4kgisK4EHqRcxmmzYJ656XO3OPDRaYJXFaaGAAOp2mZJuzMfkyuoMF
 m1Q1udEiPPfn87vLmUfBmpOnG2q+uD+LW1mF8aUSDXc5GtFyTIbPhY/Eg46gI4c6/U6A
 QrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774456823; x=1775061623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u3PAYNVo+CWOPSV9is3puov9bJtq01epWROnaHTAbBU=;
 b=Xw/H9kGsyt+XHMpRfemY21r7X/PR1U3Y5IRSMgIlnucSId9fRuPTS7NPHlufZQ7T2H
 7FX7WW1PW1o/aXVevztoB7dB5enWOp0K8Ig3LxoGY13ztpN9mjh93qYaOWPmMz/k006w
 EpXsI+1DdVcdt3KSAsAb95iOtacHadzKIn+XGnbhZS3asyXJE+aLIqGSsYn8V8lOnDVy
 jEZ3nGWewbMB/NIzVAU9xnqrWuR239y62FzLnpIExznPpYr6H+GRn6pJnacUZkQzdanT
 zidQNE+1W5UtLmqot8bk67jQu1X09OcJfL9iZ7NG4h1f7Pj31QSh2OAA1SSGSxzqAK59
 wiaQ==
X-Gm-Message-State: AOJu0YwIJ62aHsAU1DURABZpKYInGHc3Qk06CmsewgTt/1A0X8crErnX
 PeohsHa/WIYhdBNwlv3gXepzm3r6fKEnwld3/AeQcx6gRnKCTqnE+yo0dW7G19LnRlzSSaTpeUu
 Zi/8B
X-Gm-Gg: ATEYQzxTA8UaY3DhR09JrcRV8XxJY3W/SbJZwflrWFeGLKn+U3SJTOHKNPzFxCeV4FW
 H9gmE23R8H2f66tAP9MaJeKRKgEvXi3WfDiM7K8O3IYF+tbyRkSlbhpPW58v+rMCYXn0RoA01c5
 7i0gFHbzmGwuiip4AUyKJ+QDPGm4OpObmBfCfyivPOiF9upVCtuTll49hjA0fwxJaWAQXt5ug86
 1ci2l5Up2ItPcwIPim2dAAGxNpqd5nuDyZMWQsuSACIMl8On+2AkpXuTgryC3BQjEobBVyZRwKr
 m8KitxcMsM64hIQ/WcBpG+AxWIaaNwdnPxjSTFsf9Pu6VFyPEUuq8fzhqrvtNm/6jWV0MtJKz+S
 oGNhIaLxoTEep2I2+bnw8lXN2ltlbaB+wfna6iyT3TmDMBYgcJH2Tiw2StyQV6vAJ8BSoiy6Vlb
 zq7d3ak803ICtF2UAjCARsgg6SVCNLaE4zZn02/MA3lGLsbg==
X-Received: by 2002:a05:7022:62a7:b0:122:2f4:b24b with SMTP id
 a92af1059eb24-12a96ed716fmr2116591c88.25.1774456822535; 
 Wed, 25 Mar 2026 09:40:22 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa6e5b38csm362119c88.2.2026.03.25.09.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:40:22 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:40:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v5] net/tap: add software MAC address filtering
Message-ID: <20260325094019.3f4b8b81@phoenix.local>
In-Reply-To: <20260324190916.422283-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260324190916.422283-2-rjarry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 24 Mar 2026 20:09:16 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Linux TAP devices deliver all packets to userspace regardless of the
> PROMISC/ALLMULTI flags on the interface. When promiscuous mode is
> disabled, drop received packets whose destination MAC does not match
> any configured unicast or multicast address.
> 
> The receive path checks the destination MAC against the device's
> unicast address table (managed by the ethdev layer), the multicast
> address list (stored by the driver since the ethdev layer does not keep
> a copy), and accepts broadcast unconditionally. Promiscuous and
> all-multicast modes bypass the respective checks.
> 
> To support multiple unicast addresses via rte_eth_dev_mac_addr_add(),
> allocate mac_addrs with rte_zmalloc (TAP_MAX_MAC_ADDRS=16) instead of
> pointing into dev_private, and advertise the new limit in dev_infos_get.
> 
> Add a test to ensure it works as expected.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

Looks good, willing to merge this version.

AI review found some other small things; but these could be addressed later.
Warnings 2 and 3 look like just nuisance stuff.


---

**net/tap: add software MAC address filtering**

**Errors:**

1. **Resource leak in `tap_set_mc_addr_list()` on `rte_realloc()` failure.**
   `rte_realloc()` returns NULL on failure but does NOT free the original allocation. The code assigns the result directly back to `pmd->mc_addrs`, so when it returns NULL the pointer to the old allocation is lost and leaked.

   ```c
   /* Current - leaks old mc_addrs on failure */
   pmd->mc_addrs = rte_realloc(pmd->mc_addrs,
                       nb_mc_addr * sizeof(*pmd->mc_addrs), 0);
   if (pmd->mc_addrs == NULL) {
       pmd->nb_mc_addrs = 0;
       return -ENOMEM;
   }

   /* Fix - save old pointer */
   struct rte_ether_addr *new_addrs;
   new_addrs = rte_realloc(pmd->mc_addrs,
                       nb_mc_addr * sizeof(*pmd->mc_addrs), 0);
   if (new_addrs == NULL)
       return -ENOMEM;
   pmd->mc_addrs = new_addrs;
   ```

   Note the fix also avoids zeroing `nb_mc_addrs` on failure, which preserves the old list as a reasonable fallback.

2. **fd leak in `tap_inject_packet()` on error after `socket()`.**
   If `bind()` or `send()` fails, `TEST_ASSERT` causes an immediate return without closing `fd`. This is test code so the impact is minor, but the fd leaks on every failed assertion after the socket is opened.

   Suggest using a local `goto cleanup` pattern or closing `fd` before each `TEST_ASSERT`.

**Warnings:**

1. **Inconsistent error handling in test 7.** All other tests in `test_tap_mac_filter` use `TEST_ASSERT(ret == 0, ...)` for the inject call, but test 7 uses a manual `if (ret < 0) return TEST_FAILED;` check. This also skips `rte_eth_allmulticast_disable()` cleanup on failure. Should use `TEST_ASSERT` for consistency.

2. **`rte_malloc` used for `mc_addrs` in `tap_set_mc_addr_list()`.** The multicast address list is a control-path data structure not accessed by DMA and not shared between processes (it's in `pmd_internals`, which is `dev_private`). Standard `malloc`/`realloc`/`free` would be more appropriate per DPDK guidelines, and would avoid consuming hugepage memory. If `rte_malloc` is kept, the leak fix above needs to use `rte_free` for cleanup, which it already would since the old pointer came from `rte_realloc`.

3. **Broadcast check could be moved before the `mc_addrs` loop.** In `tap_mac_filter_match()`, broadcast frames (which are a subset of multicast) traverse the entire `mc_addrs` loop before hitting the `rte_is_broadcast_ether_addr()` check at the end. Moving the broadcast check before the loop would avoid unnecessary iterations for a common packet type:

   ```c
   if (rte_is_broadcast_ether_addr(dst))
       return true;
   if (data->all_multicast)
       return true;
   for (i = 0; i < pmd->nb_mc_addrs; i++) { ... }
   ```
