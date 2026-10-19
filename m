Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12233606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UJ0FMykF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47DA840283;
	Tue, 20 Oct 2026 01:37:00 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2BE5640270
 for <dev@dpdk.org>; Tue, 20 Oct 2026 01:36:58 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a070755c8cso591053b3a.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792453017;
 x=1793057817; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jQJ8vQkI9QpUDS1S1zhwnaNxaXpmk1aMTIh1RfXlGmQ=;
 b=UJ0FMykFT9WBHTAwWqAvLxxxnNd70632ffpzgWeYS3UvBpibpys/ZVnx8E+n3lT6fe
 MCJvbSXMl8XGnHH1ZqCNeB+BC+FWHmRHiEwUjK9o+Wskd26cKHaOz27RnDpUCnc51LDa
 6+kzHVvFhKFbghNUcEYzztPBH4L8U6n198stfwlwQ3slskXw/znNV3yyNw5DgXMdnrjm
 JS5fNHkZzCnHpVigQXDM0PA3hObDxrhcl1nDo8vew4H9DaHL9bfXFiMs/7aLpkSs2I/U
 wMg10j7r9khY6R3eK5DC1iYk9raVhwNWZGZyPjcmVLoVJcqQiJegsFGOm3nhc7U6Dft0
 5WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792453017; x=1793057817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jQJ8vQkI9QpUDS1S1zhwnaNxaXpmk1aMTIh1RfXlGmQ=;
 b=ceb7U7bjtCgUt+n+txWfq+0DnCYulZmaHWKVLD1S4br+PJ7etEU7rRKgC/xT3cHaLq
 8bhcH9DtwSchN1neejQBX8ImwdQ/+LSGxU8+BLCKHp3gVVA7sqEqzazdaWAp18LbtmbN
 kVWom//AdCFTIVxKDryk9GLfe1J/sdzhgLC1oo4BIhc24FB7+qpPfW50kq/PvjlyFBua
 SII/Msx1L8mXdsXCEwS45liGdUBUFoj2qB/QyMLtmyexIm7vhpeOya8Tj+0frJS3hvqd
 9ZlPxWPKUG0ZI4hiXfQT1qa+NWdS0HXPSJUO2lisIOjo3A0tXKZap3KX0gMfqmgxyrKg
 37VA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxomUr881TyjovLvTyGPwyVDIu9UnzAHGLmYqIVnb9AlWK1chUJYQ9VFoBD5xFuEZ4LrG0=@dpdk.org
X-Gm-Message-State: AFq9FYIXUwQWzo6WftsylegE9iAMz/latjtDKbOvR3UT/z2l/hPzHuel
 22yX3icGiMkvHHjGtt/WsSk+gBNo+v53v8/7I4e+uRuvi5NZt1HUTBToPEQPUsV8nnM=
X-Gm-Gg: AYBFou0v87pKrFSNIVNRNARiYKMsOUtZVKCiBqiADWwXJo8TcydUztLQx28Z16nm/6t
 SWs6nb4t7ojDzWkSUfTZ15OriyggUhvB7BdJ/pNAc+4wgrF3qubYmpv8iinqpz2HMcmMxc/RGwJ
 XZ32w9E+KjeI0j4a1NeqcQhPv6FrCv4Nts12TXU3kSDGuV7U6pstben4Vben+guIwBUG1xxDB/E
 p+OyBqtroeiKI1+So6wzO9sTsySkpX4aKiEKEhNS4tISRX9cb1c7EvSzbUDEE0oc/7eKuwxjHBv
 uERNOGK17mrbeTzUx4LCritVnAPNJalS7DuyDl5AkMcRpmDtUZMI2sxn+5BNzqZS5XdajZrxX4s
 g6opokxyHuBh7UVBe2zw9eTJ5dkbtcPiNMqJvYLrvV+nxIbhRqBl99pavf+QYN0cRU8OtRXG62E
 1SgJZdZgNpKr30PcgoINgLIehsyY7AdaiiAwrwomJqacaw0ZIxQyoazz0Qs0H/4ZTSuJC3BYrJ4
 1ZM3NOI8ifzsMGymYJ+9H51Zp4wOfN6CTSbPeaV
X-Received: by 2002:a05:6a00:2d09:b0:89e:b12e:7ee1 with SMTP id
 d2e1a72fcca58-8a04ac29cb4mr7118184b3a.1.1792453017163; 
 Mon, 19 Oct 2026 16:36:57 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f56c8ba58sm4358261b3a.18.2026.10.19.16.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 16:36:56 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:36:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: Marat Khalili <qm2k21@gmail.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2 3/9] bpf: reject Tx callback installation with
 MT_LOCKFREE
Message-ID: <20261019163654.08198e1b@phoenix.local>
In-Reply-To: <a578685e-9312-4d30-8fca-58ba6ec91e94@yandex.ru>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-4-qm2k21@gmail.com>
 <a578685e-9312-4d30-8fca-58ba6ec91e94@yandex.ru>
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

On Mon, 19 Oct 2026 22:22:50 +0100
Konstantin Ananyev <konstantin.v.ananyev@yandex.ru> wrote:

> > The BPF ethdev packet callback synchronization mechanism expects only
> > one dataplane thread per port/queue pair at a time. When
> > RTE_ETH_TX_OFFLOAD_MT_LOCKFREE is enabled, multiple threads can invoke
> > rte_eth_tx_burst() concurrently on the same queue without locks. This
> > breaks the callback parity counter and can lead to use-after-free or
> > deadlocks during BPF program unload.
> >
> > Reject BPF Tx callback installation with -ENOTSUP when
> > RTE_ETH_TX_OFFLOAD_MT_LOCKFREE is enabled on the port or queue.
> > Add a unit test in test_bpf verifying this rejection.  
> 
> Should we be more generic here and reject any TX callbacks for 
> RTE_ETH_TX_OFFLOAD_MT_LOCKFREE devices?

The problem is the flag is poorly defined. Devices today advertise
the capability "sure go ahead and share a queue the PMD won't care"
but do not really treat it as a negotiation flag.

