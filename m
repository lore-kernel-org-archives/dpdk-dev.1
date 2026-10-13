Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1195CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6550B40279;
	Tue, 13 Oct 2026 16:19:25 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3D15140272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:19:24 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2e49fbf92aaso16460385ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791901163;
 x=1792505963; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jfm1sVc3SUYHls/B0sZKo4A69Gh4MdsbLsWXQyOs3yA=;
 b=AKc7M5M8uqIEIq8nlwINjTheqlaEIGegcD8EWuLOmpYPdCJgGTa/vyo3fQlLftyAet
 xW49SSMrkVLTrwcLlzTLWU+depvaFvMG2h9ZAomQqohCI5EYGG1AvSLMquPiO9FUWz+T
 gjtr/LyjbRG+j9XCaN/mMYwCp95XNOEJUXuJqrc9PN98bis017YOVirT1ukxnJLNMqiU
 S1VHAgydQxk605+nmRbVSAoZ4tG7U3y7qhQoGRAx3fyB23Xy+9Q+7H7dgtlPFjw6typA
 6UCTKCqimKvJfOJpZVpB4ScRsHWdCzt8WsJsdGADuEX2kiDDWPPtMEvRJLMziW1jnZL4
 zeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901163; x=1792505963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jfm1sVc3SUYHls/B0sZKo4A69Gh4MdsbLsWXQyOs3yA=;
 b=Rxd7AasQ/YwEOPCg7YphIbZyiXbcHNmgQ6Cgy8tKY5GghqLQJjRzmoUhMcL8Jw0X9W
 56dh4elJR1tSaoapwVLZ75OsavMKlYCLM0X0ODxLkEDRIrjcrfI42VfRDvRQIVJ4TCd9
 OCaIyjFfpT+a4S1B4VSbzxoWfC8/YTPcdYSr59bNXiYZRpCfMU1taB0Tv8/TVDMsPxMq
 gxjA+lS6Fwi3dhrV9gbWDNJdq782EPXvGshhSVwlajH1nwD1SEKp5fjpCe+QmdE8Ck+5
 JX3zS4Nii5HcONgvrzQM47POfU/9NrMcsDle//Ei5Z8pArTIw5fqBNRQSBIkUuS8YSdu
 fEKg==
X-Gm-Message-State: AFq9FYKzUgSisANc7mqtlCeVkLPGg8jNgsLn0lszyvxXrOp2wAkiOWyT
 Tz5SI9+HjWNdKG5I4IUXkmrSfqiQplBfXVvMehNIqU4f5Gi1IGj0rm12/X9uwm4NmWE=
X-Gm-Gg: AYBFou0DgMFo/QgwRUjW3+AgAX6Eauwfhm3JQMT8OxymWO834FmGRWRqJw5XEsgkJ68
 1AhR4LSq2JOITzeFtZZ7MTQBCMIxmVzsjg92Bu8mAn9gZHFm2cQrFUg6IFb3i8Azj8cBwiMoglC
 mIIfHt1NhizDZoPyx+P1hE+VY5ZDHt1P1ypHBLAV4gNMlWXfg+B0XdHSugAyZG+YVKA5Yn+KepI
 BMQoZLJISBWg7pOiUho2mtaukPJrD5WzMjHGKS8ZwbHeF5LaAUuE/fNIb9Zr5PovFmtStqYwNce
 0yk2VUXvgThd0s77s8Qo0kZcn7ERo2Fkqs6Mu9cSFOTLHD5qjg2IflCGzvN2hFZBBw1wOm/THyK
 7xNw3idLfisbCIVT08ULnrkRBR2gOIvxvaKFMKSGpK1idKajC/xF66yRcoLbQXjWRG2+LlLAWfO
 vdDg5u61sQNF+/BOGeeG8KfFisoAOLhLCKBCD5JAQEfxMcQ+c+yDrkVV84Ciz0Td2DiaogDi3G6
 WnqXR/oD75JkYEyoeQBL4T8f7ADh9UbIYn00vVx
X-Received: by 2002:a17:902:e5c1:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2e8427f762emr111842365ad.6.1791901163170; 
 Tue, 13 Oct 2026 07:19:23 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8d8dsm55690285ad.52.2026.10.13.07.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:19:22 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:19:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v4 0/3] wireshark capture implementation
Message-ID: <20261013071921.3a2df694@phoenix.local>
In-Reply-To: <96108bc1-6004-4c94-a39f-133650e5f468@huawei.com>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
 <20261013034145.979361-1-stephen@networkplumber.org>
 <96108bc1-6004-4c94-a39f-133650e5f468@huawei.com>
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

On Tue, 13 Oct 2026 16:28:41 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> Hi Stephen,
> 
> A live Wireshark capture capability via extcap and telemetry is a highly anticipated
> feature for runtime debugging. In our previous high-throughput testing with file-based
> captures, we frequently encountered severe bottlenecks where packets could not be written
> to disk fast enough, leading to massive ring buffer overflows and packet drops.
> Therefore, the implementation details of this feature are of great interest to us.


Live capture into Wireshark will not help if disk can't keep up;
Wireshark is slower than disk. For high rate, use a capture filter
and a short snaplen. Existing dpdk-dumpcap can already feed
Wireshark through a pipe.

> Reviewing the current v4 architecture, I have two major concerns:
> 
> 1) Security Aspect & Telemetry Attack Surface
> The introduction of control operations (such as dynamically registering rx/tx
> callbacks and passing arbitrary FIFO paths) drastically expands the attack
> surface of the otherwise read-only telemetry interface. Could we introduce
> a dedicated "debug mode" configuration to strictly guard these write paths?
> Furthermore, it would be beneficial to know if this mode plans to support
> more control interfaces down the road, such as a "stats_reset" command.

I am going to add a "--no-capture" option to command line like "--no-telemetry".
The problem is that if the feature is "opt-in" then users have trouble using
especially if command line is buried in application.

The launchpad script already has lots of hardening to let it run with
privilege escalation. It resets itself after opening the socket.
This is to allow setups (which is normal on most Linux distros) where any
user in group wireshark can run capture.

The capture setup does checks to make sure that it can only be passed a FIFO
and rejects symlinks etc. 

The telemetry socket already has same permissions as the DPDK primary process.
I.e if you can get to the telemetry you can read/modify shared memory etc.

Not sure where Bruce intends to go with telemetry

The other option is making a clone of telemetry (different socket and
startup) but that duplicates effort.


> 2) Performance Impact & Thread Isolation
> The current implementation enforces a deep copy for captured packets. Have
> you considered an adaptive approach? For instance, allowing a lightweight
> shallow copy (mbuf clone) under certain conditions to save CPU cycles, while
> reverting to a deep copy only when conflicting offloads (like FAST_FREE)
> are active on the TX path.

Looked at this before but:

 - Rx: most applications assume the mbuf is writeable and
   having a capture break application is non starter.
 - Tx: many drivers assume the mbuf is writeable (arguably a bug).
 - FAST_FREE requires refcnt == 1.
 - A clone pins the original buffer. If the reader falls behind,
   the capture ring holds Rx mempool buffers and can starve the NIC.

The most efficient way to handle this is to set snapshot length and get
the relevant headers.

> Additionally, how is the actual packet writing thread managed and controlled?
> To prevent I/O blocking from introducing jitter into the fast path, should
> we consider isolating this writing worker thread onto a dedicated, isolated
> core (ecore/lcore)?

The writer is just a control thread, it is going to block on the FIFO
write system call if reader does not keep up. Then the packets back pressure
is in the ring. The callback increments a statistic if ring is full.

The capture writers inherit the control cpuset so already isolated.
