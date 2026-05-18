Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4218CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 17:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C2D840659;
	Mon, 18 May 2026 19:57:04 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id D3606402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 19:57:02 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso3074131eec.1
 for <dev@dpdk.org>; Mon, 18 May 2026 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779127022;
 x=1779731822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDYUIlsUJT+ralALwaydRQBuAhcKR9bjUXRbze79zQ4=;
 b=sAtycsrY9OIFq3S1B7LR88o/c9g7wCwMnZNJe8KnL8mrQHxa5Lm3Q7U+ueqzgtjRPj
 iW43lxeWsr93KFN9yhcETNqA7EXqJU8vBzlPmCfm9hJlRbOvxQwCOt2PQz8bWElFCkrE
 m6GWr8orvovtylIqcSqHSmO0ybhIACapi2l94XOgl2L9RQlZ3uJK+zp8TjLFnlgSjNwR
 c3+UCLWUWsRaekpN8/j78dv2oY4u+Hhaa2Cimw4VbwwxYJBb/eI5bct9K0WnxoqC8j4W
 TYegG5jRxr+t4kmZcy50XClhFGSi99joTMpaxJbVVbvDTDoAvXy/Vuei++dUVzzPepRG
 2ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779127022; x=1779731822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SDYUIlsUJT+ralALwaydRQBuAhcKR9bjUXRbze79zQ4=;
 b=Sg7rrFymL69nuQS0gzBhlX7pEBalbYn4UZZ96Ez41qwcwtt3Xzulwpy5LrfBK+f7mI
 4vjm9tyNTEvPXTcwt0Isl3RyzATzaWD5Y65ovLVTCzM0DtAA7GK5rv0YqfYJH68mukDj
 VTZOBLLp4425kPP6CcNdEzEynd73Dy0lZW/A9QJ1QW/MOax0I47nLJUCetGZtEg4IkDX
 nc26tN0cjft9FibQn0EEx65h+Cy33mOY113cpqH3hw5nsEAR6lReRWUBZ6p90cUOYZoD
 0LWKlpzSC8Q9iUWs0TEVprYKfLu7RkzyUX+akIGqPue0NL5vJqap/ZFp78kFFLcH5gxw
 m4ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OjPJJWtmHAdLGAqzjr4lgDvOvG5nFjTsAJ5L4fxPMgxdfHCgGrADJAsZhevcLTVhjtdw=@dpdk.org
X-Gm-Message-State: AOJu0YzQrarHFK/ubup2Lu/FSpKzuRR2z40kMwyaH9H5ZUzysN0iTaWj
 CV4ul64ya3bZxZeB7fhfyAKS8B+YqXA+iZZPp+VRJewrxSbrNP0BiPcfcOCZuMSytSE=
X-Gm-Gg: Acq92OGJ6ZQYV6kavU9UIHkoUrd29OhtRKdhhIAxnfbIbxQwyr9P+2xjmwDEZRbdRjF
 WwwSOl8hidbbGpqo39KrrViAw4s21KhSNQTf0cEHdj8jvKINmxqXskk48fqgd7jxfw6mrcZtGuk
 scLNarX8Enq6BkRGhX4mky4xrbTQ8CI0EorVgOyHSvvyVBb1l5WVaNmLB6K753dR9+KqcpofyQ6
 fEpFUjx+sHOzwJhSULAqDcO0Vrt7gWn9Uw2nK83yxUSKhalPwKmG7fwHcKfDGqsbr+e13U/tWmz
 gYoTft9UKw6peTa448j3C9cPfMbMI0S5tDZGYBVD0VcdTbk+5CMGrmiUpy2UsACy+SRCnRKJKJn
 h9RbBzQhfXJI76wiExgtFkWboodUvby66L+NtkJ6VBPxpz/Mrv0+YChImSmOWm3UlCh5+l4YRpg
 GiciG9Q2nMyDCnWzsEtLPg4J0CyOV+9KF9+seluHzbJhBKaQ==
X-Received: by 2002:a05:7300:a94b:b0:2ed:a64:a457 with SMTP id
 5a478bee46e88-303986552f6mr6937269eec.20.1779127021683; 
 Mon, 18 May 2026 10:57:01 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6e9sm17162906eec.16.2026.05.18.10.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:57:01 -0700 (PDT)
Date: Mon, 18 May 2026 10:56:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, <dev@dpdk.org>
Subject: Re: [PATCH v3 02/10] bpf: introduce extensible load API
Message-ID: <20260518105658.7ca14d5b@phoenix.local>
In-Reply-To: <20260518084912.57006-3-marat.khalili@huawei.com>
References: <20260514093713.90118-1-marat.khalili@huawei.com>
 <20260518084912.57006-1-marat.khalili@huawei.com>
 <20260518084912.57006-3-marat.khalili@huawei.com>
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

On Mon, 18 May 2026 09:49:02 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> Introduce new BPF load parameters struct rte_bpf_prm_ex that can be
> extended without breaking backward or forward compatibility. Introduce
> new function rte_bpf_load_ex consolidating in one code path loading from
> both ELF file and raw memory image, with possibility to add more options
> in the future.
> 
> Some changes in code layout and sequence:
> * Both old APIs now only forwarding calls to a new single entry point.
> * There is now a centralized cleanup point for all temporary resources
>   created during the load process.
> * External symbols (xsyms) are now checked for validity just after the
>   load started, not after they were already used for relocation.
> * File bpf_load_elf.c now only handles opening ELF file and providing
>   patched instruction array to the load process. These are left as two
>   separate functions to support other ELF sources like memory image in
>   the future.
> * Function stubs for the case libelf is not available are moved to
>   bpf_load_elf.c to make keeping track of them easier (forgetting to
>   update stubs is a common problem).
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---Review of bundle-1895: bpf load (PATCH v3 01..10/10)

Lots of AI review on this (with Claude Opus 4.7)

====================================================

Patches 01, 06, 09, and 10 had no findings and are omitted from this
review.


PATCH v3 02/10 -- bpf: introduce extensible load API
----------------------------------------------------

Errors:

* lib/bpf/bpf_load.c, rte_bpf_load() and rte_bpf_elf_load() wrappers:
  These now unconditionally dereference `prm` when constructing the
  compound literal passed to rte_bpf_load_ex():

      return rte_bpf_load_ex(&(struct rte_bpf_prm_ex){
          ...
          .raw.ins = prm->ins,           /* NULL deref if prm == NULL */
          .raw.nb_ins = prm->nb_ins,
          .xsym = prm->xsym,
          .nb_xsym = prm->nb_xsym,
          .prog_arg = prm->prog_arg,
      });

  Pre-patch both functions explicitly checked `prm == NULL` and
  returned NULL with rte_errno = EINVAL. The NULL check inside
  load_try() does not help: NULL is dereferenced before
  rte_bpf_load_ex() is even called. Add explicit
  `if (prm == NULL) { rte_errno = EINVAL; return NULL; }` guards at
  the top of both wrappers.

Info:

* lib/bpf/bpf_load_elf.c: the success log
  "successfully creates %p(jit={.func=%p,.sz=%zu})" and the error log
  in rte_bpf_elf_load() are removed silently. If intentional, mention
  in the commit message.


PATCH v3 03/10 -- bpf: support up to 5 arguments
------------------------------------------------

Warnings:

* lib/bpf/bpf_exec.c, rte_bpf_exec_burst(), exec_jit_burst_ex(), and
  rte_bpf_exec_burst_ex(): these return `uint32_t` but the patch
  introduces `return -EINVAL` on error:

      if (bpf->prm.nb_prog_arg != 1)
          /* Use rte_bpf_exec_burst_ex with this program. */
          return -EINVAL;

  -22 reinterpreted as uint32_t is 0xFFFFFFEA, which the caller cannot
  distinguish from a valid "number of successfully processed inputs"
  result. The doxygen for rte_bpf_exec_burst_ex does not mention error
  returns. Either change the return type, document the encoding (e.g.
  any value > num indicates an error), or return 0 on these paths.


PATCH v3 04/10 -- bpf: add cBPF origin to rte_bpf_load_ex
---------------------------------------------------------

Info:

* lib/bpf/bpf_convert.c: the no-libpcap stub for rte_bpf_convert()
  loses its `if (prog == NULL) return EINVAL` check when moved out of
  bpf_stub.c. Previously rte_bpf_convert(NULL) returned EINVAL; now it
  returns ENOTSUP. Both produce NULL so pointer-checking callers are
  unaffected, but rte_errno semantics changed. Worth a mention or a
  restore for symmetry with the libpcap-enabled path.


PATCH v3 05/10 -- bpf: support rte_bpf_prm_ex with port callbacks
-----------------------------------------------------------------

Errors:

* lib/bpf/rte_bpf_ethdev.h: the doxygen comments for the two new
  functions are swapped:

      /**
       * Install callback to execute specified BPF program on given
       * TX port/queue.
       * ...
       * @param queue
       *   The identifier of the TX queue on the given port
       */
      __rte_experimental
      int
      rte_bpf_eth_rx_install(...);

      /**
       * Install callback to execute specified BPF program on given
       * RX port/queue.
       * ...
       * @param queue
       *   The identifier of the RX queue on the given port
       */
      __rte_experimental
      int
      rte_bpf_eth_tx_install(...);

  Swap the two doc blocks.


PATCH v3 07/10 -- test/bpf: test loading cBPF directly
------------------------------------------------------

Info:

* app/test/test_bpf.c, test_bpf_filter(): the failure path previously
  invoked test_bpf_dump(&fcode, prm) when load failed, useful for
  diagnosing converter regressions. The refactor drops this. Consider
  preserving the dump in the failure branch (or moving it into
  load_cbpf_program_convert on its NULL return).


PATCH v3 08/10 -- test/bpf: test loading ELF file from memory
-------------------------------------------------------------

Errors:

* app/test/test_bpf.c, bpf_rx_test(): when rte_bpf_eth_rx_install()
  fails, the loaded bpf program is leaked:

      ret = rte_bpf_eth_rx_install(port, 0, bpf, flags);
      if (ret != 0) {
          printf(...);
          return ret;            /* no rte_bpf_destroy(bpf) */
      }

  bpf_tx_test() in the same patch correctly calls rte_bpf_destroy(bpf)
  on the equivalent error path. Per the patch 05 contract, ownership
  transfers to the library only on successful install. Add
  `rte_bpf_destroy(bpf);` before the return.
