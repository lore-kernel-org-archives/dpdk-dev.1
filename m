Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2851DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 08:26:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E37D340616;
	Mon,  6 Jul 2026 10:26:12 +0200 (CEST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51]) by mails.dpdk.org (Postfix) with ESMTP id CC97A40615
 for <dev@dpdk.org>; Mon,  6 Jul 2026 10:26:11 +0200 (CEST)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-9696319e14dso1056298241.3
 for <dev@dpdk.org>; Mon, 06 Jul 2026 01:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783326371; cv=none;
 d=google.com; s=arc-20260327;
 b=bktXyGeVAnmU2iIhaUVRhegJEVa3N6vs1XwBf5X5dw5f5dqO3EWMSuOvGTVGS0OidO
 9ZU53FSThdIUUHSuj3yd6XgsKl4Ca+4xLb84owiRPsOd02b+CZTCxkL/MrPSMFDCLCxC
 eEpdvRdQJhqVgCinOggKGWCuPP4bFO18GGX+kErojQNjLKwsnCqWR8urT+c9tiz7+R2H
 n9yhXSzIrY5HYnfUYxZzFb/GlcTJRMR+v8IxNXKtNJhGfXfQxJ8S0J+HCirs0YiIUT13
 ddiQNYtjpUUwAU/rvSxyT8L5Y3XhUNyrqmyMGDJ0rg+xladrnBd2M2YI4z0m8puhQNg8
 7baA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dA73K/aGkGZQqWL6/Xy2typd6NVE263rErSvynd18/g=;
 fh=jVaP9gxX1x1TFwO1iXJSDWaso8UYI9yN08he86GUpug=;
 b=nCYG/ryO4KEwB/y5ekutE45ddp08qsH9UkZDNqk9GqbKoWsMeaPLcK8wYqq6xkaTWg
 /cvHG9EbLZ3XAK6VS9ZPN1D4mZM/BLbASpieQmf/wrY+4iXeHTiGInPxvh0nc08sGeGo
 Zs7esNBOeSb+/eGs51K89PPEwgE5nleGsBhh7/NAMRZrOm8M5fYilD8LykEPDtC5tKBS
 Bdjw5h1vdSa09zMMoGgAUg6fa900Y0vjcPJYFdCMPvjMMmyfYmncfUSHbWQh/F6cj/zl
 +fdAtnK9J4rkZ6k9e+luExq4zz3uHcRz6Mpy4rWkK5+nlVadBZ7qz/62DpXDRX8YKHad
 3b5g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783326371;
 x=1783931171; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dA73K/aGkGZQqWL6/Xy2typd6NVE263rErSvynd18/g=;
 b=M8Q3Y/ztYEVj8g0nNpuFVUXRzjR34vwAb8fbxY9/ulYfV7X7uNVpWBAexvgnpxZqui
 KcROd1evmc2+8OBklX2Pc3L+AbO4pt4TEqv8QBy1j7yzAKWRedVyUjsyX7YAqBV2iZ00
 xTU/i95DIJf3G+Z5JOkTFxUU1FRBuymvnCkds+BQIMKDM+zj68YgvGbFLxauxHj7qbt6
 TNkGsr2pwNlbZorPs1hUtvcflxbku8evJws7UXPVFjbGAIZXrxHGT8GVkBJIEddOM+lR
 jk22dJgSsfvJNQ13N7zuaD0ESiSCKBThLw0fNxprn+aH5oTqvFqZtmGHfYs9lbcMW03T
 XOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783326371; x=1783931171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA73K/aGkGZQqWL6/Xy2typd6NVE263rErSvynd18/g=;
 b=Jy+jEjXpBBspY0w42STz7EFEY8dABRNlrEzAIBPCLwrlVJvl35XtJ48k5Ib7B9fW7v
 XYTd3QOraH1uvDZ7UDOwLxhdWiAI0EK9m8pOUVMSyE3IfO1hCH+JewQgZDnWbUuh0xXQ
 kl+mIHbl9HMlWqjbUO2MlnkbIQFAwWQ4uD3OuOyZmWf6C1QKKcp7qCkZMNsXKmnIE8QC
 1jV2GslR8spvK1xDlnZ3miLrKwnVAxhFIJPC1E2XW1ES0ZqsKU8WtsdK29bBrmFSeUyA
 y+bRuYcWraxlUqOLyQXTlyrIXNo3rsh7zfsBYzkj4VXJPHkslV9jYndajpOkIk2LHt5w
 g/PQ==
X-Gm-Message-State: AOJu0Yx5M4OlWjTVHqv5owUH4DFU6r3c50ANMB8UYW4ewK0Vg0EIKuhx
 FLPTrPXTZ7ZzIf4VX01KG6lH4nPRZAckCAojjNXe/mxaGiA/T0vdTk1j4kSS/qM7c1dyQO0X8h0
 L1xZfil1TkTL0aVd12Vclq77hdRV5YRaaiLeTVvVRJA==
X-Gm-Gg: AfdE7clzpD/TGv/JZZvN+vX9pc+2C9q0aNw+rDONsB3eDV14kQy/2yB2WAsWSHho8lx
 9rwol3BmYHjFIoVp2ttKOLGb79Uocq6TFvbDPEsMPn6Jbp9L3IOQ/FFoKcBKFr0iepmNrkXWvDX
 qMKkniXLWS+U5ZhO3wxpF17EjyrGOHpRb9SSkYB9Zq88PBOyXPHpmfKeUhR5T/JzhugOUvZS7wn
 zKj3C7pcO0Vr5aLoux7IGrk+1piQqEFo+iynElTrmGIBga8uIqvvEvj+aXMrLw6CsdbLePI
X-Received: by 2002:a05:6102:292a:b0:73e:9fae:5844 with SMTP id
 ada2fe7eead31-7427f7c09f6mr2646348137.27.1783326369679; Mon, 06 Jul 2026
 01:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
 <20260705084415.1389340-1-pushpendra1x.kumar@intel.com>
 <CAOaVG15QiN6z8queMZmrFNN5xdii4r5G08R8smhLcnjSht7MRA@mail.gmail.com>
 <SJ0PR11MB5865204AD69038DEF60D76FBDAF22@SJ0PR11MB5865.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5865204AD69038DEF60D76FBDAF22@SJ0PR11MB5865.namprd11.prod.outlook.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 6 Jul 2026 10:25:57 +0200
X-Gm-Features: AVVi8CcKeiRKzmM7fvdiXUZB9D86Zkj-fVMXf508hm2Ys4m8LRHrEGZoJZHBDuk
Message-ID: <CAOaVG154fhVGoGrvVSfSbZG2KvnLmVzNQf70Svbung8Xvqy3sg@mail.gmail.com>
Subject: Re: [PATCH v2] pdump: fix teardown race with opt-in MP request mode
To: "Kumar, Pushpendra1X" <pushpendra1x.kumar@intel.com>
Cc: dev <dev@dpdk.org>, stable <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 "Pattan, Reshma" <reshma.pattan@intel.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, 
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, "Richardson,
 Bruce" <bruce.richardson@intel.com>, 
 14pwcse1224@uetpeshawar.edu.pk, pushpendra.kumar@tieto.com
Content-Type: multipart/alternative; boundary="000000000000c89c890655ed0689"
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

--000000000000c89c890655ed0689
Content-Type: text/plain; charset="UTF-8"

Not registering pdump in secondary means there is no capture in secondary.
Still think that is misuse

On Sun, Jul 5, 2026, 23:08 Kumar, Pushpendra1X <pushpendra1x.kumar@intel.com>
wrote:

> Hi Stephen,
>
>
>
> Thanks for taking time to review.
>
>
>
> Just to clarify, the async ENABLE/DISABLE approach was part of v1 and I
>
> dropped that direction in v2.
>
>
>
> The current proposal still uses synchronous request handling. The EAL
>
> change is only intended to allow pdump to ignore peers that do not
>
> register the pdump action, while preserving existing
>
> rte_mp_request_sync() semantics for current users.
>
>
>
> The generation tracking and inflight synchronization added in pdump are
>
> there to prevent teardown races from delayed processing after a DISABLE
>
> request, not to make enable/disable asynchronous. The intent is simply
>
> to avoid releasing shared resources while another secondary may still be
>
> processing a previously forwarded request.
>
> I may be being overly cautious here, but I'd appreciate your thoughts on
>
> whether you consider this protection unnecessary.
>
>
>
> My concern is that the forwarding model currently assumes all
>
> secondaries participate in pdump, while EAL does not enforce or track
>
> that assumption.
>
>
>
> On the other hand, if EAL were to handle this generically, it would need
>
> a mechanism to determine which secondary processes have registered a
>
> given action before forwarding requests. The proposed API remains
>
> generic, while pdump is simply its first user.
>
>
>
> Thanks,
>
> Pushpendra
>
>
>
> *From:* Stephen Hemminger <stephen@networkplumber.org>
> *Sent:* Sunday, July 5, 2026 11:58 PM
> *To:* Kumar, Pushpendra1X <pushpendra1x.kumar@intel.com>
> *Cc:* dev <dev@dpdk.org>; stable <stable@dpdk.org>; Thomas Monjalon <
> thomas@monjalon.net>; Pattan, Reshma <reshma.pattan@intel.com>; Burakov,
> Anatoly <anatoly.burakov@intel.com>; Dmitry Kozlyuk <
> dmitry.kozliuk@gmail.com>; Richardson, Bruce <bruce.richardson@intel.com>;
> 14pwcse1224@uetpeshawar.edu.pk; pushpendra.kumar@tieto.com
> *Subject:* Re: [PATCH v2] pdump: fix teardown race with opt-in MP request
> mode
>
>
>
> Root cause is not calling rte_pdump_init in secondary. This should be
> detected or fixed automatically by EAL. Working around with async adds
> unnecessary complexity
>
>
>
> On Sun, Jul 5, 2026, 01:48 Pushpendra Kumar <pushpendra1x.kumar@intel.com>
> wrote:
>
> This change addresses two pdump teardown failure cases:
>
> 1. A requester secondary can time out if a forwarded secondary is slow,
>    unresponsive, or does not implement rte_pdump_init().
> 2. After a DISABLE request times out, the requester secondary receives
>    the reply and releases shared resources, which other slow or
>    unresponsive secondaries may access, leading to a crash.
>
> Add an opt-in EAL multiprocess request mode that allows a caller to
> ignore peers that do not implement the requested action, while preserving
> the existing rte_mp_request_sync() behavior for legacy users.
>
> pdump uses this new mode when forwarding enable/disable requests and adds
> the following behavior:
> - track request generation so stale callbacks cannot act on a newer
>   enable/disable cycle
> - wait for in-flight callbacks to drain before completing disable
> - prevent shared resource teardown from racing with delayed secondary
>   processing
> - keep pdump intent-driven without extra consumer-specific workaround
>   logic
>
> The EAL change is required because the current mp request path treats
> a missing action as a failure, which cannot satisfy pdump's needs without
> changing behavior for all existing users. The new API is opt-in, so
> existing callers of rte_mp_request_sync() keep their current semantics.
>
> Validation:
> - Baseline-vs-changes benchmark used DPDK-native test-pmd as primary and
>   dumpcap as secondary.
> - Both runs captured 1024 packets with the same packet-count exit
>   condition.
> - A 5-second perf stat sample on the forwarding primary showed no
>   meaningful regression: with changes recorded 12,402,055,320 cycles and
>   17,391,769,084 instructions, versus 12,450,031,900 cycles and
>   17,499,706,053 instructions on the parent baseline.
> - The extra synchronization in the hot path did not show material
>   overhead in this sample.
>
> Fixes: c3ceb8742295 ("pdump: forward callback enable to secondary process")
> Signed-off-by: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
>
> Cc: stable@dpdk.org
> ---
> This V2 patch addresses two pdump teardown failure scenarios:
>
> - A requester secondary can time out if a forwarded secondary is slow,
>   unresponsive, or does not implement rte_pdump_init().
> - A delayed DISABLE reply can race with requester-side teardown, which may
>   lead to crashes if peer processes still access shared pdump resources.
>
> To fix this end-to-end:
> - EAL adds an opt-in MP request mode to ignore peers with no matching
> action,
>   while preserving legacy rte_mp_request_sync() behavior.
> - pdump uses that mode, tracks generation, and waits for in-flight
> callbacks
>   to drain before completing disable.
> - dumpcap and pdump app cleanup paths are fail-closed when disable does not
>   complete successfully.
>
> If this direction is accepted, I can split from the next revision into a
> focused EAL patch followed by pdump and app-user updates.
>
>  .mailmap                               |   1 +
>  app/dumpcap/main.c                     |  23 ++-
>  app/pdump/main.c                       |  32 +++-
>  doc/guides/rel_notes/release_26_07.rst |   7 +
>  lib/eal/common/eal_common_proc.c       |  37 +++-
>  lib/eal/include/rte_eal.h              |  33 ++++
>  lib/eal/windows/eal_mp.c               |   9 +
>  lib/pdump/rte_pdump.c                  | 241 ++++++++++++++++++++++---
>  lib/pdump/rte_pdump.h                  |  40 +++-
>  9 files changed, 379 insertions(+), 44 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index c5bc728fae..c1313c7148 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1332,6 +1332,7 @@ Przemyslaw Gierszynski <
> przemyslaw.gierszynski@intel.com>
>  Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
>  Przemyslaw Zegan <przemyslawx.zegan@intel.com>
>  Pu Xu <583493798@qq.com>
> +Pushpendra Kumar <pushpendra1x.kumar@intel.com>
>  Qi Fu <qi.fu@intel.com>
>  Qi Zhang <qi.z.zhang@intel.com>
>  Qian Hao <qi_an_hao@126.com>
> diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
> index 46a6cb251e..f421a17034 100644
> --- a/app/dumpcap/main.c
> +++ b/app/dumpcap/main.c
> @@ -521,14 +521,33 @@ static void
>  cleanup_pdump_resources(void)
>  {
>         struct interface *intf;
> +       int ret;
> +       bool disable_failed = false;
>
>         TAILQ_FOREACH(intf, &interfaces, next) {
> -               rte_pdump_disable(intf->port,
> -                                 RTE_PDUMP_ALL_QUEUES,
> RTE_PDUMP_FLAG_RXTX);
> +               ret = rte_pdump_disable(intf->port,
> +                                       RTE_PDUMP_ALL_QUEUES,
> RTE_PDUMP_FLAG_RXTX);
> +               if (ret < 0) {
> +                       disable_failed = true;
> +                       fprintf(stderr,
> +                               "Disable pdump failed on %u:%s: %s\n",
> +                               intf->port, intf->name,
> +                               rte_strerror(rte_errno));
> +               }
>                 if (intf->opts.promisc_mode)
>                         rte_eth_promiscuous_disable(intf->port);
>         }
>
> +       if (disable_failed) {
> +               /*
> +                * Fail-closed: if disable did not complete, keep pdump
> action/state
> +                * alive and do not uninit shared capture resources.
> +                */
> +               fprintf(stderr,
> +                       "Skipping pdump uninit because disable did not
> complete on all interfaces\n");
> +               return;
> +       }
> +
>         rte_pdump_uninit();
>  }
>
> diff --git a/app/pdump/main.c b/app/pdump/main.c
> index 1e62c8adc1..4cfb038395 100644
> --- a/app/pdump/main.c
> +++ b/app/pdump/main.c
> @@ -451,14 +451,17 @@ print_pdump_stats(void)
>         }
>  }
>
> -static inline void
> +static inline int
>  disable_pdump(struct pdump_tuples *pt)
>  {
>         if (pt->dump_by_type == DEVICE_ID)
> -               rte_pdump_disable_by_deviceid(pt->device_id, pt->queue,
> -                                               pt->dir);
> +               return rte_pdump_disable_by_deviceid(pt->device_id,
> pt->queue,
> +                                                    pt->dir);
>         else if (pt->dump_by_type == PORT_ID)
> -               rte_pdump_disable(pt->port, pt->queue, pt->dir);
> +               return rte_pdump_disable(pt->port, pt->queue, pt->dir);
> +
> +       rte_errno = EINVAL;
> +       return -EINVAL;
>  }
>
>  static inline void
> @@ -518,15 +521,30 @@ static void
>  cleanup_pdump_resources(void)
>  {
>         int i;
> +       int ret;
> +       bool disable_failed = false;
>         struct pdump_tuples *pt;
>         char name[RTE_ETH_NAME_MAX_LEN];
>
> -       /* disable pdump and free the pdump_tuple resources */
> +       /* Disable all callbacks first; freeing shared objects before this
> is unsafe. */
>         for (i = 0; i < num_tuples; i++) {
>                 pt = &pdump_t[i];
>
> -               /* remove callbacks */
> -               disable_pdump(pt);
> +               ret = disable_pdump(pt);
> +               if (ret < 0) {
> +                       disable_failed = true;
> +                       printf("pdump disable failed (tuple=%d, errno=%d:
> %s); "
> +                              "skip teardown to avoid stale callback
> access\n",
> +                              i, rte_errno, rte_strerror(rte_errno));
> +               }
> +       }
> +
> +       if (disable_failed)
> +               return;
> +
> +       /* free the pdump_tuple resources */
> +       for (i = 0; i < num_tuples; i++) {
> +               pt = &pdump_t[i];
>
>                 /*
>                 * transmit rest of the enqueued packets of the rings on to
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index 4ca0a9ac77..1700a56bc7 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -177,6 +177,13 @@ New Features
>    Added AGENTS.md file for AI review
>    and supporting scripts to review patches and documentation.
>
> +* **Hardened pdump teardown on disable failure.**
> +
> +  Hardened pdump request completion and application cleanup behavior so
> timeout
> +  or disable failure does not trigger premature pdump resource teardown.
> +  pdump now uses an opt-in MP request mode that ignores peers without the
> +  pdump action, while preserving legacy EAL MP behavior for all other
> users.
> +
>
>  Removed Items
>  -------------
> diff --git a/lib/eal/common/eal_common_proc.c
> b/lib/eal/common/eal_common_proc.c
> index 06f151818c..5a458c0417 100644
> --- a/lib/eal/common/eal_common_proc.c
> +++ b/lib/eal/common/eal_common_proc.c
> @@ -56,6 +56,7 @@ static struct action_entry_list action_entry_list =
>  enum mp_type {
>         MP_MSG, /* Share message with peers, will not block */
>         MP_REQ, /* Request for information, Will block for a reply */
> +       MP_REQ_IGN, /* Request where missing action should return ignore */
>         MP_REP, /* Response to previously-received request */
>         MP_IGN, /* Response telling requester to ignore this response */
>  };
> @@ -384,11 +385,11 @@ process_msg(struct mp_msg_internal *m, struct
> sockaddr_un *s)
>         pthread_mutex_unlock(&mp_mutex_action);
>
>         if (!action) {
> -               if (m->type == MP_REQ && !internal_conf->init_complete) {
> -                       /* if this is a request, and init is not yet
> complete,
> -                        * and callback wasn't registered, we should tell
> the
> -                        * requester to ignore our existence because we're
> not
> -                        * yet ready to process this request.
> +               if ((m->type == MP_REQ && !internal_conf->init_complete) ||
> +                   m->type == MP_REQ_IGN) {
> +                       /*
> +                        * Ask requester to ignore this peer when action
> is not
> +                        * registered either due to early init or explicit
> request policy.
>                          */
>                         struct rte_mp_msg dummy;
>
> @@ -936,7 +937,8 @@ mp_request_async(const char *dst, struct rte_mp_msg
> *req,
>
>  static int
>  mp_request_sync(const char *dst, struct rte_mp_msg *req,
> -              struct rte_mp_reply *reply, const struct timespec *ts)
> +              struct rte_mp_reply *reply, const struct timespec *ts,
> +              enum mp_type req_type)
>  {
>         int ret;
>         pthread_condattr_t attr;
> @@ -959,7 +961,7 @@ mp_request_sync(const char *dst, struct rte_mp_msg
> *req,
>                 return -1;
>         }
>
> -       ret = send_msg(dst, req, MP_REQ);
> +       ret = send_msg(dst, req, req_type);
>         if (ret < 0) {
>                 EAL_LOG(ERR, "Fail to send request %s:%s",
>                         dst, req->name);
> @@ -1010,11 +1012,20 @@ RTE_EXPORT_SYMBOL(rte_mp_request_sync)
>  int
>  rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
>                 const struct timespec *ts)
> +{
> +       return rte_mp_request_sync_ex(req, reply, ts, 0);
> +}
> +
> +RTE_EXPORT_SYMBOL(rte_mp_request_sync_ex)
> +int
> +rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,
> +               const struct timespec *ts, uint32_t flags)
>  {
>         int dir_fd, ret = -1;
>         DIR *mp_dir;
>         struct dirent *ent;
>         struct timespec now, end;
> +       enum mp_type req_type = MP_REQ;
>         const struct internal_config *internal_conf =
>                 eal_get_internal_configuration();
>
> @@ -1027,6 +1038,14 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct
> rte_mp_reply *reply,
>         if (check_input(req) != 0)
>                 goto end;
>
> +       if (flags & ~RTE_MP_REQ_F_IGNORE_NO_ACTION) {
> +               rte_errno = EINVAL;
> +               goto end;
> +       }
> +
> +       if (flags & RTE_MP_REQ_F_IGNORE_NO_ACTION)
> +               req_type = MP_REQ_IGN;
> +
>         if (internal_conf->no_shconf) {
>                 EAL_LOG(DEBUG, "No shared files mode enabled, IPC is
> disabled");
>                 rte_errno = ENOTSUP;
> @@ -1046,7 +1065,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct
> rte_mp_reply *reply,
>         /* for secondary process, send request to the primary process only
> */
>         if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
>                 pthread_mutex_lock(&pending_requests.lock);
> -               ret = mp_request_sync(eal_mp_socket_path(), req, reply,
> &end);
> +               ret = mp_request_sync(eal_mp_socket_path(), req, reply,
> &end, req_type);
>                 pthread_mutex_unlock(&pending_requests.lock);
>                 goto end;
>         }
> @@ -1086,7 +1105,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct
> rte_mp_reply *reply,
>                 /* unlocks the mutex while waiting for response,
>                  * locks on receive
>                  */
> -               if (mp_request_sync(path, req, reply, &end))
> +               if (mp_request_sync(path, req, reply, &end, req_type))
>                         goto unlock_end;
>         }
>         ret = 0;
> diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
> index 7241f3be5d..415b974945 100644
> --- a/lib/eal/include/rte_eal.h
> +++ b/lib/eal/include/rte_eal.h
> @@ -173,6 +173,15 @@ struct rte_mp_reply {
>         struct rte_mp_msg *msgs; /* caller to free */
>  };
>
> +/** Request flags for rte_mp_request_sync_ex(). */
> +enum rte_mp_request_flags {
> +       /**
> +        * Ask peers that do not have a registered action to return MP_IGN
> +        * instead of causing timeout for this request.
> +        */
> +       RTE_MP_REQ_F_IGNORE_NO_ACTION = 1u << 0,
> +};
> +
>  /**
>   * Action function typedef used by other components.
>   *
> @@ -292,6 +301,30 @@ int
>  rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
>                const struct timespec *ts);
>
> +/**
> + * Send a request to peer processes with explicit request flags.
> + *
> + * This API is equivalent to rte_mp_request_sync() with opt-in behavior
> + * controls provided through @p flags.
> + *
> + * @param req
> + *   The req argument contains the customized request message.
> + * @param reply
> + *   The reply argument will be for storing all the replied messages;
> + *   the caller is responsible for free reply->msgs.
> + * @param ts
> + *   The ts argument specifies how long we can wait for the peer(s) to
> reply.
> + * @param flags
> + *   Bitmask of values from enum rte_mp_request_flags.
> + *
> + * @return
> + *  - On success, return 0.
> + *  - On failure, return -1, and the reason will be stored in rte_errno.
> + */
> +int
> +rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,
> +               const struct timespec *ts, uint32_t flags);
> +
>  /**
>   * Send a request to the peer process and expect a reply in a separate
> callback.
>   *
> diff --git a/lib/eal/windows/eal_mp.c b/lib/eal/windows/eal_mp.c
> index 6703355318..1066a4d2bc 100644
> --- a/lib/eal/windows/eal_mp.c
> +++ b/lib/eal/windows/eal_mp.c
> @@ -56,10 +56,19 @@ RTE_EXPORT_SYMBOL(rte_mp_request_sync)
>  int
>  rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
>         const struct timespec *ts)
> +{
> +       return rte_mp_request_sync_ex(req, reply, ts, 0);
> +}
> +
> +RTE_EXPORT_SYMBOL(rte_mp_request_sync_ex)
> +int
> +rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,
> +       const struct timespec *ts, uint32_t flags)
>  {
>         RTE_SET_USED(req);
>         RTE_SET_USED(reply);
>         RTE_SET_USED(ts);
> +       RTE_SET_USED(flags);
>         EAL_LOG_NOT_IMPLEMENTED();
>         return -1;
>  }
> diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
> index ac94efe7ff..3764aeb2d3 100644
> --- a/lib/pdump/rte_pdump.c
> +++ b/lib/pdump/rte_pdump.c
> @@ -3,9 +3,12 @@
>   */
>
>  #include <stdlib.h>
> +#include <errno.h>
>
>  #include <eal_export.h>
> +#include <rte_eal.h>
>  #include <rte_alarm.h>
> +#include <rte_cycles.h>
>  #include <rte_mbuf.h>
>  #include <rte_ethdev.h>
>  #include <rte_lcore.h>
> @@ -68,6 +71,7 @@ struct pdump_request {
>
>         const struct rte_bpf_prm *prm;
>         uint32_t snaplen;
> +       uint32_t generation;
>  };
>
>  struct pdump_response {
> @@ -81,6 +85,11 @@ struct pdump_bundle {
>         char peer[];
>  };
>
> +struct pdump_shared_ctl {
> +       RTE_ATOMIC(uint32_t) enabled;
> +       RTE_ATOMIC(uint32_t) inflight;
> +};
> +
>  static struct pdump_rxtx_cbs {
>         struct rte_ring *ring;
>         struct rte_mempool *mp;
> @@ -88,11 +97,11 @@ static struct pdump_rxtx_cbs {
>         const struct rte_bpf *filter;
>         enum pdump_version ver;
>         uint32_t snaplen;
> +       uint32_t generation;
>         RTE_ATOMIC(uint32_t) use_count;
>  } rx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT],
>  tx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
>
> -
>  /*
>   * The packet capture statistics keep track of packets
>   * accepted, filtered and dropped. These are per-queue
> @@ -102,9 +111,59 @@ static const char MZ_RTE_PDUMP_STATS[] =
> "rte_pdump_stats";
>  static struct {
>         struct rte_pdump_stats
> rx[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
>         struct rte_pdump_stats
> tx[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
> +       struct pdump_shared_ctl
> rx_ctl[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
> +       struct pdump_shared_ctl
> tx_ctl[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
> +       RTE_ATOMIC(uint32_t) generation;
>         const struct rte_memzone *mz;
>  } *pdump_stats;
>
> +static int
> +pdump_enter(struct pdump_shared_ctl *ctl, const struct pdump_rxtx_cbs
> *cbs)
> +{
> +       uint32_t generation =
> rte_atomic_load_explicit(&pdump_stats->generation,
> +
> rte_memory_order_relaxed);
> +
> +       if (rte_atomic_load_explicit(&ctl->enabled,
> rte_memory_order_relaxed) == 0 ||
> +           cbs->generation != generation)
> +               return 0;
> +
> +       rte_atomic_fetch_add_explicit(&ctl->inflight, 1,
> rte_memory_order_acquire);
> +
> +       /*
> +        * Disable/re-enable may race with callback entry. Re-check
> enabled and
> +        * generation after taking inflight reference so disable can wait
> for this
> +        * callback to drain and stale callbacks become no-op.
> +        */
> +       generation = rte_atomic_load_explicit(&pdump_stats->generation,
> +                                            rte_memory_order_relaxed);
> +       if (rte_atomic_load_explicit(&ctl->enabled,
> rte_memory_order_relaxed) != 0 &&
> +           cbs->generation == generation)
> +               return 1;
> +
> +       rte_atomic_fetch_sub_explicit(&ctl->inflight, 1,
> rte_memory_order_release);
> +       return 0;
> +}
> +
> +static __rte_always_inline void
> +pdump_exit(struct pdump_shared_ctl *ctl)
> +{
> +       rte_atomic_fetch_sub_explicit(&ctl->inflight, 1,
> rte_memory_order_release);
> +}
> +
> +static int
> +pdump_wait_inflight(struct pdump_shared_ctl *ctl)
> +{
> +       uint64_t end_tsc = rte_get_timer_cycles() + MP_TIMEOUT_S *
> rte_get_timer_hz();
> +
> +       while (rte_atomic_load_explicit(&ctl->inflight,
> rte_memory_order_acquire) != 0) {
> +               if (rte_get_timer_cycles() > end_tsc)
> +                       return -ETIMEDOUT;
> +               rte_pause();
> +       }
> +
> +       return 0;
> +}
> +
>  static void
>  pdump_cb_wait(struct pdump_rxtx_cbs *cbs)
>  {
> @@ -224,12 +283,17 @@ pdump_rx(uint16_t port, uint16_t queue,
>         uint16_t max_pkts __rte_unused, void *user_params)
>  {
>         struct pdump_rxtx_cbs *cbs = user_params;
> +       struct pdump_shared_ctl *ctl = &pdump_stats->rx_ctl[port][queue];
>         struct rte_pdump_stats *stats = &pdump_stats->rx[port][queue];
>
> +       if (!pdump_enter(ctl, cbs))
> +               return nb_pkts;
> +
>         pdump_cb_hold(cbs);
>         pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_IN,
>                    pkts, nb_pkts, cbs, stats);
>         pdump_cb_release(cbs);
> +       pdump_exit(ctl);
>
>         return nb_pkts;
>  }
> @@ -239,12 +303,17 @@ pdump_tx(uint16_t port, uint16_t queue,
>                 struct rte_mbuf **pkts, uint16_t nb_pkts, void
> *user_params)
>  {
>         struct pdump_rxtx_cbs *cbs = user_params;
> +       struct pdump_shared_ctl *ctl = &pdump_stats->tx_ctl[port][queue];
>         struct rte_pdump_stats *stats = &pdump_stats->tx[port][queue];
>
> +       if (!pdump_enter(ctl, cbs))
> +               return nb_pkts;
> +
>         pdump_cb_hold(cbs);
>         pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_OUT,
>                    pkts, nb_pkts, cbs, stats);
>         pdump_cb_release(cbs);
> +       pdump_exit(ctl);
>
>         return nb_pkts;
>  }
> @@ -255,20 +324,43 @@ pdump_register_rx_callbacks(enum pdump_version ver,
>                             uint16_t end_q, uint16_t port, uint16_t queue,
>                             struct rte_ring *ring, struct rte_mempool *mp,
>                             struct rte_bpf *filter,
> -                           uint16_t operation, uint32_t snaplen)
> +                           uint16_t operation, uint32_t snaplen,
> +                           uint32_t generation)
>  {
>         uint16_t qid;
>
>         qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
>         for (; qid < end_q; qid++) {
>                 struct pdump_rxtx_cbs *cbs = &rx_cbs[port][qid];
> +               struct pdump_shared_ctl *ctl =
> &pdump_stats->rx_ctl[port][qid];
>
>                 if (operation == ENABLE) {
> +                       int ret;
> +
>                         if (cbs->cb) {
> -                               PDUMP_LOG_LINE(ERR,
> -                                       "rx callback for port=%d queue=%d,
> already exists",
> -                                       port, qid);
> -                               return -EEXIST;
> +                               if (cbs->generation == generation &&
> +                                   rte_atomic_load_explicit(&ctl->enabled,
> +                                           rte_memory_order_relaxed) !=
> 0) {
> +                                       PDUMP_LOG_LINE(ERR,
> +                                               "rx callback for port=%d
> queue=%d, already exists",
> +                                               port, qid);
> +                                       return -EEXIST;
> +                               }
> +
> +                               PDUMP_LOG_LINE(DEBUG,
> +                                       "reconciling stale rx callback for
> port=%d queue=%d"
> +                                       " old_gen=%u new_gen=%u",
> +                                       port, qid, cbs->generation,
> generation);
> +
> +                               ret = rte_eth_remove_rx_callback(port,
> qid, cbs->cb);
> +                               if (ret < 0) {
> +                                       PDUMP_LOG_LINE(ERR,
> +                                               "failed to reconcile stale
> rx callback, errno=%d",
> +                                               -ret);
> +                                       return ret;
> +                               }
> +                               pdump_cb_wait(cbs);
> +                               cbs->cb = NULL;
>                         }
>                         cbs->use_count = 0;
>                         cbs->ver = ver;
> @@ -276,6 +368,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
>                         cbs->mp = mp;
>                         cbs->snaplen = snaplen;
>                         cbs->filter = filter;
> +                       cbs->generation = generation;
>
>                         cbs->cb = rte_eth_add_first_rx_callback(port, qid,
>                                                                 pdump_rx,
> cbs);
> @@ -286,10 +379,15 @@ pdump_register_rx_callbacks(enum pdump_version ver,
>                                 return rte_errno;
>                         }
>
> +                       rte_atomic_store_explicit(&ctl->inflight, 0,
> rte_memory_order_relaxed);
> +                       rte_atomic_store_explicit(&ctl->enabled, 1,
> rte_memory_order_release);
> +
>                         memset(&pdump_stats->rx[port][qid], 0,
> sizeof(struct rte_pdump_stats));
>                 } else if (operation == DISABLE) {
>                         int ret;
>
> +                       rte_atomic_store_explicit(&ctl->enabled, 0,
> rte_memory_order_release);
> +
>                         if (cbs->cb == NULL) {
>                                 PDUMP_LOG_LINE(ERR,
>                                         "no existing rx callback for
> port=%d queue=%d",
> @@ -298,6 +396,11 @@ pdump_register_rx_callbacks(enum pdump_version ver,
>                         }
>                         ret = rte_eth_remove_rx_callback(port, qid,
> cbs->cb);
>                         if (ret < 0) {
> +                               /* Keep state coherent: callback is still
> registered,
> +                                * so restore enabled.
> +                                */
> +                               rte_atomic_store_explicit(&ctl->enabled, 1,
> +                                               rte_memory_order_release);
>                                 PDUMP_LOG_LINE(ERR,
>                                         "failed to remove rx callback,
> errno=%d",
>                                         -ret);
> @@ -305,6 +408,10 @@ pdump_register_rx_callbacks(enum pdump_version ver,
>                         }
>                         pdump_cb_wait(cbs);
>                         cbs->cb = NULL;
> +
> +                       ret = pdump_wait_inflight(ctl);
> +                       if (ret < 0)
> +                               return ret;
>                 }
>         }
>
> @@ -316,7 +423,8 @@ pdump_register_tx_callbacks(enum pdump_version ver,
>                             uint16_t end_q, uint16_t port, uint16_t queue,
>                             struct rte_ring *ring, struct rte_mempool *mp,
>                             struct rte_bpf *filter,
> -                           uint16_t operation, uint32_t snaplen)
> +                           uint16_t operation, uint32_t snaplen,
> +                           uint32_t generation)
>  {
>
>         uint16_t qid;
> @@ -324,13 +432,36 @@ pdump_register_tx_callbacks(enum pdump_version ver,
>         qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
>         for (; qid < end_q; qid++) {
>                 struct pdump_rxtx_cbs *cbs = &tx_cbs[port][qid];
> +               struct pdump_shared_ctl *ctl =
> &pdump_stats->tx_ctl[port][qid];
>
>                 if (operation == ENABLE) {
> +                       int ret;
> +
>                         if (cbs->cb) {
> -                               PDUMP_LOG_LINE(ERR,
> -                                       "tx callback for port=%d queue=%d,
> already exists",
> -                                       port, qid);
> -                               return -EEXIST;
> +                               if (cbs->generation == generation &&
> +                                   rte_atomic_load_explicit(&ctl->enabled,
> +                                           rte_memory_order_relaxed) !=
> 0) {
> +                                       PDUMP_LOG_LINE(ERR,
> +                                               "tx callback for port=%d
> queue=%d, already exists",
> +                                               port, qid);
> +                                       return -EEXIST;
> +                               }
> +
> +                               PDUMP_LOG_LINE(DEBUG,
> +                                       "reconciling stale tx callback for
> port=%d queue=%d"
> +                                       " old_gen=%u new_gen=%u",
> +                                       port, qid, cbs->generation,
> generation);
> +
> +                               ret = rte_eth_remove_tx_callback(port,
> qid, cbs->cb);
> +                               if (ret < 0) {
> +                                       PDUMP_LOG_LINE(ERR,
> +                                               "failed to reconcile stale
> tx callback, errno=%d",
> +                                               -ret);
> +                                       return ret;
> +                               }
> +
> +                               pdump_cb_wait(cbs);
> +                               cbs->cb = NULL;
>                         }
>                         cbs->use_count = 0;
>                         cbs->ver = ver;
> @@ -338,6 +469,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,
>                         cbs->mp = mp;
>                         cbs->snaplen = snaplen;
>                         cbs->filter = filter;
> +                       cbs->generation = generation;
>
>                         cbs->cb = rte_eth_add_tx_callback(port, qid,
> pdump_tx,
>                                                                 cbs);
> @@ -347,10 +479,15 @@ pdump_register_tx_callbacks(enum pdump_version ver,
>                                         rte_errno);
>                                 return rte_errno;
>                         }
> +
> +                       rte_atomic_store_explicit(&ctl->inflight, 0,
> rte_memory_order_relaxed);
> +                       rte_atomic_store_explicit(&ctl->enabled, 1,
> rte_memory_order_release);
>                         memset(&pdump_stats->tx[port][qid], 0,
> sizeof(struct rte_pdump_stats));
>                 } else if (operation == DISABLE) {
>                         int ret;
>
> +                       rte_atomic_store_explicit(&ctl->enabled, 0,
> rte_memory_order_release);
> +
>                         if (cbs->cb == NULL) {
>                                 PDUMP_LOG_LINE(ERR,
>                                         "no existing tx callback for
> port=%d queue=%d",
> @@ -359,6 +496,11 @@ pdump_register_tx_callbacks(enum pdump_version ver,
>                         }
>                         ret = rte_eth_remove_tx_callback(port, qid,
> cbs->cb);
>                         if (ret < 0) {
> +                               /* Keep state coherent: callback is still
> registered,
> +                                * so restore enabled.
> +                                */
> +                               rte_atomic_store_explicit(&ctl->enabled, 1,
> +                                               rte_memory_order_release);
>                                 PDUMP_LOG_LINE(ERR,
>                                         "failed to remove tx callback,
> errno=%d",
>                                         -ret);
> @@ -367,6 +509,10 @@ pdump_register_tx_callbacks(enum pdump_version ver,
>
>                         pdump_cb_wait(cbs);
>                         cbs->cb = NULL;
> +
> +                       ret = pdump_wait_inflight(ctl);
> +                       if (ret < 0)
> +                               return ret;
>                 }
>         }
>
> @@ -459,7 +605,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
>                 end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_rx_q : queue
> + 1;
>                 ret = pdump_register_rx_callbacks(p->ver, end_q, port,
> queue,
>                                                   ring, mp, filter,
> -                                                 operation, p->snaplen);
> +                                                 operation, p->snaplen,
> +                                                 p->generation);
>                 if (ret < 0)
>                         return ret;
>         }
> @@ -469,7 +616,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
>                 end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_tx_q : queue
> + 1;
>                 ret = pdump_register_tx_callbacks(p->ver, end_q, port,
> queue,
>                                                   ring, mp, filter,
> -                                                 operation, p->snaplen);
> +                                                 operation, p->snaplen,
> +                                                 p->generation);
>                 if (ret < 0)
>                         return ret;
>         }
> @@ -477,12 +625,14 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
>         return ret;
>  }
>
> -static void
> -pdump_request_to_secondary(const struct pdump_request *req)
> +static int
> +pdump_request_to_secondary_sync(const struct pdump_request *req)
>  {
>         struct rte_mp_msg mp_req = { };
>         struct rte_mp_reply mp_reply;
>         struct timespec ts = {.tv_sec = MP_TIMEOUT_S, .tv_nsec = 0};
> +       int ret = 0;
> +       uint16_t i;
>
>         PDUMP_LOG_LINE(DEBUG, "forward req %s to secondary",
> pdump_opname(req->op));
>
> @@ -490,14 +640,41 @@ pdump_request_to_secondary(const struct
> pdump_request *req)
>         strlcpy(mp_req.name, PDUMP_MP, sizeof(mp_req.name));
>         mp_req.len_param = sizeof(*req);
>
> -       if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) != 0)
> -               PDUMP_LOG_LINE(ERR, "rte_mp_request_sync failed");
> +       if (rte_mp_request_sync_ex(&mp_req, &mp_reply, &ts,
> +                                   RTE_MP_REQ_F_IGNORE_NO_ACTION) != 0) {
> +               PDUMP_LOG_LINE(ERR, "rte_mp_request_sync failed: %s",
> +                             strerror(rte_errno));
> +               return -rte_errno;
> +       }
>
> -       else if (mp_reply.nb_sent != mp_reply.nb_received)
> +       if (mp_reply.nb_sent != mp_reply.nb_received) {
>                 PDUMP_LOG_LINE(ERR, "not all secondary's replied (sent %u
> recv %u)",
>                                mp_reply.nb_sent, mp_reply.nb_received);
> +               ret = -ETIMEDOUT;
> +       }
> +
> +       for (i = 0; i < mp_reply.nb_received; i++) {
> +               struct rte_mp_msg *mp_rep = &mp_reply.msgs[i];
> +               const struct pdump_response *resp;
> +
> +               if (mp_rep->len_param != sizeof(*resp)) {
> +                       PDUMP_LOG_LINE(ERR, "invalid secondary reply size
> %u", mp_rep->len_param);
> +                       if (ret == 0)
> +                               ret = -EINVAL;
> +                       continue;
> +               }
> +
> +               resp = (const struct pdump_response *)mp_rep->param;
> +               if (resp->err_value != 0) {
> +                       PDUMP_LOG_LINE(ERR, "secondary reply failed: op=%u
> err=%d",
> +                                      resp->res_op, resp->err_value);
> +                       if (ret == 0)
> +                               ret = resp->err_value;
> +               }
> +       }
>
>         free(mp_reply.msgs);
> +       return ret;
>  }
>
>  /* Allocate temporary storage for passing state to the alarm thread for
> deferred handling */
> @@ -556,7 +733,10 @@ pdump_handle_primary_request(const struct rte_mp_msg
> *mp_msg, const void *peer)
>                 PDUMP_LOG_LINE(DEBUG, "secondary pdump %s",
> pdump_opname(req->op));
>
>                 /* Can just do it now, no need for interrupt thread */
> -               ret = set_pdump_rxtx_cbs(req);
> +               if (req->op == ENABLE || req->op == DISABLE)
> +                       ret = set_pdump_rxtx_cbs(req);
> +               else
> +                       ret = -EINVAL;
>         }
>
>         return pdump_send_response(req, ret, peer);
> @@ -569,17 +749,29 @@ __pdump_request(void *param)
>  {
>         struct pdump_bundle *bundle = param;
>         struct rte_mp_msg *msg = &bundle->msg;
> -       const struct pdump_request *req =
> -               (const struct pdump_request *)msg->param;
> +       struct pdump_request *req =
> +               (struct pdump_request *)msg->param;
>         int ret;
>
>         PDUMP_LOG_LINE(DEBUG, "primary pdump %s", pdump_opname(req->op));
>
> +       if (req->op == DISABLE) {
> +               req->generation =
> rte_atomic_fetch_add_explicit(&pdump_stats->generation, 1,
> +
> rte_memory_order_acq_rel) + 1;
> +       } else if (req->op == ENABLE) {
> +               req->generation =
> rte_atomic_load_explicit(&pdump_stats->generation,
> +
> rte_memory_order_acquire);
> +       }
> +
>         ret = set_pdump_rxtx_cbs(req);
>
> -       /* Primary process is responsible for broadcasting request to all
> secondaries */
> +       /*
> +        * Primary process is responsible for broadcasting the request to
> all
> +        * secondaries. The sync request uses opt-in ignore-missing-action
> mode so
> +        * pdump does not depend on unrelated secondary processes.
> +        */
>         if (ret == 0)
> -               pdump_request_to_secondary(req);
> +               ret = pdump_request_to_secondary_sync(req);
>
>         pdump_send_response(req, ret, bundle->peer);
>         free(bundle);
> @@ -659,6 +851,9 @@ rte_pdump_init(void)
>
>         pdump_stats = mz->addr;
>         pdump_stats->mz = mz;
> +       if (rte_eal_process_type() == RTE_PROC_PRIMARY)
> +               rte_atomic_store_explicit(&pdump_stats->generation, 1,
> +                                         rte_memory_order_release);
>
>         return 0;
>  }
> diff --git a/lib/pdump/rte_pdump.h b/lib/pdump/rte_pdump.h
> index 1e32d46097..77e5914420 100644
> --- a/lib/pdump/rte_pdump.h
> +++ b/lib/pdump/rte_pdump.h
> @@ -64,7 +64,7 @@ rte_pdump_uninit(void);
>   *  queues of a given port.
>   * @param flags
>   *  flags specifies
> RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUMP_FLAG_RXTX
> - *  on which packet capturing should be enabled for a given port and
> queue.
> + *  on which packet capturing should be disabled for a given port and
> queue.
>   * @param ring
>   *  ring on which captured packets will be enqueued for user.
>   * @param mp
> @@ -72,6 +72,11 @@ rte_pdump_uninit(void);
>   * @param filter
>   *  Unused should be NULL.
>   *
> + * @note
> + *  In applications that enable capture on multiple interfaces, enable
> may be
> + *  partially applied before an error is returned. Callers should
> explicitly
> + *  unwind partial enable state.
> + *
>   * @return
>   *    0 on success, -1 on error, rte_errno is set accordingly.
>   */
> @@ -103,6 +108,11 @@ rte_pdump_enable(uint16_t port, uint16_t queue,
> uint32_t flags,
>   * @param prm
>   *  Use BPF program to run to filter packes (can be NULL)
>   *
> + * @note
> + *  In applications that enable capture on multiple interfaces, enable
> may be
> + *  partially applied before an error is returned. Callers should
> explicitly
> + *  unwind partial enable state.
> + *
>   * @return
>   *    0 on success, -1 on error, rte_errno is set accordingly.
>   */
> @@ -124,7 +134,14 @@ rte_pdump_enable_bpf(uint16_t port_id, uint16_t queue,
>   *  queues of a given port.
>   * @param flags
>   *  flags specifies
> RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUMP_FLAG_RXTX
> - *  on which packet capturing should be enabled for a given port and
> queue.
> + *  on which packet capturing should be disabled for a given port and
> queue.
> + *
> + * @note
> + *  A disable failure (including timeout/no response) means teardown is
> not
> + *  complete across pdump-enabled peers. The caller must not release
> shared
> + *  pdump resources and must not uninitialize pdump for that capture
> session
> + *  until disable succeeds. Releasing resources on disable failure can
> lead to
> + *  crashes in peer processes still accessing those resources.
>   *
>   * @return
>   *    0 on success, -1 on error, rte_errno is set accordingly.
> @@ -153,6 +170,11 @@ rte_pdump_disable(uint16_t port, uint16_t queue,
> uint32_t flags);
>   * @param filter
>   *  unused should be NULL
>   *
> + * @note
> + *  In applications that enable capture on multiple interfaces, enable
> may be
> + *  partially applied before an error is returned. Callers should
> explicitly
> + *  unwind partial enable state.
> + *
>   * @return
>   *    0 on success, -1 on error, rte_errno is set accordingly.
>   */
> @@ -186,6 +208,11 @@ rte_pdump_enable_by_deviceid(char *device_id,
> uint16_t queue,
>   * @param filter
>   *  Use BPF program to run to filter packes (can be NULL)
>   *
> + * @note
> + *  In applications that enable capture on multiple interfaces, enable
> may be
> + *  partially applied before an error is returned. Callers should
> explicitly
> + *  unwind partial enable state.
> + *
>   * @return
>   *    0 on success, -1 on error, rte_errno is set accordingly.
>   */
> @@ -210,7 +237,14 @@ rte_pdump_enable_bpf_by_deviceid(const char
> *device_id, uint16_t queue,
>   *  queues of a given device id.
>   * @param flags
>   *  flags specifies
> RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUMP_FLAG_RXTX
> - *  on which packet capturing should be enabled for a given port and
> queue.
> + *  on which packet capturing should be disabled for a given port and
> queue.
> + *
> + * @note
> + *  A disable failure (including timeout/no response) means teardown is
> not
> + *  complete across pdump-enabled peers. The caller must not release
> shared
> + *  pdump resources and must not uninitialize pdump for that capture
> session
> + *  until disable succeeds. Releasing resources on disable failure can
> lead to
> + *  crashes in peer processes still accessing those resources.
>   *
>   * @return
>   *    0 on success, -1 on error, rte_errno is set accordingly.
> --
> 2.43.0
>
>

--000000000000c89c890655ed0689
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Not registering pdump in secondary means there is no capt=
ure in secondary. Still think that is misuse</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, J=
ul 5, 2026, 23:08 Kumar, Pushpendra1X &lt;<a href=3D"mailto:pushpendra1x.ku=
mar@intel.com">pushpendra1x.kumar@intel.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-IN" link=3D"blue" vlink=3D"purple" style=3D"overflow-wrap: =
break-word;">
<div class=3D"m_-4574549248435063437WordSection1">
<p class=3D"MsoNormal"><span>Hi Stephen,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>Thanks for taking time to review.<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>Just to clarify, the async ENABLE/DISABLE appr=
oach was part of v1 and I<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>dropped that direction in v2.<u></u><u></u></s=
pan></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>The current proposal still uses synchronous re=
quest handling. The EAL<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>change is only intended to allow pdump to igno=
re peers that do not<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>register the pdump action, while preserving ex=
isting<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>rte_mp_request_sync() semantics for current us=
ers.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>The generation tracking and inflight synchroni=
zation added in pdump are<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>there to prevent teardown races from delayed p=
rocessing after a DISABLE<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>request, not to make enable/disable asynchrono=
us. The intent is simply<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>to avoid releasing shared resources while anot=
her secondary may still be<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>processing a previously forwarded request.<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span>I may be being overly cautious here, but I&#39=
;d appreciate your thoughts on<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>whether you consider this protection unnecessa=
ry.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>My concern is that the forwarding model curren=
tly assumes all<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>secondaries participate in pdump, while EAL do=
es not enforce or track<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>that assumption.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>On the other hand, if EAL were to handle this =
generically, it would need<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>a mechanism to determine which secondary proce=
sses have registered a<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>given action before forwarding requests. The p=
roposed API remains<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>generic, while pdump is simply its first user.=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>Thanks,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span>Pushpendra<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-width:1pt medium medium;border-style:solid none none;b=
order-color:rgb(225,225,225) currentcolor currentcolor;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11pt;font=
-family:Calibri,sans-serif">From:</span></b><span lang=3D"EN-US" style=3D"f=
ont-size:11pt;font-family:Calibri,sans-serif"> Stephen Hemminger &lt;<a hre=
f=3D"mailto:stephen@networkplumber.org" target=3D"_blank" rel=3D"noreferrer=
">stephen@networkplumber.org</a>&gt;
<br>
<b>Sent:</b> Sunday, July 5, 2026 11:58 PM<br>
<b>To:</b> Kumar, Pushpendra1X &lt;<a href=3D"mailto:pushpendra1x.kumar@int=
el.com" target=3D"_blank" rel=3D"noreferrer">pushpendra1x.kumar@intel.com</=
a>&gt;<br>
<b>Cc:</b> dev &lt;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank" rel=3D=
"noreferrer">dev@dpdk.org</a>&gt;; stable &lt;<a href=3D"mailto:stable@dpdk=
.org" target=3D"_blank" rel=3D"noreferrer">stable@dpdk.org</a>&gt;; Thomas =
Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" target=3D"_blank" rel=
=3D"noreferrer">thomas@monjalon.net</a>&gt;; Pattan, Reshma &lt;<a href=3D"=
mailto:reshma.pattan@intel.com" target=3D"_blank" rel=3D"noreferrer">reshma=
.pattan@intel.com</a>&gt;; Burakov, Anatoly &lt;<a href=3D"mailto:anatoly.b=
urakov@intel.com" target=3D"_blank" rel=3D"noreferrer">anatoly.burakov@inte=
l.com</a>&gt;; Dmitry Kozlyuk &lt;<a href=3D"mailto:dmitry.kozliuk@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">dmitry.kozliuk@gmail.com</a>&gt;; R=
ichardson, Bruce &lt;<a href=3D"mailto:bruce.richardson@intel.com" target=
=3D"_blank" rel=3D"noreferrer">bruce.richardson@intel.com</a>&gt;;
 <a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk" target=3D"_blank" rel=3D=
"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>; <a href=3D"mailto:pushpend=
ra.kumar@tieto.com" target=3D"_blank" rel=3D"noreferrer">pushpendra.kumar@t=
ieto.com</a><br>
<b>Subject:</b> Re: [PATCH v2] pdump: fix teardown race with opt-in MP requ=
est mode<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Root cause is not calling rte_pdump_init in secondar=
y. This should be detected or fixed automatically by EAL. Working around wi=
th async adds unnecessary complexity=C2=A0<u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Sun, Jul 5, 2026, 01:48 Pushpendra Kumar &lt;<a h=
ref=3D"mailto:pushpendra1x.kumar@intel.com" target=3D"_blank" rel=3D"norefe=
rrer">pushpendra1x.kumar@intel.com</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-width:medium medium medium 1pt;border-style:non=
e none none solid;border-color:currentcolor currentcolor currentcolor rgb(2=
04,204,204);padding:0in 0in 0in 6pt;margin-left:4.8pt;margin-right:0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">This change addresses t=
wo pdump teardown failure cases:<br>
<br>
1. A requester secondary can time out if a forwarded secondary is slow,<br>
=C2=A0 =C2=A0unresponsive, or does not implement rte_pdump_init().<br>
2. After a DISABLE request times out, the requester secondary receives<br>
=C2=A0 =C2=A0the reply and releases shared resources, which other slow or<b=
r>
=C2=A0 =C2=A0unresponsive secondaries may access, leading to a crash.<br>
<br>
Add an opt-in EAL multiprocess request mode that allows a caller to<br>
ignore peers that do not implement the requested action, while preserving<b=
r>
the existing rte_mp_request_sync() behavior for legacy users.<br>
<br>
pdump uses this new mode when forwarding enable/disable requests and adds<b=
r>
the following behavior:<br>
- track request generation so stale callbacks cannot act on a newer<br>
=C2=A0 enable/disable cycle<br>
- wait for in-flight callbacks to drain before completing disable<br>
- prevent shared resource teardown from racing with delayed secondary<br>
=C2=A0 processing<br>
- keep pdump intent-driven without extra consumer-specific workaround<br>
=C2=A0 logic<br>
<br>
The EAL change is required because the current mp request path treats<br>
a missing action as a failure, which cannot satisfy pdump&#39;s needs witho=
ut<br>
changing behavior for all existing users. The new API is opt-in, so<br>
existing callers of rte_mp_request_sync() keep their current semantics.<br>
<br>
Validation:<br>
- Baseline-vs-changes benchmark used DPDK-native test-pmd as primary and<br=
>
=C2=A0 dumpcap as secondary.<br>
- Both runs captured 1024 packets with the same packet-count exit<br>
=C2=A0 condition.<br>
- A 5-second perf stat sample on the forwarding primary showed no<br>
=C2=A0 meaningful regression: with changes recorded 12,402,055,320 cycles a=
nd<br>
=C2=A0 17,391,769,084 instructions, versus 12,450,031,900 cycles and<br>
=C2=A0 17,499,706,053 instructions on the parent baseline.<br>
- The extra synchronization in the hot path did not show material<br>
=C2=A0 overhead in this sample.<br>
<br>
Fixes: c3ceb8742295 (&quot;pdump: forward callback enable to secondary proc=
ess&quot;)<br>
Signed-off-by: Pushpendra Kumar &lt;<a href=3D"mailto:pushpendra1x.kumar@in=
tel.com" target=3D"_blank" rel=3D"noreferrer">pushpendra1x.kumar@intel.com<=
/a>&gt;<br>
<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"noreferrer"=
>stable@dpdk.org</a><br>
---<br>
This V2 patch addresses two pdump teardown failure scenarios:<br>
<br>
- A requester secondary can time out if a forwarded secondary is slow,<br>
=C2=A0 unresponsive, or does not implement rte_pdump_init().<br>
- A delayed DISABLE reply can race with requester-side teardown, which may<=
br>
=C2=A0 lead to crashes if peer processes still access shared pdump resource=
s.<br>
<br>
To fix this end-to-end:<br>
- EAL adds an opt-in MP request mode to ignore peers with no matching actio=
n,<br>
=C2=A0 while preserving legacy rte_mp_request_sync() behavior.<br>
- pdump uses that mode, tracks generation, and waits for in-flight callback=
s<br>
=C2=A0 to drain before completing disable.<br>
- dumpcap and pdump app cleanup paths are fail-closed when disable does not=
<br>
=C2=A0 complete successfully.<br>
<br>
If this direction is accepted, I can split from the next revision into a<br=
>
focused EAL patch followed by pdump and app-user updates.<br>
<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0app/dumpcap/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 23 ++-<br>
=C2=A0app/pdump/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 32 +++-<br>
=C2=A0doc/guides/rel_notes/release_26_07.rst |=C2=A0 =C2=A07 +<br>
=C2=A0lib/eal/common/eal_common_proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 37=
 +++-<br>
=C2=A0lib/eal/include/rte_eal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 33 ++++<br>
=C2=A0lib/eal/windows/eal_mp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A09 +<br>
=C2=A0lib/pdump/rte_pdump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 241 ++++++++++++++++++++++---<br>
=C2=A0lib/pdump/rte_pdump.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 40 +++-<br>
=C2=A09 files changed, 379 insertions(+), 44 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index c5bc728fae..c1313c7148 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -1332,6 +1332,7 @@ Przemyslaw Gierszynski &lt;<a href=3D"mailto:przemysl=
aw.gierszynski@intel.com" target=3D"_blank" rel=3D"noreferrer">przemyslaw.g=
ierszynski@intel.com</a>&gt;<br>
=C2=A0Przemyslaw Patynowski &lt;<a href=3D"mailto:przemyslawx.patynowski@in=
tel.com" target=3D"_blank" rel=3D"noreferrer">przemyslawx.patynowski@intel.=
com</a>&gt;<br>
=C2=A0Przemyslaw Zegan &lt;<a href=3D"mailto:przemyslawx.zegan@intel.com" t=
arget=3D"_blank" rel=3D"noreferrer">przemyslawx.zegan@intel.com</a>&gt;<br>
=C2=A0Pu Xu &lt;<a href=3D"mailto:583493798@qq.com" target=3D"_blank" rel=
=3D"noreferrer">583493798@qq.com</a>&gt;<br>
+Pushpendra Kumar &lt;<a href=3D"mailto:pushpendra1x.kumar@intel.com" targe=
t=3D"_blank" rel=3D"noreferrer">pushpendra1x.kumar@intel.com</a>&gt;<br>
=C2=A0Qi Fu &lt;<a href=3D"mailto:qi.fu@intel.com" target=3D"_blank" rel=3D=
"noreferrer">qi.fu@intel.com</a>&gt;<br>
=C2=A0Qi Zhang &lt;<a href=3D"mailto:qi.z.zhang@intel.com" target=3D"_blank=
" rel=3D"noreferrer">qi.z.zhang@intel.com</a>&gt;<br>
=C2=A0Qian Hao &lt;<a href=3D"mailto:qi_an_hao@126.com" target=3D"_blank" r=
el=3D"noreferrer">qi_an_hao@126.com</a>&gt;<br>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c<br>
index 46a6cb251e..f421a17034 100644<br>
--- a/app/dumpcap/main.c<br>
+++ b/app/dumpcap/main.c<br>
@@ -521,14 +521,33 @@ static void<br>
=C2=A0cleanup_pdump_resources(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct interface *intf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool disable_failed =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TAILQ_FOREACH(intf, &amp;interfaces, next) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_pdump_disable(i=
ntf-&gt;port,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_PDUMP_ALL_QUEUES, RTE_PDUM=
P_FLAG_RXTX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pdump_d=
isable(intf-&gt;port,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_PDUMP=
_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0disable_failed =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Disable pdump failed on %u:%s: =
%s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intf-&gt;port, intf-&gt;name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_strerror(rte_errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (intf-&gt;opts.p=
romisc_mode)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rte_eth_promiscuous_disable(intf-&gt;port);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (disable_failed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Fail-closed: if =
disable did not complete, keep pdump action/state<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * alive and do not=
 uninit shared capture resources.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Skipping pdump uninit because disable did not complete on a=
ll interfaces\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_pdump_uninit();<br>
=C2=A0}<br>
<br>
diff --git a/app/pdump/main.c b/app/pdump/main.c<br>
index 1e62c8adc1..4cfb038395 100644<br>
--- a/app/pdump/main.c<br>
+++ b/app/pdump/main.c<br>
@@ -451,14 +451,17 @@ print_pdump_stats(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-static inline void<br>
+static inline int<br>
=C2=A0disable_pdump(struct pdump_tuples *pt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pt-&gt;dump_by_type =3D=3D DEVICE_ID)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_pdump_disable_b=
y_deviceid(pt-&gt;device_id, pt-&gt;queue,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0pt-&gt;dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_pdump_di=
sable_by_deviceid(pt-&gt;device_id, pt-&gt;queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pt-&gt;dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (pt-&gt;dump_by_type =3D=3D PORT_ID)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_pdump_disable(p=
t-&gt;port, pt-&gt;queue, pt-&gt;dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_pdump_di=
sable(pt-&gt;port, pt-&gt;queue, pt-&gt;dir);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_errno =3D EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0}<br>
<br>
=C2=A0static inline void<br>
@@ -518,15 +521,30 @@ static void<br>
=C2=A0cleanup_pdump_resources(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool disable_failed =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pdump_tuples *pt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char name[RTE_ETH_NAME_MAX_LEN];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* disable pdump and free the pdump_tuple resou=
rces */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable all callbacks first; freeing shared =
objects before this is unsafe. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; num_tuples; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pt =3D &amp;pdump_t=
[i];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* remove callbacks=
 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_pdump(pt);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D disable_pdu=
mp(pt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0disable_failed =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;pdump disable failed (tuple=3D%d, errno=3D%d: %s); &=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;skip teardown to avoid stale callback=
 access\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, rte_errno, rte_strerror(rte_errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (disable_failed)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* free the pdump_tuple resources */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_tuples; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pt =3D &amp;pdump_t=
[i];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * transmit rest of =
the enqueued packets of the rings on to<br>
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/=
release_26_07.rst<br>
index 4ca0a9ac77..1700a56bc7 100644<br>
--- a/doc/guides/rel_notes/release_26_07.rst<br>
+++ b/doc/guides/rel_notes/release_26_07.rst<br>
@@ -177,6 +177,13 @@ New Features<br>
=C2=A0 =C2=A0Added AGENTS.md file for AI review<br>
=C2=A0 =C2=A0and supporting scripts to review patches and documentation.<br=
>
<br>
+* **Hardened pdump teardown on disable failure.**<br>
+<br>
+=C2=A0 Hardened pdump request completion and application cleanup behavior =
so timeout<br>
+=C2=A0 or disable failure does not trigger premature pdump resource teardo=
wn.<br>
+=C2=A0 pdump now uses an opt-in MP request mode that ignores peers without=
 the<br>
+=C2=A0 pdump action, while preserving legacy EAL MP behavior for all other=
 users.<br>
+<br>
<br>
=C2=A0Removed Items<br>
=C2=A0-------------<br>
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_p=
roc.c<br>
index 06f151818c..5a458c0417 100644<br>
--- a/lib/eal/common/eal_common_proc.c<br>
+++ b/lib/eal/common/eal_common_proc.c<br>
@@ -56,6 +56,7 @@ static struct action_entry_list action_entry_list =3D<br>
=C2=A0enum mp_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MP_MSG, /* Share message with peers, will not b=
lock */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MP_REQ, /* Request for information, Will block =
for a reply */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0MP_REQ_IGN, /* Request where missing action sho=
uld return ignore */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MP_REP, /* Response to previously-received requ=
est */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MP_IGN, /* Response telling requester to ignore=
 this response */<br>
=C2=A0};<br>
@@ -384,11 +385,11 @@ process_msg(struct mp_msg_internal *m, struct sockadd=
r_un *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;mp_mutex_action);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!action) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (m-&gt;type =3D=
=3D MP_REQ &amp;&amp; !internal_conf-&gt;init_complete) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* if this is a request, and init is not yet complete,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * and callback wasn&#39;t registered, we should tell the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * requester to ignore our existence because we&#39;re not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * yet ready to process this request.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((m-&gt;type =3D=
=3D MP_REQ &amp;&amp; !internal_conf-&gt;init_complete) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m-&gt=
;type =3D=3D MP_REQ_IGN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * Ask requester to ignore this peer when action is not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * registered either due to early init or explicit request policy=
.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct rte_mp_msg dummy;<br>
<br>
@@ -936,7 +937,8 @@ mp_request_async(const char *dst, struct rte_mp_msg *re=
q,<br>
<br>
=C2=A0static int<br>
=C2=A0mp_request_sync(const char *dst, struct rte_mp_msg *req,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mp_reply *repl=
y, const struct timespec *ts)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mp_reply *repl=
y, const struct timespec *ts,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum mp_type req_type)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_condattr_t attr;<br>
@@ -959,7 +961,7 @@ mp_request_sync(const char *dst, struct rte_mp_msg *req=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D send_msg(dst, req, MP_REQ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D send_msg(dst, req, req_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EAL_LOG(ERR, &quot;=
Fail to send request %s:%s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dst, req-&gt;name);<br>
@@ -1010,11 +1012,20 @@ RTE_EXPORT_SYMBOL(rte_mp_request_sync)<br>
=C2=A0int<br>
=C2=A0rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *repl=
y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct timesp=
ec *ts)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_mp_request_sync_ex(req, reply, ts, 0=
);<br>
+}<br>
+<br>
+RTE_EXPORT_SYMBOL(rte_mp_request_sync_ex)<br>
+int<br>
+rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct timesp=
ec *ts, uint32_t flags)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int dir_fd, ret =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIR *mp_dir;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dirent *ent;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec now, end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enum mp_type req_type =3D MP_REQ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct internal_config *internal_conf =3D=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_get_internal_co=
nfiguration();<br>
<br>
@@ -1027,6 +1038,14 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct r=
te_mp_reply *reply,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (check_input(req) !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; ~RTE_MP_REQ_F_IGNORE_NO_ACTION)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_errno =3D EINVA=
L;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; RTE_MP_REQ_F_IGNORE_NO_ACTION)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req_type =3D MP_REQ=
_IGN;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (internal_conf-&gt;no_shconf) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EAL_LOG(DEBUG, &quo=
t;No shared files mode enabled, IPC is disabled&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_errno =3D ENOTS=
UP;<br>
@@ -1046,7 +1065,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rt=
e_mp_reply *reply,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for secondary process, send request to the p=
rimary process only */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rte_eal_process_type() =3D=3D RTE_PROC_SECO=
NDARY) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(=
&amp;pending_requests.lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mp_request_=
sync(eal_mp_socket_path(), req, reply, &amp;end);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mp_request_=
sync(eal_mp_socket_path(), req, reply, &amp;end, req_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unloc=
k(&amp;pending_requests.lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -1086,7 +1105,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rt=
e_mp_reply *reply,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* unlocks the mute=
x while waiting for response,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* locks on re=
ceive<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp_request_sync=
(path, req, reply, &amp;end))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp_request_sync=
(path, req, reply, &amp;end, req_type))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto unlock_end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h<br>
index 7241f3be5d..415b974945 100644<br>
--- a/lib/eal/include/rte_eal.h<br>
+++ b/lib/eal/include/rte_eal.h<br>
@@ -173,6 +173,15 @@ struct rte_mp_reply {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mp_msg *msgs; /* caller to free */<b=
r>
=C2=A0};<br>
<br>
+/** Request flags for rte_mp_request_sync_ex(). */<br>
+enum rte_mp_request_flags {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Ask peers that do not have a registered acti=
on to return MP_IGN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * instead of causing timeout for this request.=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_MP_REQ_F_IGNORE_NO_ACTION =3D 1u &lt;&lt; 0=
,<br>
+};<br>
+<br>
=C2=A0/**<br>
=C2=A0 * Action function typedef used by other components.<br>
=C2=A0 *<br>
@@ -292,6 +301,30 @@ int<br>
=C2=A0rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *repl=
y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct timespe=
c *ts);<br>
<br>
+/**<br>
+ * Send a request to peer processes with explicit request flags.<br>
+ *<br>
+ * This API is equivalent to rte_mp_request_sync() with opt-in behavior<br=
>
+ * controls provided through @p flags.<br>
+ *<br>
+ * @param req<br>
+ *=C2=A0 =C2=A0The req argument contains the customized request message.<b=
r>
+ * @param reply<br>
+ *=C2=A0 =C2=A0The reply argument will be for storing all the replied mess=
ages;<br>
+ *=C2=A0 =C2=A0the caller is responsible for free reply-&gt;msgs.<br>
+ * @param ts<br>
+ *=C2=A0 =C2=A0The ts argument specifies how long we can wait for the peer=
(s) to reply.<br>
+ * @param flags<br>
+ *=C2=A0 =C2=A0Bitmask of values from enum rte_mp_request_flags.<br>
+ *<br>
+ * @return<br>
+ *=C2=A0 - On success, return 0.<br>
+ *=C2=A0 - On failure, return -1, and the reason will be stored in rte_err=
no.<br>
+ */<br>
+int<br>
+rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct timesp=
ec *ts, uint32_t flags);<br>
+<br>
=C2=A0/**<br>
=C2=A0 * Send a request to the peer process and expect a reply in a separat=
e callback.<br>
=C2=A0 *<br>
diff --git a/lib/eal/windows/eal_mp.c b/lib/eal/windows/eal_mp.c<br>
index 6703355318..1066a4d2bc 100644<br>
--- a/lib/eal/windows/eal_mp.c<br>
+++ b/lib/eal/windows/eal_mp.c<br>
@@ -56,10 +56,19 @@ RTE_EXPORT_SYMBOL(rte_mp_request_sync)<br>
=C2=A0int<br>
=C2=A0rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *repl=
y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct timespec *ts)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_mp_request_sync_ex(req, reply, ts, 0=
);<br>
+}<br>
+<br>
+RTE_EXPORT_SYMBOL(rte_mp_request_sync_ex)<br>
+int<br>
+rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct timespec *ts, uint32_t flags)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_SET_USED(req);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_SET_USED(reply);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_SET_USED(ts);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_SET_USED(flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EAL_LOG_NOT_IMPLEMENTED();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0}<br>
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c<br>
index ac94efe7ff..3764aeb2d3 100644<br>
--- a/lib/pdump/rte_pdump.c<br>
+++ b/lib/pdump/rte_pdump.c<br>
@@ -3,9 +3,12 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
+#include &lt;errno.h&gt;<br>
<br>
=C2=A0#include &lt;eal_export.h&gt;<br>
+#include &lt;rte_eal.h&gt;<br>
=C2=A0#include &lt;rte_alarm.h&gt;<br>
+#include &lt;rte_cycles.h&gt;<br>
=C2=A0#include &lt;rte_mbuf.h&gt;<br>
=C2=A0#include &lt;rte_ethdev.h&gt;<br>
=C2=A0#include &lt;rte_lcore.h&gt;<br>
@@ -68,6 +71,7 @@ struct pdump_request {<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct rte_bpf_prm *prm;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t snaplen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t generation;<br>
=C2=A0};<br>
<br>
=C2=A0struct pdump_response {<br>
@@ -81,6 +85,11 @@ struct pdump_bundle {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char peer[];<br>
=C2=A0};<br>
<br>
+struct pdump_shared_ctl {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(uint32_t) enabled;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(uint32_t) inflight;<br>
+};<br>
+<br>
=C2=A0static struct pdump_rxtx_cbs {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_ring *ring;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mempool *mp;<br>
@@ -88,11 +97,11 @@ static struct pdump_rxtx_cbs {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct rte_bpf *filter;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum pdump_version ver;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t snaplen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t generation;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ATOMIC(uint32_t) use_count;<br>
=C2=A0} rx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT],<br>
=C2=A0tx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];<br>
<br>
-<br>
=C2=A0/*<br>
=C2=A0 * The packet capture statistics keep track of packets<br>
=C2=A0 * accepted, filtered and dropped. These are per-queue<br>
@@ -102,9 +111,59 @@ static const char MZ_RTE_PDUMP_STATS[] =3D &quot;rte_p=
dump_stats&quot;;<br>
=C2=A0static struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_pdump_stats rx[RTE_MAX_ETHPORTS][RTE=
_MAX_QUEUES_PER_PORT];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_pdump_stats tx[RTE_MAX_ETHPORTS][RTE=
_MAX_QUEUES_PER_PORT];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pdump_shared_ctl rx_ctl[RTE_MAX_ETHPORTS=
][RTE_MAX_QUEUES_PER_PORT];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pdump_shared_ctl tx_ctl[RTE_MAX_ETHPORTS=
][RTE_MAX_QUEUES_PER_PORT];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(uint32_t) generation;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct rte_memzone *mz;<br>
=C2=A0} *pdump_stats;<br>
<br>
+static int<br>
+pdump_enter(struct pdump_shared_ctl *ctl, const struct pdump_rxtx_cbs *cbs=
)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t generation =3D rte_atomic_load_explici=
t(&amp;pdump_stats-&gt;generation,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_memory_order_relaxed);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_atomic_load_explicit(&amp;ctl-&gt;enabl=
ed, rte_memory_order_relaxed) =3D=3D 0 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cbs-&gt;generation !=3D generatio=
n)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_fetch_add_explicit(&amp;ctl-&gt;infl=
ight, 1, rte_memory_order_acquire);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Disable/re-enable may race with callback ent=
ry. Re-check enabled and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * generation after taking inflight reference s=
o disable can wait for this<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * callback to drain and stale callbacks become=
 no-op.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0generation =3D rte_atomic_load_explicit(&amp;pd=
ump_stats-&gt;generation,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_memory_order_relaxed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_atomic_load_explicit(&amp;ctl-&gt;enabl=
ed, rte_memory_order_relaxed) !=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cbs-&gt;generation =3D=3D generat=
ion)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_fetch_sub_explicit(&amp;ctl-&gt;infl=
ight, 1, rte_memory_order_release);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static __rte_always_inline void<br>
+pdump_exit(struct pdump_shared_ctl *ctl)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_fetch_sub_explicit(&amp;ctl-&gt;infl=
ight, 1, rte_memory_order_release);<br>
+}<br>
+<br>
+static int<br>
+pdump_wait_inflight(struct pdump_shared_ctl *ctl)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t end_tsc =3D rte_get_timer_cycles() + M=
P_TIMEOUT_S * rte_get_timer_hz();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (rte_atomic_load_explicit(&amp;ctl-&gt;in=
flight, rte_memory_order_acquire) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_get_timer_c=
ycles() &gt; end_tsc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ETIMEDOUT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_pause();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
=C2=A0static void<br>
=C2=A0pdump_cb_wait(struct pdump_rxtx_cbs *cbs)<br>
=C2=A0{<br>
@@ -224,12 +283,17 @@ pdump_rx(uint16_t port, uint16_t queue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t max_pkts __rte_unused, void *user_para=
ms)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pdump_rxtx_cbs *cbs =3D user_params;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pdump_shared_ctl *ctl =3D &amp;pdump_sta=
ts-&gt;rx_ctl[port][queue];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_pdump_stats *stats =3D &amp;pdump_st=
ats-&gt;rx[port][queue];<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pdump_enter(ctl, cbs))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nb_pkts;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_cb_hold(cbs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_IN=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkts, =
nb_pkts, cbs, stats);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_cb_release(cbs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pdump_exit(ctl);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return nb_pkts;<br>
=C2=A0}<br>
@@ -239,12 +303,17 @@ pdump_tx(uint16_t port, uint16_t queue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mbuf **p=
kts, uint16_t nb_pkts, void *user_params)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pdump_rxtx_cbs *cbs =3D user_params;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pdump_shared_ctl *ctl =3D &amp;pdump_sta=
ts-&gt;tx_ctl[port][queue];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_pdump_stats *stats =3D &amp;pdump_st=
ats-&gt;tx[port][queue];<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pdump_enter(ctl, cbs))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nb_pkts;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_cb_hold(cbs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_OU=
T,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkts, =
nb_pkts, cbs, stats);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_cb_release(cbs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pdump_exit(ctl);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return nb_pkts;<br>
=C2=A0}<br>
@@ -255,20 +324,43 @@ pdump_register_rx_callbacks(enum pdump_version ver,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t end_q, uint16_t port, uint16_t queue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_ring *ring, struct rte_mempool *mp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_bpf *filter,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint16_t operation, uint32_t snaplen)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint16_t operation, uint32_t snaplen,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t generation)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t qid;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qid =3D (queue =3D=3D RTE_PDUMP_ALL_QUEUES) ? 0=
 : queue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (; qid &lt; end_q; qid++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pdump_rxtx_c=
bs *cbs =3D &amp;rx_cbs[port][qid];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pdump_shared=
_ctl *ctl =3D &amp;pdump_stats-&gt;rx_ctl[port][qid];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (operation =3D=
=3D ENABLE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int ret;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (cbs-&gt;cb) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG_LINE(ERR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rx =
callback for port=3D%d queue=3D%d, already exists&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port, qid=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EEXIST;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cbs-&gt;generation =3D=3D generat=
ion &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_load_explici=
t(&amp;ctl-&gt;enabled,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0rte_memory_order_relaxed) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG=
_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;rx callback for port=3D%d queue=3D%d, already exi=
sts&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0port, qid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
EXIST;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG_LINE(DEBUG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rec=
onciling stale rx callback for port=3D%d queue=3D%d&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; ol=
d_gen=3D%u new_gen=3D%u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port, qid=
, cbs-&gt;generation, generation);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_remove_rx_callback(po=
rt, qid, cbs-&gt;cb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG=
_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;failed to reconcile stale rx callback, errno=3D%d=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0-ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return re=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdump_cb_wait(cbs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cbs-&gt;cb =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;use_count =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;ver =3D ver;<br>
@@ -276,6 +368,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;mp =3D mp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;snaplen =3D snaplen;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;filter =3D filter;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cbs-&gt;generation =3D generation;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;cb =3D rte_eth_add_first_rx_callback(port, qid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pdump_rx, cbs);<br>
@@ -286,10 +379,15 @@ pdump_register_rx_callbacks(enum pdump_version ver,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rte_errno;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&gt;inflight, 0, rte_memory_or=
der_relaxed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&gt;enabled, 1, rte_memory_ord=
er_release);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 memset(&amp;pdump_stats-&gt;rx[port][qid], 0, sizeof(struct rte_=
pdump_stats));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (operatio=
n =3D=3D DISABLE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int ret;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&gt;enabled, 0, rte_memory_ord=
er_release);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (cbs-&gt;cb =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(ERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;no=
 existing rx callback for port=3D%d queue=3D%d&quot;,<br>
@@ -298,6 +396,11 @@ pdump_register_rx_callbacks(enum pdump_version ver,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D rte_eth_remove_rx_callback(port, qid, cbs-&gt;cb);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Keep state coherent: callback is s=
till registered,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * so restore enabled.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&g=
t;enabled, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rte_memory_order_release);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(ERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;fa=
iled to remove rx callback, errno=3D%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -ret);<b=
r>
@@ -305,6 +408,10 @@ pdump_register_rx_callbacks(enum pdump_version ver,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pdump_cb_wait(cbs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;cb =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D pdump_wait_inflight(ctl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -316,7 +423,8 @@ pdump_register_tx_callbacks(enum pdump_version ver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t end_q, uint16_t port, uint16_t queue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_ring *ring, struct rte_mempool *mp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_bpf *filter,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint16_t operation, uint32_t snaplen)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint16_t operation, uint32_t snaplen,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t generation)<br>
=C2=A0{<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t qid;<br>
@@ -324,13 +432,36 @@ pdump_register_tx_callbacks(enum pdump_version ver,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qid =3D (queue =3D=3D RTE_PDUMP_ALL_QUEUES) ? 0=
 : queue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (; qid &lt; end_q; qid++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pdump_rxtx_c=
bs *cbs =3D &amp;tx_cbs[port][qid];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pdump_shared=
_ctl *ctl =3D &amp;pdump_stats-&gt;tx_ctl[port][qid];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (operation =3D=
=3D ENABLE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int ret;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (cbs-&gt;cb) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG_LINE(ERR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tx =
callback for port=3D%d queue=3D%d, already exists&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port, qid=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EEXIST;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cbs-&gt;generation =3D=3D generat=
ion &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_load_explici=
t(&amp;ctl-&gt;enabled,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0rte_memory_order_relaxed) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG=
_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;tx callback for port=3D%d queue=3D%d, already exi=
sts&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0port, qid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
EXIST;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG_LINE(DEBUG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rec=
onciling stale tx callback for port=3D%d queue=3D%d&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; ol=
d_gen=3D%u new_gen=3D%u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port, qid=
, cbs-&gt;generation, generation);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_remove_tx_callback(po=
rt, qid, cbs-&gt;cb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG=
_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;failed to reconcile stale tx callback, errno=3D%d=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0-ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return re=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdump_cb_wait(cbs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cbs-&gt;cb =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;use_count =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;ver =3D ver;<br>
@@ -338,6 +469,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;mp =3D mp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;snaplen =3D snaplen;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;filter =3D filter;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cbs-&gt;generation =3D generation;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;cb =3D rte_eth_add_tx_callback(port, qid, pdump_tx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cbs);<br>
@@ -347,10 +479,15 @@ pdump_register_tx_callbacks(enum pdump_version ver,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_errn=
o);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rte_errno;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&gt;inflight, 0, rte_memory_or=
der_relaxed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&gt;enabled, 1, rte_memory_ord=
er_release);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 memset(&amp;pdump_stats-&gt;tx[port][qid], 0, sizeof(struct rte_=
pdump_stats));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (operatio=
n =3D=3D DISABLE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int ret;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&gt;enabled, 0, rte_memory_ord=
er_release);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (cbs-&gt;cb =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(ERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;no=
 existing tx callback for port=3D%d queue=3D%d&quot;,<br>
@@ -359,6 +496,11 @@ pdump_register_tx_callbacks(enum pdump_version ver,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D rte_eth_remove_tx_callback(port, qid, cbs-&gt;cb);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Keep state coherent: callback is s=
till registered,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * so restore enabled.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_store_explicit(&amp;ctl-&g=
t;enabled, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rte_memory_order_release);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(ERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;fa=
iled to remove tx callback, errno=3D%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -ret);<b=
r>
@@ -367,6 +509,10 @@ pdump_register_tx_callbacks(enum pdump_version ver,<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pdump_cb_wait(cbs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cbs-&gt;cb =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D pdump_wait_inflight(ctl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -459,7 +605,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_q =3D (queue =
=3D=3D RTE_PDUMP_ALL_QUEUES) ? nb_rx_q : queue + 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pdump_regis=
ter_rx_callbacks(p-&gt;ver, end_q, port, queue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring, mp, filter,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0operation, p-&gt;snaplen);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0operation, p-&gt;snaplen,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;generation);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -469,7 +616,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_q =3D (queue =
=3D=3D RTE_PDUMP_ALL_QUEUES) ? nb_tx_q : queue + 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pdump_regis=
ter_tx_callbacks(p-&gt;ver, end_q, port, queue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring, mp, filter,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0operation, p-&gt;snaplen);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0operation, p-&gt;snaplen,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;generation);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -477,12 +625,14 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
-static void<br>
-pdump_request_to_secondary(const struct pdump_request *req)<br>
+static int<br>
+pdump_request_to_secondary_sync(const struct pdump_request *req)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mp_msg mp_req =3D { };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mp_reply mp_reply;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec ts =3D {.tv_sec =3D MP_TIMEOUT_=
S, .tv_nsec =3D 0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(DEBUG, &quot;forward req %s to s=
econdary&quot;, pdump_opname(req-&gt;op));<br>
<br>
@@ -490,14 +640,41 @@ pdump_request_to_secondary(const struct pdump_request=
 *req)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 strlcpy(<a href=3D"http://mp_req.name" target=
=3D"_blank" rel=3D"noreferrer">mp_req.name</a>, PDUMP_MP, sizeof(<a href=3D=
"http://mp_req.name" target=3D"_blank" rel=3D"noreferrer">mp_req.name</a>))=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mp_req.len_param =3D sizeof(*req);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_mp_request_sync(&amp;mp_req, &amp;mp_re=
ply, &amp;ts) !=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG_LINE(ERR,=
 &quot;rte_mp_request_sync failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_mp_request_sync_ex(&amp;mp_req, &amp;mp=
_reply, &amp;ts,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_MP_REQ_F_IGNORE_NO_=
ACTION) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PDUMP_LOG_LINE(ERR,=
 &quot;rte_mp_request_sync failed: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(rte_errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -rte_errno;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (mp_reply.nb_sent !=3D mp_reply.nb_rece=
ived)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp_reply.nb_sent !=3D mp_reply.nb_received)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(ERR,=
 &quot;not all secondary&#39;s replied (sent %u recv %u)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mp_reply.nb_sent, mp_reply.nb_receive=
d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ETIMEDOUT;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; mp_reply.nb_received; i++)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mp_msg *=
mp_rep =3D &amp;mp_reply.msgs[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct pdump_=
response *resp;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp_rep-&gt;len_=
param !=3D sizeof(*resp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PDUMP_LOG_LINE(ERR, &quot;invalid secondary reply size %u&quot;, =
mp_rep-&gt;len_param);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resp =3D (const str=
uct pdump_response *)mp_rep-&gt;param;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (resp-&gt;err_va=
lue !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PDUMP_LOG_LINE(ERR, &quot;secondary reply failed: op=3D%u err=3D%=
d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resp-&gt;res_op=
, resp-&gt;err_value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D resp-&gt;err_value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(mp_reply.msgs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0/* Allocate temporary storage for passing state to the alarm thread f=
or deferred handling */<br>
@@ -556,7 +733,10 @@ pdump_handle_primary_request(const struct rte_mp_msg *=
mp_msg, const void *peer)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(DEBU=
G, &quot;secondary pdump %s&quot;, pdump_opname(req-&gt;op));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Can just do it n=
ow, no need for interrupt thread */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D set_pdump_r=
xtx_cbs(req);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (req-&gt;op =3D=
=3D ENABLE || req-&gt;op =3D=3D DISABLE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D set_pdump_rxtx_cbs(req);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pdump_send_response(req, ret, peer);<br>
@@ -569,17 +749,29 @@ __pdump_request(void *param)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pdump_bundle *bundle =3D param;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mp_msg *msg =3D &amp;bundle-&gt;msg;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct pdump_request *req =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(const struct pdump=
_request *)msg-&gt;param;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pdump_request *req =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(struct pdump_reque=
st *)msg-&gt;param;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PDUMP_LOG_LINE(DEBUG, &quot;primary pdump %s&qu=
ot;, pdump_opname(req-&gt;op));<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (req-&gt;op =3D=3D DISABLE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;generation =
=3D rte_atomic_fetch_add_explicit(&amp;pdump_stats-&gt;generation, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_memory_order_ac=
q_rel) + 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (req-&gt;op =3D=3D ENABLE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;generation =
=3D rte_atomic_load_explicit(&amp;pdump_stats-&gt;generation,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_memory_order_ac=
quire);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D set_pdump_rxtx_cbs(req);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Primary process is responsible for broadcast=
ing request to all secondaries */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Primary process is responsible for broadcast=
ing the request to all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * secondaries. The sync request uses opt-in ig=
nore-missing-action mode so<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * pdump does not depend on unrelated secondary=
 processes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdump_request_to_se=
condary(req);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pdump_reque=
st_to_secondary_sync(req);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_send_response(req, ret, bundle-&gt;peer);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(bundle);<br>
@@ -659,6 +851,9 @@ rte_pdump_init(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_stats =3D mz-&gt;addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump_stats-&gt;mz =3D mz;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_PRIM=
ARY)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_store_ex=
plicit(&amp;pdump_stats-&gt;generation, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rt=
e_memory_order_release);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
diff --git a/lib/pdump/rte_pdump.h b/lib/pdump/rte_pdump.h<br>
index 1e32d46097..77e5914420 100644<br>
--- a/lib/pdump/rte_pdump.h<br>
+++ b/lib/pdump/rte_pdump.h<br>
@@ -64,7 +64,7 @@ rte_pdump_uninit(void);<br>
=C2=A0 *=C2=A0 queues of a given port.<br>
=C2=A0 * @param flags<br>
=C2=A0 *=C2=A0 flags specifies RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUM=
P_FLAG_RXTX<br>
- *=C2=A0 on which packet capturing should be enabled for a given port and =
queue.<br>
+ *=C2=A0 on which packet capturing should be disabled for a given port and=
 queue.<br>
=C2=A0 * @param ring<br>
=C2=A0 *=C2=A0 ring on which captured packets will be enqueued for user.<br=
>
=C2=A0 * @param mp<br>
@@ -72,6 +72,11 @@ rte_pdump_uninit(void);<br>
=C2=A0 * @param filter<br>
=C2=A0 *=C2=A0 Unused should be NULL.<br>
=C2=A0 *<br>
+ * @note<br>
+ *=C2=A0 In applications that enable capture on multiple interfaces, enabl=
e may be<br>
+ *=C2=A0 partially applied before an error is returned. Callers should exp=
licitly<br>
+ *=C2=A0 unwind partial enable state.<br>
+ *<br>
=C2=A0 * @return<br>
=C2=A0 *=C2=A0 =C2=A0 0 on success, -1 on error, rte_errno is set according=
ly.<br>
=C2=A0 */<br>
@@ -103,6 +108,11 @@ rte_pdump_enable(uint16_t port, uint16_t queue, uint32=
_t flags,<br>
=C2=A0 * @param prm<br>
=C2=A0 *=C2=A0 Use BPF program to run to filter packes (can be NULL)<br>
=C2=A0 *<br>
+ * @note<br>
+ *=C2=A0 In applications that enable capture on multiple interfaces, enabl=
e may be<br>
+ *=C2=A0 partially applied before an error is returned. Callers should exp=
licitly<br>
+ *=C2=A0 unwind partial enable state.<br>
+ *<br>
=C2=A0 * @return<br>
=C2=A0 *=C2=A0 =C2=A0 0 on success, -1 on error, rte_errno is set according=
ly.<br>
=C2=A0 */<br>
@@ -124,7 +134,14 @@ rte_pdump_enable_bpf(uint16_t port_id, uint16_t queue,=
<br>
=C2=A0 *=C2=A0 queues of a given port.<br>
=C2=A0 * @param flags<br>
=C2=A0 *=C2=A0 flags specifies RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUM=
P_FLAG_RXTX<br>
- *=C2=A0 on which packet capturing should be enabled for a given port and =
queue.<br>
+ *=C2=A0 on which packet capturing should be disabled for a given port and=
 queue.<br>
+ *<br>
+ * @note<br>
+ *=C2=A0 A disable failure (including timeout/no response) means teardown =
is not<br>
+ *=C2=A0 complete across pdump-enabled peers. The caller must not release =
shared<br>
+ *=C2=A0 pdump resources and must not uninitialize pdump for that capture =
session<br>
+ *=C2=A0 until disable succeeds. Releasing resources on disable failure ca=
n lead to<br>
+ *=C2=A0 crashes in peer processes still accessing those resources.<br>
=C2=A0 *<br>
=C2=A0 * @return<br>
=C2=A0 *=C2=A0 =C2=A0 0 on success, -1 on error, rte_errno is set according=
ly.<br>
@@ -153,6 +170,11 @@ rte_pdump_disable(uint16_t port, uint16_t queue, uint3=
2_t flags);<br>
=C2=A0 * @param filter<br>
=C2=A0 *=C2=A0 unused should be NULL<br>
=C2=A0 *<br>
+ * @note<br>
+ *=C2=A0 In applications that enable capture on multiple interfaces, enabl=
e may be<br>
+ *=C2=A0 partially applied before an error is returned. Callers should exp=
licitly<br>
+ *=C2=A0 unwind partial enable state.<br>
+ *<br>
=C2=A0 * @return<br>
=C2=A0 *=C2=A0 =C2=A0 0 on success, -1 on error, rte_errno is set according=
ly.<br>
=C2=A0 */<br>
@@ -186,6 +208,11 @@ rte_pdump_enable_by_deviceid(char *device_id, uint16_t=
 queue,<br>
=C2=A0 * @param filter<br>
=C2=A0 *=C2=A0 Use BPF program to run to filter packes (can be NULL)<br>
=C2=A0 *<br>
+ * @note<br>
+ *=C2=A0 In applications that enable capture on multiple interfaces, enabl=
e may be<br>
+ *=C2=A0 partially applied before an error is returned. Callers should exp=
licitly<br>
+ *=C2=A0 unwind partial enable state.<br>
+ *<br>
=C2=A0 * @return<br>
=C2=A0 *=C2=A0 =C2=A0 0 on success, -1 on error, rte_errno is set according=
ly.<br>
=C2=A0 */<br>
@@ -210,7 +237,14 @@ rte_pdump_enable_bpf_by_deviceid(const char *device_id=
, uint16_t queue,<br>
=C2=A0 *=C2=A0 queues of a given device id.<br>
=C2=A0 * @param flags<br>
=C2=A0 *=C2=A0 flags specifies RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUM=
P_FLAG_RXTX<br>
- *=C2=A0 on which packet capturing should be enabled for a given port and =
queue.<br>
+ *=C2=A0 on which packet capturing should be disabled for a given port and=
 queue.<br>
+ *<br>
+ * @note<br>
+ *=C2=A0 A disable failure (including timeout/no response) means teardown =
is not<br>
+ *=C2=A0 complete across pdump-enabled peers. The caller must not release =
shared<br>
+ *=C2=A0 pdump resources and must not uninitialize pdump for that capture =
session<br>
+ *=C2=A0 until disable succeeds. Releasing resources on disable failure ca=
n lead to<br>
+ *=C2=A0 crashes in peer processes still accessing those resources.<br>
=C2=A0 *<br>
=C2=A0 * @return<br>
=C2=A0 *=C2=A0 =C2=A0 0 on success, -1 on error, rte_errno is set according=
ly.<br>
-- <br>
2.43.0<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>

</blockquote></div>

--000000000000c89c890655ed0689--
