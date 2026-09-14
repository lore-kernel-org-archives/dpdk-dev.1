Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E4C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 18:42:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5CB640DDA;
	Mon, 14 Sep 2026 20:42:54 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id EBF4740A77
 for <dev@dpdk.org>; Mon, 14 Sep 2026 20:42:52 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso1792593a91.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789411372;
 x=1790016172; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a66z7B+1nqLNduCmOYWl4w7sfJABklNjUmimIHjeVV8=;
 b=yWxEfsc6TZc+1LQpn6rkg0JNxWP8Y4J14z92ogeaN73hqdfGkYrFW1euCNiQjaT8s1
 Hb6IE5mvPgzZ2zH842qEacXv2s+6aqrjelh/GDifiwvrWaE7ry+/a/yNiLL4AKMYTlzY
 avs0oLpD8PT8UuGeLKNwdAguK6AKEfSJ0ayh33JW1jde8nG0hjR/fEGSA91HTy3128kk
 2x5366KpUUEyoxzEl/m87INVdDnP8XD7IsidgSbt8mz2eouwQ0pGhIoZ/y645Xsbf1cP
 MIzlxzi8DyGz+f8aIivB8KervYIuPozbpeZTLc3QasQFv3kNIu5UkUwt7LwCmFWz/SOc
 Aytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789411372; x=1790016172;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a66z7B+1nqLNduCmOYWl4w7sfJABklNjUmimIHjeVV8=;
 b=tLRD0QxP4Tfywj3hoo1ZjO8OnG02bRIt8qIUZjnwMqTe+UeaoHNpVRl23qwF87qHgN
 i4OEpjbuSZGpvqSLVJ9egfuznOpul521WjNbPh9hzD5bsBS6pPYK7oWPXZdMT4x2hcfy
 xqyYZeXlGjJDWhav+eDagIETyC/P2Bj2zRxBYMpgfyhMNmAtSJOp07+vqhrDigFYF2Zr
 Fu/ZPYyRbmsRHdd4DrQdi9LP/6R8igrdBEbECYSC6vG1XJftgxi/m3PhBjBQogBxUwzc
 i5dCzQFEQXy84GFWYCXtxy7Q+EYgmzh+bkfICLRv9+10SlxABiynA8I67wpviib3eIKv
 BOfA==
X-Gm-Message-State: AFuF++laYe/vf9FejqHJ5+VGxW10FeUChLNqKMTRAhTQ8eDWEB/g7Pq9
 n1XLieJ3eYQ82a/dRw6ZHpdBUWalNyaAoIyKLr+Ykjz81kM+E40q9B56vb0Ovo2L8cuP/XnK6Q4
 0UDvIYNk=
X-Gm-Gg: AYBFou0y0CcM3NxeSjV7TjE1+j4LUCf1UMLB+BBV9SPvYs2oFwrMbp4Mbcu95CW9bYn
 6eluCYPEqAwvUVxg0Xz4pkVSsYPt3SExgNvKp52zx3P2PtWm95eQfnGM5fPeMMK7zbaPI7r0nYj
 KVp4MXVNxHhW8RVP7Pm+Him1zL1GL8BsN2weM/vf1EVrsx7TPzcDnbnYDvyu9qDfCWi8KBffX7p
 iJWkjSUfnhUs9YoFBoSKXDED5DmGgBzEO80V5fPz3oGZyWrC8jXX2G3OfWhVN9KvarxkqXokPq6
 T04rnkiQ8JnrzSoUUQJR5LoBg/ly0Nfo89G2MKkZ7kiNLP/nPpIuY4HyHeb8/MOF4FDmNn3GYT3
 jLx0CrRlaStuSjpDO/7hFxV0ul6wDjRJBlICL4f+fyf7pVd+bT8KsoN45xwdC2d7Hc+Rs+XhLS1
 wlct2UuKDkIHOUrWxrOSrmHqo3Fe9S2AEkWQVMjCFGeFeO0fnAlOR4IpnzHe+rIexOx/euCOfjc
 +TGdozaQpr/vJNZVCnBgT5uTT2HXpqdxeJkGUqw
X-Received: by 2002:a17:90b:554e:b0:39d:f823:ecff with SMTP id
 98e67ed59e1d1-39df823ed94mr4033924a91.11.1789411371888; 
 Mon, 14 Sep 2026 11:42:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd9668dsm693937a91.16.2026.09.14.11.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 11:42:51 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:42:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/7] validate-bpf: add standalone validation debug tool
Message-ID: <20260914114229.61d5e94c@phoenix.local>
In-Reply-To: <20260914145418.37353-1-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
 <20260914145418.37353-1-marat.khalili@huawei.com>
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

On Mon, 14 Sep 2026 15:54:10 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> This patchset introduces a new standalone tool for pre-validating eBPF
> programs and debugging validation problems. Its should allow developers
> to trace validator state changes per instruction and understand verifier
> decisions, simplifying the debugging of rejected programs before loading
> them into a real application context.
> 
> v2:
> * for FreeBSD compatibility switched from Linux to DPDK network structs;
> * addressed small AI comments:
>   * clarified patch 1 commit message;
>   * renamed `rte_validate_bpf_logtype` to `validate_bpf_logtype`;
>   * corrected comment to an internal-use-only function to reflect that
>     next-after-last value of the program counter is no longer allowed;
> 
> Marat Khalili (7):
>   bpf/validate: fix finished status on restart
>   bpf/validate: refactor internal step function
>   bpf/validate: formalize call back requirements
>   bpf/validate: add jump notification events
>   bpf/validate: add get current event API
>   app/test: add test for bpf validate debug events
>   app/validate-bpf: add BPF validation application
> 
>  MAINTAINERS                            |    2 +
>  app/meson.build                        |    1 +
>  app/test/test_bpf_validate.c           |  341 +++++++-
>  app/validate-bpf/alloc_list.c          |   53 ++
>  app/validate-bpf/args.c                |  263 ++++++
>  app/validate-bpf/debug.c               | 1099 ++++++++++++++++++++++++
>  app/validate-bpf/debug_command.c       |  383 +++++++++
>  app/validate-bpf/debug_command.h       |   65 ++
>  app/validate-bpf/eal_init_args.c       |   57 ++
>  app/validate-bpf/internal.h            |  151 ++++
>  app/validate-bpf/main.c                |   77 ++
>  app/validate-bpf/meson.build           |   13 +
>  app/validate-bpf/parse_decl.c          |  611 +++++++++++++
>  doc/guides/rel_notes/release_26_11.rst |    5 +
>  doc/guides/tools/index.rst             |    1 +
>  doc/guides/tools/validate_bpf.rst      |   97 +++
>  lib/bpf/bpf_validate.c                 |   49 +-
>  lib/bpf/bpf_validate_debug.c           |   92 +-
>  lib/bpf/bpf_validate_debug.h           |   12 +-
>  lib/bpf/rte_bpf_validate_debug.h       |   42 +-
>  20 files changed, 3348 insertions(+), 66 deletions(-)
>  create mode 100644 app/validate-bpf/alloc_list.c
>  create mode 100644 app/validate-bpf/args.c
>  create mode 100644 app/validate-bpf/debug.c
>  create mode 100644 app/validate-bpf/debug_command.c
>  create mode 100644 app/validate-bpf/debug_command.h
>  create mode 100644 app/validate-bpf/eal_init_args.c
>  create mode 100644 app/validate-bpf/internal.h
>  create mode 100644 app/validate-bpf/main.c
>  create mode 100644 app/validate-bpf/meson.build
>  create mode 100644 app/validate-bpf/parse_decl.c
>  create mode 100644 doc/guides/tools/validate_bpf.rst
> 

Looks good to me, but AI had some nits to pick.

Re: [PATCH v2 0/7] bpf/validate: debug events and validation app

Errors
------

Patch 7/7 (app/validate-bpf: add BPF validation application)

  app/validate-bpf/parse_decl.c:

    +		arg->value.size *= array_length;

  array_length comes from take_number() on the --xsym text with no
  upper bound, and the multiply is not checked for overflow, so a
  large length silently wraps to a small size that is then reported
  to the validator as the object size.  Reproduced:

    dpdk-validate-bpf --xsym='uint64_t[2305843009213693953] v' \
        --section=.text prog.o
    Validation succeeded.

  8 * 2305843009213693953 wraps to 8, so the tool accepts the
  declaration and describes an 8-byte object.  Clamp array_length,
  or check the product, and reject with the usual text error.

Warnings
--------

Patch 5/7 (bpf/validate: add get current event API)

  lib/bpf/bpf_validate_debug.c:

    +		return -EINVAL;

  in rte_bpf_validate_debug_get_event(), whose return type is
  enum rte_bpf_validate_debug_event.  Every enumerator in that enum
  is non-negative, so the compatible type is unsigned and -EINVAL
  arrives at the caller as 4294967274.  It equals no enumerator,
  including RTE_BPF_VALIDATE_DEBUG_EVENT_END, so a caller cannot
  test for it.  Either return
  RTE_BPF_VALIDATE_DEBUG_EVENT_END for the NULL case and say so in
  the doc comment, or change the signature to return int with the
  event in an out-parameter.

Patch 7/7

  app/validate-bpf/parse_decl.c:

    +	void * const val = calloc(1, RTE_MAX(1u, arg.value.size));
    +	RTE_VERIFY(val != 0);

  arg.value.size is user-supplied, so an allocation failure driven by
  the command line aborts with a core dump instead of an error
  message.  Reproduced:

    dpdk-validate-bpf --xsym='uint64_t[18446744073709551615] v' \
        --section=.text prog.o
    EAL: PANIC in fill_var_xsym():
    line 427	assert "val != 0" failed

  Return an error up through the parse path like the other --xsym
  failures do.

  app/validate-bpf/main.c:

    +	RTE_VERIFY(rte_eal_init(eal_init_argc, eal_init_argv) ==
    +		eal_init_argc - 1);

  rte_eal_init() returns -1 for ordinary environmental failures such
  as a missing runtime directory or insufficient permissions.  For a
  command-line tool that should be a message and a non-zero exit, not
  rte_panic().  Same for

    +	RTE_VERIFY(rte_eal_cleanup() == 0);

  app/validate-bpf/eal_init_args.c:

    +#define RTE_EAL_INIT_ARG_SIZE_MAX sizeof("--log-level=lib.eal:warning")

  and RTE_EAL_INIT_ARGS / RTE_EAL_INIT_ARGC below it.  The RTE_
  prefix is reserved for the libraries; an application should not
  define into it.  Drop the prefix.

Info
----

Patch 5/7

  debug->current_event is set only in debug_send_event().  A
  breakpoint callback reached through debug_trigger_breakpoints()
  therefore sees whatever event fired last.  The doc comment says the
  value is undefined when no event is being processed, so this is
  consistent, but a callback shared between a breakpoint and a
  catchpoint will read a stale event rather than an obviously invalid
  one.

  rte_bpf_validate_debug_get_event() is new public experimental API
  and gets no release note.  7/7 adds a release note, but only for
  the application.

Patch 7/7

  In --debug mode the result is printed twice: debug.c prints
  "Validation succeeded." to stdout from the validation-success
  catchpoint, and main.c prints it again to stderr.

  Array declarations are written as "uint64_t[4] v", not the C
  "uint64_t v[4]".  The C spelling is rejected with

    at offset 10: expect '(' or text end

  which does not point at the real problem.  Worth either accepting
  the C form or naming the expected form in the message.  The
  documented form is in --help, so this is a diagnostics nit.

  "uint64_t[0] v" is accepted and yields value.size 0 while calloc
  still allocates one byte.  Probably worth rejecting a zero length.

Verification
------------

Applied on d55ccd4.  Each of the seven commits builds on its own with
-Dwerror=true, so bisect is safe.  bpf_validate_autotest passes 29/29
and the new bpf_validate_events_autotest passes.  valgrind is clean on
the application's normal paths, with no definite leaks.

Checked and found nothing to report: 2/7 is equivalent at all call
sites, so "No functional changes" holds; 3/7's tightening of the pc
check to ">= nb_ins" is consistent with dropping the past-the-end call
from evaluate_finish(); 4/7's nb_edge > 1 test does select exactly the
conditional jumps.

Review-Result: ERROR
