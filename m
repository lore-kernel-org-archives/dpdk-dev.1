Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70428D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 19:11:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 536824060F;
	Mon,  8 Dec 2025 20:11:01 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 385F940395
 for <dev@dpdk.org>; Mon,  8 Dec 2025 20:10:59 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so2254272f8f.0
 for <dev@dpdk.org>; Mon, 08 Dec 2025 11:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765221059;
 x=1765825859; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBXlC8DQWJuQXaiKDZCXi42CYMSMglJVZvBeI69bvbA=;
 b=whqeBryEyEvgwfgd6jOrtuXeb9bhQ4x96kIK/DOj335gDJZTWZwgULqyKj2kaQE9Fx
 BvlafE1uRDnhyscJOQ2UUP2DGFn7fDT7g34eV9V8f3Yiu09xmDgLr6elHm/zzXBXM7rk
 oLS6r6rKBCBTrHb2o45GjCVxFROwIrsPrnMnhSRCUz/pmmsU4dkFCZYvfkZiHjaE0N8P
 GyI1UXPaG7CPUkw2u3k3zJ/Xo/Wnvz/F88JImklN0qGfBaelLDIuEgSumLBZ8J1uJ8i1
 IaMnqjSUcF3wz02ppZcjskdkuRoytDnzo3CJd4B5SWhaSIRiBd/RbZ9jS5txmPU+ng0E
 rhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765221059; x=1765825859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rBXlC8DQWJuQXaiKDZCXi42CYMSMglJVZvBeI69bvbA=;
 b=lblUFox7/brg7YcndovsIe0jykBEDIWAalceOXc/iJfaSlzPjkWvUGCkXrAbvJCkDz
 2OxP7K7iOuloLJfIyj2pp4vOQae6wfKXynfJWKrDhJDsUxPHYkTo3AcjOlSmzlAzRFjU
 h0fBV5mXkAY+XMgQ7XQ1TMn4QlH+YzgA2NeYZ9yeWfVAa3mVqAdResiZr5NedYCyT3Wh
 jviswx5+qMAJAx5aknotvh9Lb4d1tKt/U3zUJUItQbH1eMM1zJWWT/DaPXQLcCoDG8OU
 /OCHYG+5uQ28eh9R9u/7A8/AsVVTUTVaPoa9Mo4bCinLvzypHgVt2FqG9XLyZ6TaAUci
 HAUA==
X-Gm-Message-State: AOJu0Yw18U7raV+DqtYvnrteyheHdSCul5vnqcG4CX2QQ1WqRTXIs6Pd
 J0yA0JIf5yYWFNNkoihCVNT0+0K6tlsNgYB4leo9Vwa1uylmSmYgVXtiyWINluHPoFQ=
X-Gm-Gg: ASbGncs6ot7rJJ9efYhM9Gyyd+OmbZYclmayK1H0w3dgZ7reo/H4oi4XkG50PY4pDbK
 6eEqu1mohaQC1T0D6fOcQiySLTkiEeYHfQOdvaFsKGb7CYKBsCyLbGHtgav/fUxoqF+eG9unplh
 dbesraRyRe1TEMHserIHQ57aiDnw/N2eQn+eoAib/LYvy4x7ZbXbSmNp1LS71O9amY8ka+mE8p1
 v+G1bxIxF7CX7J8A2+SyCPAl0tdgOFWMMTae01Z/dSwAQZbFMpggiLAzx+zzxtaL5f/F9J4+JLq
 htMvS+SomfdSpkRUELZuj0F+JHuyJ1xWt3ZOyx+om658zw/i1Ac1GmkKFPucruaPN7IkWJLMqTJ
 ZbgAufaGb7KKn+1eIIBd5DRSfScJzJ8u9u3IBv6EN20olr/42BDU3/EDi3m1M4gLzZZCya3eD9H
 Fo5vuuym74pQY4eYrVptKNXB7rFkcGObo6B62IAF+JjEqGonR8U4U5
X-Google-Smtp-Source: AGHT+IEj2V//Oh7y2PUpvE3z5h6Zgnxy6Th+r//NXSwfchWRpzPQa8HCzK5B7WkOlzV1xsU/+noR3A==
X-Received: by 2002:a05:6000:1884:b0:429:8bb2:d0ce with SMTP id
 ffacd0b85a97d-42f9df33cdamr499018f8f.18.1765221058743; 
 Mon, 08 Dec 2025 11:10:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d330b20sm26310415f8f.29.2025.12.08.11.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:10:58 -0800 (PST)
Date: Mon, 8 Dec 2025 11:10:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/11] Assign all unit tests to suites
Message-ID: <20251208111053.12535b4f@phoenix.local>
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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

On Mon,  8 Dec 2025 11:52:34 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Categorize all unit tests into one of the test suites: generally driver
> tests or fast-tests. In order to add some of the tests to fast tests,
> some additional work was required, hence the additional patches in this
> set. Also, make the parameters for asan and hugepages clearer in each
> test's definition.
> 
> V3:
>  - correct comment in patch 1
>  - define "attic" suite for unstable tests and add red_autotest to it.
> 
> V2:
> - rename the parameters for fast-test
> - fix issues with the tests to be added to fast-tests:
>   * allow loading drivers from secondary processes
>   * fix undefined behaviour flagged by asan in red test
>   * skip unrunnable power tests, rather than failing
> - add tests to driver-test suite also
> - add patch fixing output in case we have no unattached tests
> 
> Bruce Richardson (11):
>   app/test: make parameters clearer when adding fast tests
>   app/test: fix undefined behaviour in red autotest
>   app/test: reduce duration of secondary timer test
>   app/test: fix timer loop hang on secondary process failure
>   eal: add internal APIs to query loaded driver paths
>   app/test: pass loaded driver info to secondary procs
>   app/test: skip power capabilities test if unsupported
>   app/test: add some unattached tests to fast-test suite
>   app/test: add tests to driver test suite
>   buildtools/get-test-suites: suppress empty output
>   app/test: move red autotest to attic
> 
>  app/test/process.h                     | 28 ++++++++++++-
>  app/test/suites/meson.build            | 14 ++++++-
>  app/test/test.h                        | 13 ++++++-
>  app/test/test_acl.c                    |  2 +-
>  app/test/test_alarm.c                  |  2 +-
>  app/test/test_argparse.c               |  2 +-
>  app/test/test_atomic.c                 |  2 +-
>  app/test/test_bitcount.c               |  2 +-
>  app/test/test_bitmap.c                 |  2 +-
>  app/test/test_bitops.c                 |  2 +-
>  app/test/test_bitratestats.c           |  2 +-
>  app/test/test_bitset.c                 |  2 +-
>  app/test/test_bpf.c                    |  6 +--
>  app/test/test_byteorder.c              |  2 +-
>  app/test/test_cfgfile.c                |  2 +-
>  app/test/test_cksum.c                  |  2 +-
>  app/test/test_cmdline.c                |  2 +-
>  app/test/test_common.c                 |  2 +-
>  app/test/test_compressdev.c            |  2 +-
>  app/test/test_cpuflags.c               |  2 +-
>  app/test/test_crc.c                    |  2 +-
>  app/test/test_cryptodev_crosscheck.c   |  2 +-
>  app/test/test_cycles.c                 |  2 +-
>  app/test/test_debug.c                  |  2 +-
>  app/test/test_devargs.c                |  2 +-
>  app/test/test_dispatcher.c             |  2 +-
>  app/test/test_distributor.c            |  2 +-
>  app/test/test_eal_flags.c              | 24 ++++++------
>  app/test/test_eal_fs.c                 |  2 +-
>  app/test/test_errno.c                  |  2 +-
>  app/test/test_ethdev_api.c             |  2 +-
>  app/test/test_ethdev_link.c            |  2 +-
>  app/test/test_event_crypto_adapter.c   |  2 +-
>  app/test/test_event_eth_rx_adapter.c   |  4 +-
>  app/test/test_event_eth_tx_adapter.c   |  2 +-
>  app/test/test_event_ring.c             |  2 +-
>  app/test/test_event_timer_adapter.c    |  2 +-
>  app/test/test_event_vector_adapter.c   |  2 +-
>  app/test/test_eventdev.c               |  4 +-
>  app/test/test_external_mem.c           |  2 +-
>  app/test/test_fbarray.c                |  2 +-
>  app/test/test_fib.c                    |  2 +-
>  app/test/test_fib6.c                   |  2 +-
>  app/test/test_func_reentrancy.c        |  2 +-
>  app/test/test_graph.c                  |  4 +-
>  app/test/test_graph_feature_arc.c      |  2 +-
>  app/test/test_hash.c                   |  2 +-
>  app/test/test_hash_readwrite.c         |  2 +-
>  app/test/test_interrupts.c             |  2 +-
>  app/test/test_ipfrag.c                 |  2 +-
>  app/test/test_ipsec.c                  |  2 +-
>  app/test/test_ipsec_sad.c              |  2 +-
>  app/test/test_kvargs.c                 |  2 +-
>  app/test/test_latencystats.c           |  2 +-
>  app/test/test_lcore_var.c              |  2 +-
>  app/test/test_lcores.c                 |  2 +-
>  app/test/test_logs.c                   |  2 +-
>  app/test/test_lpm.c                    |  2 +-
>  app/test/test_lpm6.c                   |  2 +-
>  app/test/test_malloc.c                 |  2 +-
>  app/test/test_mbuf.c                   |  2 +-
>  app/test/test_mcslock.c                |  2 +-
>  app/test/test_member.c                 |  2 +-
>  app/test/test_memcpy.c                 |  2 +-
>  app/test/test_memory.c                 |  2 +-
>  app/test/test_mempool.c                |  2 +-
>  app/test/test_memzone.c                |  2 +-
>  app/test/test_meter.c                  |  2 +-
>  app/test/test_metrics.c                |  2 +-
>  app/test/test_mp_secondary.c           |  2 +-
>  app/test/test_net_ether.c              |  2 +-
>  app/test/test_net_ip6.c                |  2 +-
>  app/test/test_pcapng.c                 |  2 +-
>  app/test/test_pdcp.c                   |  2 +-
>  app/test/test_pdump.c                  |  2 +-
>  app/test/test_per_lcore.c              |  2 +-
>  app/test/test_pflock.c                 |  2 +-
>  app/test/test_pie.c                    |  2 +-
>  app/test/test_pmd_ring.c               |  2 +-
>  app/test/test_pmu.c                    |  2 +-
>  app/test/test_power.c                  |  2 +-
>  app/test/test_power_cpufreq.c          |  6 +--
>  app/test/test_power_intel_uncore.c     |  2 +-
>  app/test/test_power_kvm_vm.c           |  2 +-
>  app/test/test_prefetch.c               |  2 +-
>  app/test/test_ptr_compress.c           |  2 +-
>  app/test/test_rawdev.c                 |  2 +-
>  app/test/test_rcu_qsbr.c               |  2 +-
>  app/test/test_red.c                    |  2 +-
>  app/test/test_reorder.c                |  2 +-
>  app/test/test_rib.c                    |  2 +-
>  app/test/test_rib6.c                   |  2 +-
>  app/test/test_ring.c                   |  2 +-
>  app/test/test_rwlock.c                 |  8 ++--
>  app/test/test_sched.c                  |  2 +-
>  app/test/test_security.c               |  2 +-
>  app/test/test_security_inline_macsec.c |  2 +-
>  app/test/test_security_inline_proto.c  |  6 +--
>  app/test/test_seqlock.c                |  2 +-
>  app/test/test_service_cores.c          |  2 +-
>  app/test/test_soring.c                 |  2 +-
>  app/test/test_spinlock.c               |  2 +-
>  app/test/test_stack.c                  |  4 +-
>  app/test/test_string_fns.c             |  2 +-
>  app/test/test_table.c                  |  2 +-
>  app/test/test_tailq.c                  |  2 +-
>  app/test/test_telemetry_data.c         |  2 +-
>  app/test/test_telemetry_json.c         |  2 +-
>  app/test/test_thash.c                  |  2 +-
>  app/test/test_threads.c                |  2 +-
>  app/test/test_ticketlock.c             |  2 +-
>  app/test/test_timer.c                  |  2 +-
>  app/test/test_timer_secondary.c        | 13 ++++---
>  app/test/test_trace.c                  |  2 +-
>  app/test/test_vdev.c                   |  2 +-
>  app/test/test_version.c                |  2 +-
>  buildtools/get-test-suites.py          |  5 ++-
>  doc/guides/contributing/unit_test.rst  | 10 +++--
>  lib/eal/common/eal_common_options.c    | 54 ++++++++++++++++++++++++--
>  lib/eal/include/rte_eal.h              | 52 +++++++++++++++++++++++++
>  lib/sched/rte_red.h                    |  9 ++++-
>  121 files changed, 313 insertions(+), 157 deletions(-)
> 
> --
> 2.51.0
> 


Overall looks good, one comment is to try and make sure the new
functions are internal only? or experimental?
