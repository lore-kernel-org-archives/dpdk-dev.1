Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9C606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HFnnMyc8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E701D4029E;
	Tue, 17 Nov 2026 16:00:32 +0100 (CET)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 7C4054026F
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:00:31 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so2037931a12.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794927630;
 x=1795532430; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bLmWEnsZhBaaqscwNecASHEAbgp+Nr/mboHPyW1KRuc=;
 b=HFnnMyc8VFxmjnjj0x9az6toKcjvlNiYINOyWWSf+uzBOVFGZQXtt7r23GCasdhi0R
 SBlLSc724SAT4O20o6X5ZmuJbA9RNCnm5JaeSr7+91qLpy4Hz5BJFufxyrHamG6m0R97
 GAnIIb9TwhSh9X7m7ro6JCW/DsDtcJsZTz/MiIzyLm4ZX1taLpFpdWOErTFngnXkkCZu
 A9zrmiyjUsRY4c/OXdamH9vJbQOahrFZ4NBAjXKF3TWHVo4RBvh7YTHblKNPDD9T/+uw
 q7fSD6m0iTfYyqcd1lqSK/cJkgBXtPJLwvqzmEt4Pj1+1+3KMoK6FIZXun/aHcZutsQq
 reTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927630; x=1795532430;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLmWEnsZhBaaqscwNecASHEAbgp+Nr/mboHPyW1KRuc=;
 b=b17d3rhmv32O29ByNNmjVyGYYDJE7btBCEugSphF3zMxFm4uzYE9sxGZ05Y5HLtwwO
 /Uc4PcbsK8Y3bzLtng5OpIrO7VDacCLgTFC8NBTNAeqhrdmj6NqQgBUfsHLJ0XwCSszv
 M1Tgo5wWaeSVUoCM+ZrdjE2mNVVMKtTfsuGpys9DiP9x6KHYroIN8a6NT+jvzFb4QMWG
 aza7dAftQaewGnMMVSk2CWdvB8z253zJR51kN33xi/xWkeq8bsDTCOGjekY3aMSwKUIF
 aLvr32xDeuMaHG6yYUrkNAOzk3dFTGVHF18YwInu85tPfv68vvTpjh9/ID5UUPkC0BZP
 LMFA==
X-Gm-Message-State: APuU4Z9kdWJ0O04iNRPLnG/P4cRR+ityzOozo9eU2DDEteK3pKXFfEAs
 aMuA0g//NaPX9+euEjC9aNvxa97GbfRGvKCAOyP2eM2UZj27raY29cjcH/Hz71yktGLyEI9yGNW
 oadeOcmY=
X-Gm-Gg: AZFdTZcGyCfjiUIdGu/S6V5sPUZrp8vLa+X05F9vBLlZwEENyCDIak3eRK/SeYmlznq
 RjKzEE3l1h+Ea03Hdbl4OeifEY5evy1HQGaOdHpiarQTPgKvuWnd/VbYSO1dKh8PwKrLqZ6Ug9C
 X7kBz0iKUA8Gi6An5ilKWeRjuohYgzqqwQLw92oqd8rc/P/sPfrIYAe+mkYwW1O4+W74g6PSbDP
 80NlsjcN8vGTvjIk+QO4Ob/ySLD+eped3il9KpPjJknOtqsZCAe8E/qh+jHFx+CSVuXQtQOpdVs
 PTylKyHsU+oUzRljRaNLxkcte6d9u7T0pf20KvdMxPjW9TRL861uoPXds8U++qnkEFOB1I8RG6x
 sR8aWLnRdQ+9z1KT1fMgtHvAB0lQjyvQNOixn7YD4LVEyIxLXqiqre9dAZ3t2H66TZgBIAFA0vP
 kHSzvVlJH+lYzSCcWLHUa8J8AXmlt75Yi2rnWCdu2VwzsbSV4cOGRTQ/RECz+KRKLMCrJ67t4o8
 BWgmcJf5b1km0UdA+OZibPng6P2n7Ocsw7ONATEz1YJmKoax4dwVnB8RLxYwlYU/2pYH9YW040y
 EQBoqk3D595Eg8E7MGHzrchFJn916ja+WOUwokVtCa0ScDyHbMQZNzGJaLVahwv1rAVsOZdw6A=
 =
X-Received: by 2002:a17:90b:3b8c:b0:3ac:af8d:c839 with SMTP id
 98e67ed59e1d1-3b1b0a48e43mr14553736a91.35.1794927629524; 
 Tue, 17 Nov 2026 07:00:29 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4d98b8sm4334233a91.13.2026.11.17.07.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:00:28 -0800 (PST)
Date: Tue, 17 Nov 2026 07:00:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Wei Hu <weh@microsoft.com>
Subject: Re: [RFC] bus/vmbus: make driver interface internal
Message-ID: <20261117070025.35cbaa76@phoenix.local>
In-Reply-To: <20261008191046.703485-1-stephen@networkplumber.org>
References: <20261008191046.703485-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  8 Oct 2026 12:09:33 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The vmbus bus API was exposed as public API, but it is only usable by
> the netvsc PMD and DPDK core: the functions operate on vmbus channels
> and devices that no application can obtain. Exposing them commits DPDK
> to an ABI that has no external consumer.
> 
> Make the interface internal as announced. The public headers
> rte_bus_vmbus.h and rte_vmbus_reg.h are renamed to vmbus_api.h and
> vmbus_reg.h and listed as driver SDK headers, so they are no longer
> installed for applications. All rte_vmbus_* functions are marked
> __rte_internal and exported as internal symbols.
> 
> rte_vmbus_chan_dump() had no export annotation at all, so it was
> declared in the public header but never present in the shared library.
> It is now exported as internal like the rest.
> 
> netvsc needs no change: it already includes bus_vmbus_driver.h, and the
> bus driver dependency puts the driver directory on its include path.

AI review of this had some good points that should be addressed.

[RFC] bus/vmbus: make driver interface internal

Applied to main (c6d273c). There is a context conflict in private.h:
main now has #include <rte_stdatomic.h> before rte_eal_paging.h. After
fixing that by hand, bus/vmbus and net/netvsc build cleanly with
-Dwerror=true -Dcheck_includes=true -Denable_driver_sdk=true. All
rte_vmbus_* symbols are now exported with the INTERNAL version, and
the old headers are no longer installed.

Warning

The new header names break the driver SDK naming convention.
Driver SDK headers are installed into the same flat include directory
as the public headers. Every other non-rte_ header there has a
class prefix (bus_pci_driver.h, ethdev_driver.h, ...). Generic
names like vmbus_api.h and vmbus_reg.h could collide with headers
from other packages under /usr/include/dpdk.

bus_vmbus_driver.h is the only consumer of vmbus_api.h, so fold
vmbus_api.h into it and give the register header the bus prefix:

  driver_sdk_headers = files(
          'bus_vmbus_driver.h',
          'bus_vmbus_reg.h',
  )

If you want to keep the two headers separate, call the API one
bus_vmbus_api.h. Update the release note to match.

Info

Several functions have no users outside the bus driver, and some
have none at all:

  rte_vmbus_probe     - dead code. The bus uses rte_bus_generic_probe.
  rte_vmbus_scan      - used only as rte_vmbus_bus.scan.
  rte_vmbus_irq_mask/unmask/read, rte_vmbus_chan_dump
                      - no callers in the tree.

This release already breaks the ABI, so this patch is a good time to
remove them rather than give them new internal exports. Delete
rte_vmbus_probe. Move the declaration of rte_vmbus_scan to private.h
and drop its export. The irq_* and chan_dump functions have no
callers, so either delete them or keep them unexported in private.h.
With that done, the commit message paragraph about chan_dump also
goes away.
