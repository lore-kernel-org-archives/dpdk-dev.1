Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BECD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C681940E0B;
	Wed, 10 Jun 2026 17:59:39 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 46AF640E0B
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:59:38 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8ce0f17a69cso50817566d6.0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781107177;
 x=1781711977; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUQtgPbSN9ivzIgM1kwCCcVZwnSZsXKM9WzShJ42Kew=;
 b=n2Re8QMqVOZCoafAtYDU7lrqhWUDI+zSIrDtaeDz0IxhgedPh9l6YswFBUD2yFolec
 MMR70hj11UE93DKNPgW4sGrwon/+CA+0pCnGEFjF/ld4G25zS9DJa390B8vlzsnuo4AD
 VKszDKm32XIxw4Q1nJ7Fwn9ZoH9tG1rGBFyLdNVdlADSSQyBZ6dzmvjoOzZVb8Nclkg6
 XG4len55MzH932ZoHfdknR28YYA1psk5ET/J3N2+qx2ZBnmWo19KRYRpowLclUQ3cNzW
 oHSwyyrR0+653VA5rTi1z2gwG1yfuAzpFJWJxqc8AmrfNpSguqpPCjZaCc9Qz1BOy7X1
 TGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107177; x=1781711977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JUQtgPbSN9ivzIgM1kwCCcVZwnSZsXKM9WzShJ42Kew=;
 b=cKDzcGuu+O0C/rl/U38WjEd1ImTeEKtuuJ3hDfx64bS6OYKXeYaJMW0QQyZhizzcf+
 QRjQeLypHSaghuI5yFPPwNqz5e2WGeXL61A1ct6rHvVuywvxIqe1T/qATZcLLhdq2zrC
 PfmyQUu5wJ+s7jGihCOjVS8tV7OGz+ocJlK6ch2aalt544NrQP5kDT1B0ubHxzaVqmmW
 pjeBwmUwH66D1uLWeIee5YLwmt4aUTtw1geS3FHghFEYIqa7VS2FayJbfODVYDjBfEmK
 eJNK/jVwxQIaLtSjR3wJU/uL+t1lGLLzMMZVsWAIsRuz6zXCRHrJ8FlDFuGiHyW05Rsl
 nLgg==
X-Gm-Message-State: AOJu0YxWfeKIbz73a129JrJVY0ky0mOZnJaBbR2kkRa3yEWxCNgnE/YB
 jyLI7T54MNGgOUGaW7Fe+fc0JnCSkySIeZXeQzz6WckeysCSUZjd/ipg+xg+1dNJv0o=
X-Gm-Gg: Acq92OFKIfMn27RHIb3KR8Mt8MlQEPt22JJ9hO2VCHGYneOfmBmC83F7Dz6Hu5jNBpu
 LqGBFFc7iwtyUcToo96WqnyihInjqoSeuIQkUIG/QeAbwKNUrgggm6YOnB8tdbp49oV983fdBP6
 2YfhpGYjJ07Jd88YU+NMKOm/f3P6CbSMu9dfCVikPRHxDvQp4kHVk1OyPqkMI37pkYBNZYH3VTg
 FCzHOCf3EzIEtQdu8clRti6QRKqs5PbQLzbSt+cCU+9hVTS3dG5NwXosqyOe7f69HuSmWJ4Gf06
 Nv0qa98UUeNmwtde5i76YLDdN/Kl1tty3nC2wciCMKWkiwBFiIYlRXqoRhOTJxLSKL7yOf+0jq/
 wjMyipEuZ1LHr6LdB6wTlkH8PnbOqolLmZljTc4DwRUZc9O8hWY1n0rcqdAOIst62XOo6AV96Pc
 rEaccYMdRKyTXXS4Qin58RUJyj3MozfL0m80KgKSUd8Ncx1zFFx3u9m5kJtLtdFyIrq0nCa7Ce5
 R0=
X-Received: by 2002:a05:6214:2464:b0:8ce:f0a3:361f with SMTP id
 6a1803df08f44-8cef0a33769mr353296736d6.8.1781107177355; 
 Wed, 10 Jun 2026 08:59:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdc6755sm237429916d6.18.2026.06.10.08.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:59:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 08:59:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eimear Morrissey <eimear.morrissey@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 0/2] Pflock downgrade & stress tests for pflock/rwlock
 libraries
Message-ID: <20260610085933.2f0a533a@phoenix.local>
In-Reply-To: <20260610091147.88412-1-eimear.morrissey@huawei.com>
References: <20260610091147.88412-1-eimear.morrissey@huawei.com>
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

On Wed, 10 Jun 2026 10:11:45 +0100
Eimear Morrissey <eimear.morrissey@huawei.com> wrote:

> Add new downgrade option for pflock. Add stress tests for this &
> by extension the rest of the pflock/rwlock libraries.
> 
> Eimear Morrissey (1):
>   app/test: add stress tests for rwlock and pflock
> 
> Konstantin Ananyev (1):
>   eal/pflock: add API to downgrade from wr to rd lock
> 
>  app/test/meson.build               |   2 +
>  app/test/test_pflock_stress.c      |  76 ++++++
>  app/test/test_rwlock_stress.c      |  59 +++++
>  app/test/test_rwlock_stress_impl.h | 393 +++++++++++++++++++++++++++++
>  lib/eal/include/rte_pflock.h       |  21 ++
>  5 files changed, 551 insertions(+)
>  create mode 100644 app/test/test_pflock_stress.c
>  create mode 100644 app/test/test_rwlock_stress.c
>  create mode 100644 app/test/test_rwlock_stress_impl.h
> 

Interesting idea, lots of feedback from AI. Mostly about the test.

Patch 1/2 (eal/pflock: add API to downgrade from wr to rd lock)

Warning: new public API is not marked __rte_experimental.
New APIs (including static inline) should carry the experimental tag
for at least one release per the ABI policy:

	__rte_experimental
	static inline void
	rte_pflock_write_downgrade(rte_pflock_t *pf)

Warning: new EAL API added without a release notes entry.
Please add a note to doc/guides/rel_notes/release_26_07.rst.

Info: the hunk adds a double blank line before the #ifdef __cplusplus,
and the two atomic calls use different continuation indentation
(one tab vs two). checkpatch will complain about the blank lines.

Patch 2/2 (app/test: add stress tests for rwlock and pflock)

Error: read lock is leaked on reader error paths, hanging the test.
handle_error() with write_lock=false does not unlock, and its comment
claims the lock is "already unlocked by the calling function" -- but
handle_reader_work() calls it while still holding the read lock (both
the array-mismatch path and the counter-changed path), and the
DOWNGRADE_TEST failure path in handle_writer_work() likewise calls it
while holding the downgraded read lock. The leaked reader keeps rd.out
from ever matching, so any writer blocks forever in write_lock() and
rte_eal_wait_lcore() never returns: a detected failure becomes a hang
instead of a test failure. Simplest fix is to have callers unlock
before calling handle_error() and drop the unlock from it entirely;
that also fixes the downgrade path incrementing reader_errors for a
writer thread.

Error: stop flag uses volatile instead of atomics.
"volatile bool stop" is written by workers (handle_error) and the main
lcore and polled by all workers. volatile provides no ordering or
atomicity guarantee; use RTE_ATOMIC(bool) with
rte_atomic_load_explicit/rte_atomic_store_explicit as
test_ring_stress_impl.h does for wrk_cmd.
The volatile on counter and counter_array is unnecessary -- they are
only accessed under the lock, which already provides ordering -- and
it defeats compiler optimization of the 1024-element verify loops.

Warning: DYNAMIC_ROLES does not switch roles.
should_be_writer() is called once in lcore_function() before the loop,
so each thread's role is fixed for the whole run; the flag's stated
purpose ("Threads can switch between reader/writer roles") never
happens. Move the role decision inside the while loop when
DYNAMIC_ROLES is set.

Warning: should_be_writer() assumes the main lcore has index 0.
	unsigned int idx = rte_lcore_index(rte_lcore_id()) - 1;
With --main-lcore set to a non-lowest core, a worker can have index 0,
so idx underflows to UINT_MAX and the reader/writer split no longer
matches num_readers/num_writers. Compute the worker's position by
iterating RTE_LCORE_FOREACH_WORKER or skip the main lcore's index
explicitly.

Warning: trailing alignment attribute placement.
	} __rte_cache_aligned;
on struct lcore_stats and struct rwlock_test_shared must be written as
	struct __rte_cache_aligned lcore_stats {
checkpatch enforces this (required for MSVC).

Info: "max wait" statistic does not measure lock wait time.
acquire_time spans the entire iteration including the verify loops and
the configured reader/writer delays, so for long_hold it reports the
delay, not contention. Either time only the lock call or rename it.

Info: missing space in the summary printf string concatenation:
	"%"PRIu64" writer ops," "total time: ..."
prints "writer ops,total time". Also the first element of
pflock_specific_tests is mis-indented (opening brace at column 0).
