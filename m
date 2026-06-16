Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E05FCD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90939402E3;
	Tue, 16 Jun 2026 23:22:56 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 12F2040289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:22:55 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304f590dd91so5803618eec.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781644974;
 x=1782249774; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuUZc95rEC+cXTAApFFwYrhf/yG7sa/BCax0LhVSmlQ=;
 b=FvAIwDb6ifKoVA0K3QVF8Xrnb5eGNSa8drTiZIIST/5FHiRm5dw+LrgJw+PLHPCXnS
 Tdo9XfWj4TBFzF+Bk5jLLudxJIeZ5kjnm7Z+q+j6A595weyOiXduZeF8DJ0EPjhmAutZ
 7ZLHrZzZAETes/s2R3YLwhVH7w15J8QyadUttD4dUVRwnQLZRpXSxHz/bHRXwH1eRDZv
 CG9mN/ySCup2fTSjVeJc7j5OG0BVPBXFIXEZv/jYJd7B1vBCpHM68ogm1s8b26BpNKkg
 JUlbS924GOz5Bp+J5F4D8xojhnQUIzby3ZE3rBxUy/Uc+wY1Euj+3gveozTmIPp/gUtq
 Zx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644974; x=1782249774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PuUZc95rEC+cXTAApFFwYrhf/yG7sa/BCax0LhVSmlQ=;
 b=R4vrziQSNJB6W+yPxCQnHTtgFkDvXoqkqdhu12IbDFu5w+oarj11qom8owQ4lbvwN9
 iOn7cBWiP/mCE/MvYDsSfjhvnK9987teX8ie+WkwW9rmJ2TSThrD8JAx2NsMm1xPE4RI
 eMXk34eN5q0Lszzery345Kj+pFSWKVV64T8XGoZVQqN5XjC7HRWZbFPlzYQfvildIB9P
 jBBIobBwiQoIDBpdDjKfMRxPJF9Nr2NqJmBSRNKG/a3m1f7RBMcW2IUN65EiCSsrxdSo
 Pch1CAFmxVcq5F+GUnu1ghxt6NUXEPtheVNZmdKRTo/e2GzHkuo5gbtUuJeP3MyNqyn3
 wHQw==
X-Gm-Message-State: AOJu0YxbtswOsaPrf3V827Exrq4vVDroF3SNTTKGtxON9kCtr8CcCRIe
 h1J7hxkSGp7roeelu/zefyaV7a4LGuIApVyhm4Nmo6a/CJMLrYbEULb1DgUuyb6TrGI=
X-Gm-Gg: Acq92OEALLiyH85ojszevOtGj9T3/aVAFTIpNFu7uXneeJJ6uU7yNnx8wsKbTiK/XaE
 3R5pDtRd+qgj8y+rwFOVPjE2hjUvl6wbSMyDEdXwJQXyENiDAsepYZxkHsc1nLmQEpA8BFr7Csy
 44Ry3C7D59V/jc8GgZLFI4ejmmn29EOIzaUPk/JInaUNgBXA9TTy0J6VtEoQhtVGZ73/veaaacj
 PyEuQdw/K1vmzJ8m2z4DnSQ0x4v1olPvum2Brp47eAEZPZJ9iDI+F9SY7pXftQ/vL6eZh6LO3vd
 Xcns1PVqYa9iz47KyxydC0Fa4COhWABknfIJtObCRXuT/OiQRlA7CgLrN6bOyzTQ6QJEWuUHz3D
 pr8XTsN8PoJniCgZExtWm20gBWJnQl67kK5Dnxp8B0NiGP7RjuWlU3vhCGBfaERwbaWq53HIQcU
 8rJHFi8X71xh8OCrcbk02fmuJMW0Js0VIpdVaCOrHdUbDxAdgCy4MVlhBFL6oHQfHF
X-Received: by 2002:a05:7301:10c1:b0:304:de94:1c2c with SMTP id
 5a478bee46e88-30bca0cfa9fmr576134eec.34.1781644973961; 
 Tue, 16 Jun 2026 14:22:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm22062676eec.8.2026.06.16.14.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:22:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:22:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v10 1/1] net/mana: add device reset support
Message-ID: <20260616142250.29603185@phoenix.local>
In-Reply-To: <20260616123158.43583-2-weh@linux.microsoft.com>
References: <20260616123158.43583-1-weh@linux.microsoft.com>
 <20260616123158.43583-2-weh@linux.microsoft.com>
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

On Tue, 16 Jun 2026 05:31:58 -0700
Wei Hu <weh@linux.microsoft.com> wrote:

> teardown immediately (dev_stop, secondary IPC, dev_close, MR cache
> free) before waiting for the hardware recovery timer to fire. This
> avoids blocking the EAL interrupt thread on multi-second IPC
> timeouts and ibverbs calls. After the recovery delay, the thread
> unregisters the interrupt handler, re-probes the PCI device,
> reinitializes MR caches, and restarts queues. Each function owns
> its own lock scope with no lock hand-off between threads.
> 
> Each queue has an atomic burst_state variable where bit 0 is the
> in-burst flag and bit 1 is a blocked flag. The data path uses a
> single compare-and-swap (0 to 1) to enter a burst, which fails
> immediately if the blocked bit is set. The reset path sets the
> blocked bit via atomic fetch-or and polls bit 0 to wait for
> in-flight bursts to drain. This single-variable design avoids the
> need for sequential consistency ordering.
> 
> A per-device mutex serializes the reset path with ethdev
> operations. The mutex uses PTHREAD_PROCESS_SHARED for multi-process
> support and is held across blocking IB verbs calls. A trylock
> helper encapsulates the lock acquisition and device state check
> for all ethdev operation wrappers. Operations that cannot wait
> (configure, queue setup) return -EBUSY during reset, while
> dev_stop and dev_close join the reset thread before acquiring
> the lock to ensure proper sequencing.
> 
> The reset thread keeps reset_thread_active true throughout its
> lifetime. mana_join_reset_thread uses rte_thread_equal to detect
> the self-join case (when a recovery callback calls dev_stop or
> dev_close from the reset thread itself) and calls
> rte_thread_detach instead of join, so thread resources are freed
> on exit. External callers join normally.
> 
> The condvar wait in the reset thread uses a predicate loop that
> checks dev_state under reset_cond_mutex, so a PCI remove signal
> that arrives before the thread enters the wait is not lost. The
> PCI remove callback sets dev_state to RESET_FAILED under the
> same mutex before signaling. A lock/unlock barrier on
> reset_ops_lock in the PCI remove path ensures teardown has
> completed before emitting the INTR_RMV event.
> 
> Multi-process support is included: secondary processes unmap and
> remap doorbell pages via IPC during the reset enter and exit
> phases. The secondary RESET_EXIT handler closes the received fd
> unconditionally after processing, even when the doorbell page is
> already mapped. Data path functions in both primary and secondary
> processes check the device state atomically and return early when
> the device is not active.
> 
> The driver emits RTE_ETH_EVENT_ERR_RECOVERING before entering the
> reset path so that upper layers (e.g. netvsc) can switch their
> data path before queues are stopped. The event is emitted outside
> the reset lock to avoid deadlock if the callback calls dev_stop or
> dev_close. On completion, the driver emits RECOVERY_SUCCESS or
> RECOVERY_FAILED after releasing the lock. If a recovery callback
> triggers dev_stop or dev_close, the self-join detection in
> mana_join_reset_thread detaches the thread to avoid deadlock. If
> the enter phase fails internally, RECOVERY_FAILED is sent
> immediately so the application receives a terminal event. A PCI
> device removal event callback distinguishes hot-remove from
> service reset.
> 
> Documentation for the device reset feature is added in the MANA
> NIC guide and the 26.07 release notes.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
Applied to next-net
