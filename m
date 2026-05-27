Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DCCD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 15:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D2354027D;
	Wed, 27 May 2026 17:41:28 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id A6F8A4026C
 for <dev@dpdk.org>; Wed, 27 May 2026 17:41:27 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-132c338a537so8004090c88.0
 for <dev@dpdk.org>; Wed, 27 May 2026 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779896486;
 x=1780501286; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3137/jFFZx5bJHOuffIUM1L7LZ8rhee6EqQf0rnmHSo=;
 b=mXrnK0wSOYHqEEMuXi7qezqdPLtQ6V3hDU5rDSfcfde0Ec6TWcDxa3lEITlBiNJwbj
 uZr25IoWn0tdblx9AK08M4keA3BmpO1HE47HULZlaeVYm24kIgkUJPnKUg/W7ER10bq6
 JY2WEmAe4ilMlyzpOtugFD6vNEErPzTRcCPDO8byegZzvPgcsaowckE8rqIZxAh25/Vy
 +Pf6E7rI5SUkd+GMp6hREwVom1KrBvXvcXk8VN1L1zpBrokoSEYuzRdCbhTMg1ndjeHK
 BLCw/izTntroIYTeUAUxxEyC4kVt1lWxv9P/zk3YkM2wl5YnyEZuSoC35Dr1GkpQ5G64
 IyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896486; x=1780501286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3137/jFFZx5bJHOuffIUM1L7LZ8rhee6EqQf0rnmHSo=;
 b=CqWhOaV+MoGlWAI7Ap/dH6vJ7fFcIZFL9+CXt7iZj1DJxuc5QFIOTn3pqHK6/X0G31
 FU6V8CLoYxS5+svHTbpoCiSaZnDihf1jcnXmiQ0kDmwp3+RuIAHuI/KG/dM1yXocEkap
 HeubZ7QVpf+ZS1Rhp/ikVhtCPzSajF6rnBkCtuXTyBAbGve2FiypwOeOssZdtd18R2Jw
 sqQauERg50AsYmkBMWinc/kCVk45sivmH2wH0KMxc6BKGfB9E2B1WJNZlHIH3dOR4+qD
 GdqS17Y5RDW5gbk2McVXA7aNtNEANuGMAIU0kYuUU7FQGumuvIHVAX4X5iPkSRb5zNAu
 kztg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DUb70OwbzrtOz+b1BQ0Km0CLYAgody1BFRwHkwZ15Qk7+y5vR9Y8XNv+tmt27XnWr8Ks=@dpdk.org
X-Gm-Message-State: AOJu0Yw/GsoeSslUuljS4Wa/L/FewlupaNVMesJLPyKyor+9imU3IDkq
 lFvMGhPKwrg6EKNTXJ3XkJpcvGdVNCi8GAUeemJz1JDXA6tDytiLMMd3EnQ7O0vXS5Y=
X-Gm-Gg: Acq92OFNRiOn8JqMOy6RoHpcAfV8xTGeY02olC1ccRjg990TlMtMGqDrwg4O6AFy7b5
 lbsO7bIKTtrBAbpBkCPbAckn6nQyn3cbAekWQJQE22/LI7hWkOv5Jr8MQIdoJfp/BLLWPb/S/i5
 FN4WSaxdhuMtv6IW9Snl4TP9zpPBY0vv0dGiqcxxkyjawY9PMJgBHCAcsdS17fY/6YNm9+l2k5D
 rGhk35+q6gTA7VKmkaTLEhUVlvBM3KkVYcijN71Fr7hP5KPLqDBoRMES8KUA7XFzywzu9Ma23jU
 YGXOstTI1tvhJS9qgyQjjbE/ZX9fWdZxpx3L9N6IvJjgArhhY7jfy/ytHBTMpwaTKfE83T+iuCV
 PCJGEC4fvSkjXJeTyH93pSYKCbDDzoD/QyfNEQKKJ1eTU+pps6d2n9FuqhviRpdHrSRGYIkZlMx
 xbpg/J93y5Qq9NBN3DY5O2FO8SVZdOFPKcnzBGKVMmzJevYgPf4hu4oOX5Gft7IzrRVqxiiDA7Z
 fw=
X-Received: by 2002:a05:7301:2e89:b0:2d1:9b35:4edb with SMTP id
 5a478bee46e88-30449fbb314mr9216321eec.0.1779896486310; 
 Wed, 27 May 2026 08:41:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4afdsm13264220eec.5.2026.05.27.08.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:41:26 -0700 (PDT)
Date: Wed, 27 May 2026 08:41:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Megha Ajmera <megha.ajmera@intel.com>
Cc: bruce.richardson@intel.com, cristian.dumitrescu@intel.com,
 praveen.shetty@intel.com, dev@dpdk.org
Subject: Re: [PATCH v2] app/test-pmd: add generic PROG action parser support
Message-ID: <20260527084123.5c7adccc@phoenix.local>
In-Reply-To: <20260521101354.726240-1-megha.ajmera@intel.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
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

On Thu, 21 May 2026 15:43:54 +0530
Megha Ajmera <megha.ajmera@intel.com> wrote:

> Add parser support for a generic PROG flow action in testpmd.
> 
> The update adds CLI tokens and parsing logic for program name and
> argument tuples (name, size, value), enabling programmable action
> configuration through the flow command interface.
> 
> Example flow rule:
>   flow create 0 ingress pattern eth / end actions prog name my_prog
>   argument name arg0 size 4 value 10 / end
> 
> Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> ---

Ran AI review on this manually since that gets better context.
The feedback was:

On Thu, 21 May 2026 15:43:54 +0530
Megha Ajmera <megha.ajmera@intel.com> wrote:

> Add parser support for a generic PROG flow action in testpmd.
>
> The update adds CLI tokens and parsing logic for program name and
> argument tuples (name, size, value), enabling programmable action
> configuration through the flow command interface.

Errors

1. CREATE proceeds with partially-converted action data on conversion
   failure.

   In cmd_flow_parsed() the CREATE case prints a warning if
   convert_action_prog_to_rte_flow() returns negative, then
   unconditionally calls port_flow_create(). Inside
   convert_action_prog_to_rte_flow(), each per-PROG failure does
   "continue" rather than aborting, so the function returns negative
   while some actions[i].conf pointers have been replaced with
   rte_flow_action_prog and others still point to the parser-internal
   action_prog_data (a completely different layout). The PMD then
   dereferences a mix of two unrelated structure types. Either abort
   the create on negative ret, or make convert_action_prog_to_rte_flow()
   fail-fast: free everything converted so far, restore conf pointers
   (or never overwrite them until the whole pass succeeds), and return
   without touching port_flow_create().

2. Argument value is sent in host byte order, but the API requires
   network byte order.

   The doc for struct rte_flow_action_prog_argument in
   lib/ethdev/rte_flow.h says the value array must be in network byte
   order. The conversion code does:

       memcpy(value, &prog_data->args[j].value, args[j].size);

   prog_data->args[j].value is a host-order uint64_t populated by
   parse_int. For "size 4 value 10" on little-endian this produces
   {0x0a,0x00,0x00,0x00}; on big-endian it produces {0x00,0x00,0x00,0x00}
   -- the leading zero bytes of the 8-byte value, so the user always
   sees zero. Either convert with rte_cpu_to_be_32/64 before memcpy,
   or have the parser accept and store the value as a network-order
   byte array of the declared size.

3. Only the CREATE path is converted; VALIDATE and the async/template
   paths still pass action_prog_data to the PMD.

   cmd_flow_parsed() routes the same in->args.vc.actions array to
   VALIDATE (port_flow_validate), and to multiple async/template paths
   (port_queue_flow_create, port_flow_template_table_create,
   port_action_handle_create, etc.). None of these are converted by
   this patch, so any PROG action used with "flow validate",
   "flow queue ... create", indirect-action create, or pattern/action
   templates passes the parser-internal action_prog_data to the PMD
   with the wrong layout. Conversion needs to be factored into a
   helper invoked from every code path that hands actions to the
   ethdev API, not bolted onto CREATE only.

4. Unbounded scan for END in convert_action_prog_to_rte_flow().

       while (actions[i].type != RTE_FLOW_ACTION_TYPE_END)
               i++;

   If a caller ever passes an actions array without a terminating END,
   this walks off the end. The caller already knows
   in->args.vc.actions_n; pass that as the bound and remove the
   dual-mode behavior (count-or-not). The function is only ever called
   with prog_action_count == 0, so the other branch is dead code
   anyway.

5. size == 0 argument is silently accepted but violates the API.

   The rte_flow_action_prog_argument doc states "its size must be
   non-zero and its value must point to a valid array of size bytes".
   The convert code does:

       args[j].size = prog_data->args[j].size;
       if (args[j].size == 0)
               continue;

   This leaves args[j].value == NULL while args[j].size == 0 and hands
   that to the PMD. Either reject size == 0 at parse time, or treat it
   as an error during conversion. Letting it through means
   valid-looking input produces an API-contract violation that the PMD
   has no obligation to handle.

Warnings

6. Identifiers with a leading double underscore are reserved.

   __prog_argument_name_args_push, __prog_argument_size_args_push, and
   __prog_argument_value_args_push use a "__" prefix. The C standard
   reserves names starting with two underscores for the implementation.
   Rename to e.g. prog_argument_name_args_push.

7. RTE_SET_USED on parameters that are used.

   parse_vc_action_prog_argument() marks token and str as unused, then
   passes both to parse_default(). parse_vc_action_prog_argument_value()
   marks size as unused, then passes it to parse_vc_conf(). The v2
   changelog says "Fixed compilation warning"; these spurious
   RTE_SET_USED calls look like that fix. Remove them -- they mislead
   future readers and can hide a real unused parameter if one is added
   later.

8. Doxygen parameter name mismatch.

   The comment block above convert_action_prog_to_rte_flow() documents
   "@param action_count" but the actual parameter is named
   prog_action_count. The same comment describes a dual-mode interface
   ("If 0, will count until END action") that is never exercised --
   fix the name or simplify the interface.

9. No testpmd user-guide update.

   This adds new CLI syntax

       actions prog name <name> argument name <n> size <s> value <v>

   but doc/guides/testpmd_app_ug/testpmd_funcs.rst is not updated.
   Users have no documented way to learn the syntax.

10. No release notes update.

    A new user-visible testpmd feature should have a one-line entry in
    the current release notes.

Info

11. The static "struct arg arg[ACTION_PROG_MAX_ARGS]" arrays inside the
    three __prog_argument_*_args_push helpers can simply be a single
    non-static "struct arg" (or three) on the stack. push_args()
    consumes the entries during the current parse_vc_conf() call;
    persistent storage across CLI invocations is not needed and
    obscures the lifetime.

12. action_prog_data.length is written by the COMMON_STRING parser for
    the prog name field but never read afterwards (convert uses strdup,
    relying on NUL termination). It is required as a destination for
    the COMMON_STRING args triple, but a brief comment would prevent
    the next reader from thinking it is meaningful state.

