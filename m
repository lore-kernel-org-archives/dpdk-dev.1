Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B544C43458
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Jul 2026 18:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB1AE4027B;
	Sun,  5 Jul 2026 20:28:01 +0200 (CEST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) by mails.dpdk.org (Postfix) with ESMTP id 0F4654021E
 for <dev@dpdk.org>; Sun,  5 Jul 2026 20:27:59 +0200 (CEST)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-9697a691b5fso645952241.3
 for <dev@dpdk.org>; Sun, 05 Jul 2026 11:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783276079; cv=none;
 d=google.com; s=arc-20260327;
 b=F39c5B73wW0/JfQKwyRFFIfuHOVmzdhc5pCA5C5b4CzmhtIdv9VR2+9HAjMxYPAs6V
 X3mrSUImsaGugZToxMnPRNX1XpDDfCqqdRe4zQo9wWG0J4PYOzanfxaRxw9GHFy/Hci0
 yuAX7f1zJByfOKawmo0fTN9x6AFYzhSjM5Fbo2mbZ2Pk4+NKHvZCuCEKzIXWzobpi8mb
 OF0e1ZKh3/ALTdDVZ1T5/pSYT0G9hIqnIyVDsIC7CG+yqmoJSOkoSPHXxeM6TumpogSm
 vBhGViuE91WYk4rdM5O+p1VX8d9td42qeqdOw5MLs8W3qy9/nyqtnxvhdKZ1cip8ms7Q
 jRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MsV1gphSsTiYGd1lzypYV4zhpIx9LVgysg6e1etBTwU=;
 fh=nOGAPYIRAMYxor+MevOFRtvKsg5Pm+APu9JfpGNKnOc=;
 b=cDxlhCiBP74VVB64vUb1HTD/rpCQo0aV5XiEMhIZty33Kvir4/v0boAvrOwD4OTStN
 ozbJjNSrh0HlMv2PJR0knTPwxNxCQQC3gNxU9TAhG1hZdDpPcT+DGUcdqOpJkJY2+sPO
 Umlzud3nsGhhk5/q4nndFQDrLLoHm6r+olKS+V97A+1szcglEmUOJflUGPQ0ts5syzsd
 slt0M0HM4PjLtIYucY4ppyAGrtADYmQ54YQBzgrdsPCIxB6UcG6t6Wb0ZXt8jIPToEjB
 3X988G9Rc2Txj51sxlKQWdB51C4IA976JSuDdwNH6MzvfbbtDKL7habiBE1P4sEFqPpi
 ZRtw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783276079;
 x=1783880879; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MsV1gphSsTiYGd1lzypYV4zhpIx9LVgysg6e1etBTwU=;
 b=tJYdL33lwUZr3MYOlztLjtbd9lzJfD+eZQ0py8OX8Ayh3DLRHt1+M8eS4KGAN5AOQE
 jB+p2WqmTnbRp5T8YfbbbtTEZwr4q4dK+FzvAAwrlZoguC1oOQ0x0AA7PfbbfwidIihz
 3/SOsrKrUQo9TQjNjGn8j6gsLxBSJn4wS6Hm2yFQWFAMPAznWj7o+fjmv5/4mI+JY3DU
 v3Zs8iu3GkHuUL6yR88Wq9HiPPVm6OQ32aGCu06zWBHYsOFVPKl/2lvq2u7jdJHyB5Jn
 s2uPZ2pqxbtZSblleJYzrxWzi5+UxtMqdtOOv8gKHTG7q3KMMKi0nCKrmB4nf/iotcuo
 lDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783276079; x=1783880879;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MsV1gphSsTiYGd1lzypYV4zhpIx9LVgysg6e1etBTwU=;
 b=bq+612LZjrnz8tqZQ9hYvuSXikdbuJeiKzjcVTRRjNbFGZMNIKa2cK1a23CxM0/IbO
 LJNQPtklCqjTtoG5xxo4CWssh8W3r+Lpn146SOr6rpBZ8O9W7ErDtxfPouKmaoyYsZ5z
 6Zi12Loy1lrH1GAiAqv5XP842l9F3dIB0cYZWYeEAr76jHc78Za1ZZjsqrXdBRtymmVF
 pZHNBkOci/qtBY01QsYQBq3HnNe+OPqjMcV5YfjEBjWJzkPpEs22dK/l/xZXMH3VCEWk
 UMcMhLRpU8xEgMRgnyPHpn+ryY1ylNIhiE/jcl68XY6QtmunrSmfLL75+yiuGhk0ojBM
 vj5g==
X-Gm-Message-State: AOJu0YzN6s1fF5rqkVDJzMjNx/S6RsCFalwQaqGrUZHihsqZM47CTQ0x
 g/30Y+fRu7up6dJ5gUBulO4oWw1pciR82DKrKiu65OUhlMzjiddPDP0LaQFvjDa+ZDITYWoTY/v
 0ZBATk08XEdbw7Nk8Jc5UTnOt6qIuUYpZ0Wah5AnI1w==
X-Gm-Gg: AfdE7cnMZzqzyNjIOYl8AihRoEM+04QJwdbpAad7pR1MsMaz8UqEyobqFbwY+P1WXA0
 ccyqnXhrVPtCma2J5frRtfxlUdGuD0zamtGnkKtqdZpnaKxnWAWBLX8+7sCR96zwRb5Sb2esdAn
 iZnZoce+RQ188HNtEi4+HGMKbZqRUvKvTzoUGu5GfeO+8DV6GjH/vzeQSbvG6sxu/XSPTwrppns
 csSHVT49GOdlGNjbGbUZcOIvWmUxO9q0y3YhwdgOaNAkN+VdCz4PJKP7iqumx98ttXYfuW4uS/W
 pGJTY4aBnPQvzU+K3oYWsJKevF77dw==
X-Received: by 2002:a05:6102:1275:b0:737:1ca6:84d2 with SMTP id
 ada2fe7eead31-7427d991029mr1602407137.18.1783276078790; Sun, 05 Jul 2026
 11:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
 <20260705084415.1389340-1-pushpendra1x.kumar@intel.com>
In-Reply-To: <20260705084415.1389340-1-pushpendra1x.kumar@intel.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sun, 5 Jul 2026 11:27:48 -0700
X-Gm-Features: AVVi8Cdoc1_19GHFuLlg8HR4yzv_dJ6kRL8egdWokZhbqw1KRBhUA9WgHRr94ms
Message-ID: <CAOaVG15QiN6z8queMZmrFNN5xdii4r5G08R8smhLcnjSht7MRA@mail.gmail.com>
Subject: Re: [PATCH v2] pdump: fix teardown race with opt-in MP request mode
To: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
Cc: dev <dev@dpdk.org>, stable <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Reshma Pattan <reshma.pattan@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 14pwcse1224@uetpeshawar.edu.pk, pushpendra.kumar@tieto.com
Content-Type: multipart/alternative; boundary="0000000000003688f50655e151a4"
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

--0000000000003688f50655e151a4
Content-Type: text/plain; charset="UTF-8"

Root cause is not calling rte_pdump_init in secondary. This should be
detected or fixed automatically by EAL. Working around with async adds
unnecessary complexity

On Sun, Jul 5, 2026, 01:48 Pushpendra Kumar <pushpendra1x.kumar@intel.com>
wrote:

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

--0000000000003688f50655e151a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPlJvb3QgY2F1c2UgaXMgbm90IGNhbGxpbmcgcnRlX3BkdW1wX2luaXQg
aW4gc2Vjb25kYXJ5LiBUaGlzIHNob3VsZCBiZSBkZXRlY3RlZCBvciBmaXhlZCBhdXRvbWF0aWNh
bGx5IGJ5IEVBTC4gV29ya2luZyBhcm91bmQgd2l0aCBhc3luYyBhZGRzIHVubmVjZXNzYXJ5IGNv
bXBsZXhpdHnCoDwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9j
b250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBTdW4sIEp1bCA1
LCAyMDI2LCAwMTo0OCBQdXNocGVuZHJhIEt1bWFyICZsdDs8YSBocmVmPSJtYWlsdG86cHVzaHBl
bmRyYTF4Lmt1bWFyQGludGVsLmNvbSI+cHVzaHBlbmRyYTF4Lmt1bWFyQGludGVsLmNvbTwvYT4m
Z3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQs
MjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+VGhpcyBjaGFuZ2UgYWRkcmVzc2VzIHR3byBwZHVt
cCB0ZWFyZG93biBmYWlsdXJlIGNhc2VzOjxicj4NCjxicj4NCjEuIEEgcmVxdWVzdGVyIHNlY29u
ZGFyeSBjYW4gdGltZSBvdXQgaWYgYSBmb3J3YXJkZWQgc2Vjb25kYXJ5IGlzIHNsb3csPGJyPg0K
wqAgwqB1bnJlc3BvbnNpdmUsIG9yIGRvZXMgbm90IGltcGxlbWVudCBydGVfcGR1bXBfaW5pdCgp
Ljxicj4NCjIuIEFmdGVyIGEgRElTQUJMRSByZXF1ZXN0IHRpbWVzIG91dCwgdGhlIHJlcXVlc3Rl
ciBzZWNvbmRhcnkgcmVjZWl2ZXM8YnI+DQrCoCDCoHRoZSByZXBseSBhbmQgcmVsZWFzZXMgc2hh
cmVkIHJlc291cmNlcywgd2hpY2ggb3RoZXIgc2xvdyBvcjxicj4NCsKgIMKgdW5yZXNwb25zaXZl
IHNlY29uZGFyaWVzIG1heSBhY2Nlc3MsIGxlYWRpbmcgdG8gYSBjcmFzaC48YnI+DQo8YnI+DQpB
ZGQgYW4gb3B0LWluIEVBTCBtdWx0aXByb2Nlc3MgcmVxdWVzdCBtb2RlIHRoYXQgYWxsb3dzIGEg
Y2FsbGVyIHRvPGJyPg0KaWdub3JlIHBlZXJzIHRoYXQgZG8gbm90IGltcGxlbWVudCB0aGUgcmVx
dWVzdGVkIGFjdGlvbiwgd2hpbGUgcHJlc2VydmluZzxicj4NCnRoZSBleGlzdGluZyBydGVfbXBf
cmVxdWVzdF9zeW5jKCkgYmVoYXZpb3IgZm9yIGxlZ2FjeSB1c2Vycy48YnI+DQo8YnI+DQpwZHVt
cCB1c2VzIHRoaXMgbmV3IG1vZGUgd2hlbiBmb3J3YXJkaW5nIGVuYWJsZS9kaXNhYmxlIHJlcXVl
c3RzIGFuZCBhZGRzPGJyPg0KdGhlIGZvbGxvd2luZyBiZWhhdmlvcjo8YnI+DQotIHRyYWNrIHJl
cXVlc3QgZ2VuZXJhdGlvbiBzbyBzdGFsZSBjYWxsYmFja3MgY2Fubm90IGFjdCBvbiBhIG5ld2Vy
PGJyPg0KwqAgZW5hYmxlL2Rpc2FibGUgY3ljbGU8YnI+DQotIHdhaXQgZm9yIGluLWZsaWdodCBj
YWxsYmFja3MgdG8gZHJhaW4gYmVmb3JlIGNvbXBsZXRpbmcgZGlzYWJsZTxicj4NCi0gcHJldmVu
dCBzaGFyZWQgcmVzb3VyY2UgdGVhcmRvd24gZnJvbSByYWNpbmcgd2l0aCBkZWxheWVkIHNlY29u
ZGFyeTxicj4NCsKgIHByb2Nlc3Npbmc8YnI+DQotIGtlZXAgcGR1bXAgaW50ZW50LWRyaXZlbiB3
aXRob3V0IGV4dHJhIGNvbnN1bWVyLXNwZWNpZmljIHdvcmthcm91bmQ8YnI+DQrCoCBsb2dpYzxi
cj4NCjxicj4NClRoZSBFQUwgY2hhbmdlIGlzIHJlcXVpcmVkIGJlY2F1c2UgdGhlIGN1cnJlbnQg
bXAgcmVxdWVzdCBwYXRoIHRyZWF0czxicj4NCmEgbWlzc2luZyBhY3Rpb24gYXMgYSBmYWlsdXJl
LCB3aGljaCBjYW5ub3Qgc2F0aXNmeSBwZHVtcCYjMzk7cyBuZWVkcyB3aXRob3V0PGJyPg0KY2hh
bmdpbmcgYmVoYXZpb3IgZm9yIGFsbCBleGlzdGluZyB1c2Vycy4gVGhlIG5ldyBBUEkgaXMgb3B0
LWluLCBzbzxicj4NCmV4aXN0aW5nIGNhbGxlcnMgb2YgcnRlX21wX3JlcXVlc3Rfc3luYygpIGtl
ZXAgdGhlaXIgY3VycmVudCBzZW1hbnRpY3MuPGJyPg0KPGJyPg0KVmFsaWRhdGlvbjo8YnI+DQot
IEJhc2VsaW5lLXZzLWNoYW5nZXMgYmVuY2htYXJrIHVzZWQgRFBESy1uYXRpdmUgdGVzdC1wbWQg
YXMgcHJpbWFyeSBhbmQ8YnI+DQrCoCBkdW1wY2FwIGFzIHNlY29uZGFyeS48YnI+DQotIEJvdGgg
cnVucyBjYXB0dXJlZCAxMDI0IHBhY2tldHMgd2l0aCB0aGUgc2FtZSBwYWNrZXQtY291bnQgZXhp
dDxicj4NCsKgIGNvbmRpdGlvbi48YnI+DQotIEEgNS1zZWNvbmQgcGVyZiBzdGF0IHNhbXBsZSBv
biB0aGUgZm9yd2FyZGluZyBwcmltYXJ5IHNob3dlZCBubzxicj4NCsKgIG1lYW5pbmdmdWwgcmVn
cmVzc2lvbjogd2l0aCBjaGFuZ2VzIHJlY29yZGVkIDEyLDQwMiwwNTUsMzIwIGN5Y2xlcyBhbmQ8
YnI+DQrCoCAxNywzOTEsNzY5LDA4NCBpbnN0cnVjdGlvbnMsIHZlcnN1cyAxMiw0NTAsMDMxLDkw
MCBjeWNsZXMgYW5kPGJyPg0KwqAgMTcsNDk5LDcwNiwwNTMgaW5zdHJ1Y3Rpb25zIG9uIHRoZSBw
YXJlbnQgYmFzZWxpbmUuPGJyPg0KLSBUaGUgZXh0cmEgc3luY2hyb25pemF0aW9uIGluIHRoZSBo
b3QgcGF0aCBkaWQgbm90IHNob3cgbWF0ZXJpYWw8YnI+DQrCoCBvdmVyaGVhZCBpbiB0aGlzIHNh
bXBsZS48YnI+DQo8YnI+DQpGaXhlczogYzNjZWI4NzQyMjk1ICgmcXVvdDtwZHVtcDogZm9yd2Fy
ZCBjYWxsYmFjayBlbmFibGUgdG8gc2Vjb25kYXJ5IHByb2Nlc3MmcXVvdDspPGJyPg0KU2lnbmVk
LW9mZi1ieTogUHVzaHBlbmRyYSBLdW1hciAmbHQ7PGEgaHJlZj0ibWFpbHRvOnB1c2hwZW5kcmEx
eC5rdW1hckBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIiPnB1c2hw
ZW5kcmExeC5rdW1hckBpbnRlbC5jb208L2E+Jmd0Ozxicj4NCjxicj4NCkNjOiA8YSBocmVmPSJt
YWlsdG86c3RhYmxlQGRwZGsub3JnIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5z
dGFibGVAZHBkay5vcmc8L2E+PGJyPg0KLS0tPGJyPg0KVGhpcyBWMiBwYXRjaCBhZGRyZXNzZXMg
dHdvIHBkdW1wIHRlYXJkb3duIGZhaWx1cmUgc2NlbmFyaW9zOjxicj4NCjxicj4NCi0gQSByZXF1
ZXN0ZXIgc2Vjb25kYXJ5IGNhbiB0aW1lIG91dCBpZiBhIGZvcndhcmRlZCBzZWNvbmRhcnkgaXMg
c2xvdyw8YnI+DQrCoCB1bnJlc3BvbnNpdmUsIG9yIGRvZXMgbm90IGltcGxlbWVudCBydGVfcGR1
bXBfaW5pdCgpLjxicj4NCi0gQSBkZWxheWVkIERJU0FCTEUgcmVwbHkgY2FuIHJhY2Ugd2l0aCBy
ZXF1ZXN0ZXItc2lkZSB0ZWFyZG93biwgd2hpY2ggbWF5PGJyPg0KwqAgbGVhZCB0byBjcmFzaGVz
IGlmIHBlZXIgcHJvY2Vzc2VzIHN0aWxsIGFjY2VzcyBzaGFyZWQgcGR1bXAgcmVzb3VyY2VzLjxi
cj4NCjxicj4NClRvIGZpeCB0aGlzIGVuZC10by1lbmQ6PGJyPg0KLSBFQUwgYWRkcyBhbiBvcHQt
aW4gTVAgcmVxdWVzdCBtb2RlIHRvIGlnbm9yZSBwZWVycyB3aXRoIG5vIG1hdGNoaW5nIGFjdGlv
biw8YnI+DQrCoCB3aGlsZSBwcmVzZXJ2aW5nIGxlZ2FjeSBydGVfbXBfcmVxdWVzdF9zeW5jKCkg
YmVoYXZpb3IuPGJyPg0KLSBwZHVtcCB1c2VzIHRoYXQgbW9kZSwgdHJhY2tzIGdlbmVyYXRpb24s
IGFuZCB3YWl0cyBmb3IgaW4tZmxpZ2h0IGNhbGxiYWNrczxicj4NCsKgIHRvIGRyYWluIGJlZm9y
ZSBjb21wbGV0aW5nIGRpc2FibGUuPGJyPg0KLSBkdW1wY2FwIGFuZCBwZHVtcCBhcHAgY2xlYW51
cCBwYXRocyBhcmUgZmFpbC1jbG9zZWQgd2hlbiBkaXNhYmxlIGRvZXMgbm90PGJyPg0KwqAgY29t
cGxldGUgc3VjY2Vzc2Z1bGx5Ljxicj4NCjxicj4NCklmIHRoaXMgZGlyZWN0aW9uIGlzIGFjY2Vw
dGVkLCBJIGNhbiBzcGxpdCBmcm9tIHRoZSBuZXh0IHJldmlzaW9uIGludG8gYTxicj4NCmZvY3Vz
ZWQgRUFMIHBhdGNoIGZvbGxvd2VkIGJ5IHBkdW1wIGFuZCBhcHAtdXNlciB1cGRhdGVzLjxicj4N
Cjxicj4NCsKgLm1haWxtYXDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHzCoCDCoDEgKzxicj4NCsKgYXBwL2R1bXBjYXAvbWFpbi5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB8wqAgMjMgKystPGJyPg0KwqBhcHAvcGR1bXAvbWFpbi5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMzIgKysrLTxicj4NCsKgZG9jL2d1aWRl
cy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8wNy5yc3QgfMKgIMKgNyArPGJyPg0KwqBsaWIvZWFsL2Nv
bW1vbi9lYWxfY29tbW9uX3Byb2MuY8KgIMKgIMKgIMKgfMKgIDM3ICsrKy08YnI+DQrCoGxpYi9l
YWwvaW5jbHVkZS9ydGVfZWFsLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMzMgKysrKzxicj4N
CsKgbGliL2VhbC93aW5kb3dzL2VhbF9tcC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqA5
ICs8YnI+DQrCoGxpYi9wZHVtcC9ydGVfcGR1bXAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHwgMjQxICsrKysrKysrKysrKysrKysrKysrKystLS08YnI+DQrCoGxpYi9wZHVtcC9ydGVfcGR1
bXAuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA0MCArKystPGJyPg0KwqA5IGZpbGVz
IGNoYW5nZWQsIDM3OSBpbnNlcnRpb25zKCspLCA0NCBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpk
aWZmIC0tZ2l0IGEvLm1haWxtYXAgYi8ubWFpbG1hcDxicj4NCmluZGV4IGM1YmM3MjhmYWUuLmMx
MzEzYzcxNDggMTAwNjQ0PGJyPg0KLS0tIGEvLm1haWxtYXA8YnI+DQorKysgYi8ubWFpbG1hcDxi
cj4NCkBAIC0xMzMyLDYgKzEzMzIsNyBAQCBQcnplbXlzbGF3IEdpZXJzenluc2tpICZsdDs8YSBo
cmVmPSJtYWlsdG86cHJ6ZW15c2xhdy5naWVyc3p5bnNraUBpbnRlbC5jb20iIHRhcmdldD0iX2Js
YW5rIiByZWw9Im5vcmVmZXJyZXIiPnByemVteXNsYXcuZ2llcnN6eW5za2lAaW50ZWwuY29tPC9h
PiZndDs8YnI+DQrCoFByemVteXNsYXcgUGF0eW5vd3NraSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnBy
emVteXNsYXd4LnBhdHlub3dza2lAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3Jl
ZmVycmVyIj5wcnplbXlzbGF3eC5wYXR5bm93c2tpQGludGVsLmNvbTwvYT4mZ3Q7PGJyPg0KwqBQ
cnplbXlzbGF3IFplZ2FuICZsdDs8YSBocmVmPSJtYWlsdG86cHJ6ZW15c2xhd3guemVnYW5AaW50
ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5wcnplbXlzbGF3eC56ZWdh
bkBpbnRlbC5jb208L2E+Jmd0Ozxicj4NCsKgUHUgWHUgJmx0OzxhIGhyZWY9Im1haWx0bzo1ODM0
OTM3OThAcXEuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj41ODM0OTM3OThA
cXEuY29tPC9hPiZndDs8YnI+DQorUHVzaHBlbmRyYSBLdW1hciAmbHQ7PGEgaHJlZj0ibWFpbHRv
OnB1c2hwZW5kcmExeC5rdW1hckBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVm
ZXJyZXIiPnB1c2hwZW5kcmExeC5rdW1hckBpbnRlbC5jb208L2E+Jmd0Ozxicj4NCsKgUWkgRnUg
Jmx0OzxhIGhyZWY9Im1haWx0bzpxaS5mdUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIiByZWw9
Im5vcmVmZXJyZXIiPnFpLmZ1QGludGVsLmNvbTwvYT4mZ3Q7PGJyPg0KwqBRaSBaaGFuZyAmbHQ7
PGEgaHJlZj0ibWFpbHRvOnFpLnouemhhbmdAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVs
PSJub3JlZmVycmVyIj5xaS56LnpoYW5nQGludGVsLmNvbTwvYT4mZ3Q7PGJyPg0KwqBRaWFuIEhh
byAmbHQ7PGEgaHJlZj0ibWFpbHRvOnFpX2FuX2hhb0AxMjYuY29tIiB0YXJnZXQ9Il9ibGFuayIg
cmVsPSJub3JlZmVycmVyIj5xaV9hbl9oYW9AMTI2LmNvbTwvYT4mZ3Q7PGJyPg0KZGlmZiAtLWdp
dCBhL2FwcC9kdW1wY2FwL21haW4uYyBiL2FwcC9kdW1wY2FwL21haW4uYzxicj4NCmluZGV4IDQ2
YTZjYjI1MWUuLmY0MjFhMTcwMzQgMTAwNjQ0PGJyPg0KLS0tIGEvYXBwL2R1bXBjYXAvbWFpbi5j
PGJyPg0KKysrIGIvYXBwL2R1bXBjYXAvbWFpbi5jPGJyPg0KQEAgLTUyMSwxNCArNTIxLDMzIEBA
IHN0YXRpYyB2b2lkPGJyPg0KwqBjbGVhbnVwX3BkdW1wX3Jlc291cmNlcyh2b2lkKTxicj4NCsKg
ezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBpbnRlcmZhY2UgKmludGY7PGJyPg0KK8KgIMKgIMKg
IMKgaW50IHJldDs8YnI+DQorwqAgwqAgwqAgwqBib29sIGRpc2FibGVfZmFpbGVkID0gZmFsc2U7
PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgVEFJTFFfRk9SRUFDSChpbnRmLCAmYW1wO2ludGVyZmFj
ZXMsIG5leHQpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfcGR1bXBfZGlzYWJs
ZShpbnRmLSZndDtwb3J0LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFJURV9QRFVNUF9BTExfUVVFVUVTLCBSVEVfUERVTVBfRkxBR19SWFRY
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBydGVfcGR1bXBfZGlzYWJsZShp
bnRmLSZndDtwb3J0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9QRFVNUF9BTExfUVVFVUVTLCBSVEVfUERVTVBfRkxB
R19SWFRYKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpc2FibGVfZmFpbGVkID0g
dHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKHN0
ZGVyciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmcXVvdDtEaXNhYmxlIHBkdW1wIGZhaWxlZCBvbiAldTolczogJXNcbiZxdW90Oyw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnRmLSZndDtw
b3J0LCBpbnRmLSZndDtuYW1lLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJ0ZV9zdHJlcnJvcihydGVfZXJybm8pKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGludGYtJmd0
O29wdHMucHJvbWlzY19tb2RlKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJ0ZV9ldGhfcHJvbWlzY3VvdXNfZGlzYWJsZShpbnRmLSZndDtwb3J0KTs8YnI+DQrCoCDC
oCDCoCDCoCB9PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGRpc2FibGVfZmFpbGVkKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKiBGYWlsLWNsb3NlZDogaWYgZGlzYWJsZSBkaWQgbm90IGNvbXBsZXRlLCBrZWVwIHBkdW1w
IGFjdGlvbi9zdGF0ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGFsaXZlIGFuZCBk
byBub3QgdW5pbml0IHNoYXJlZCBjYXB0dXJlIHJlc291cmNlcy48YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVy
ciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtTa2lwcGlu
ZyBwZHVtcCB1bmluaXQgYmVjYXVzZSBkaXNhYmxlIGRpZCBub3QgY29tcGxldGUgb24gYWxsIGlu
dGVyZmFjZXNcbiZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxi
cj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgcnRlX3BkdW1wX3VuaW5p
dCgpOzxicj4NCsKgfTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9hcHAvcGR1bXAvbWFpbi5jIGIv
YXBwL3BkdW1wL21haW4uYzxicj4NCmluZGV4IDFlNjJjOGFkYzEuLjRjZmIwMzgzOTUgMTAwNjQ0
PGJyPg0KLS0tIGEvYXBwL3BkdW1wL21haW4uYzxicj4NCisrKyBiL2FwcC9wZHVtcC9tYWluLmM8
YnI+DQpAQCAtNDUxLDE0ICs0NTEsMTcgQEAgcHJpbnRfcGR1bXBfc3RhdHModm9pZCk8YnI+DQrC
oCDCoCDCoCDCoCB9PGJyPg0KwqB9PGJyPg0KPGJyPg0KLXN0YXRpYyBpbmxpbmUgdm9pZDxicj4N
CitzdGF0aWMgaW5saW5lIGludDxicj4NCsKgZGlzYWJsZV9wZHVtcChzdHJ1Y3QgcGR1bXBfdHVw
bGVzICpwdCk8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoCDCoCBpZiAocHQtJmd0O2R1bXBfYnlfdHlw
ZSA9PSBERVZJQ0VfSUQpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX3BkdW1wX2Rp
c2FibGVfYnlfZGV2aWNlaWQocHQtJmd0O2RldmljZV9pZCwgcHQtJmd0O3F1ZXVlLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHB0LSZndDtkaXIpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dHVybiBydGVfcGR1bXBfZGlzYWJsZV9ieV9kZXZpY2VpZChwdC0mZ3Q7ZGV2aWNlX2lkLCBwdC0m
Z3Q7cXVldWUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHB0LSZndDtkaXIpOzxicj4NCsKg
IMKgIMKgIMKgIGVsc2UgaWYgKHB0LSZndDtkdW1wX2J5X3R5cGUgPT0gUE9SVF9JRCk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfcGR1bXBfZGlzYWJsZShwdC0mZ3Q7cG9ydCwgcHQt
Jmd0O3F1ZXVlLCBwdC0mZ3Q7ZGlyKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gcnRlX3BkdW1wX2Rpc2FibGUocHQtJmd0O3BvcnQsIHB0LSZndDtxdWV1ZSwgcHQtJmd0O2Rp
cik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJ0ZV9lcnJubyA9IEVJTlZBTDs8YnI+DQorwqAg
wqAgwqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQrCoH08YnI+DQo8YnI+DQrCoHN0YXRpYyBpbmxp
bmUgdm9pZDxicj4NCkBAIC01MTgsMTUgKzUyMSwzMCBAQCBzdGF0aWMgdm9pZDxicj4NCsKgY2xl
YW51cF9wZHVtcF9yZXNvdXJjZXModm9pZCk8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoCDCoCBpbnQg
aTs8YnI+DQorwqAgwqAgwqAgwqBpbnQgcmV0Ozxicj4NCivCoCDCoCDCoCDCoGJvb2wgZGlzYWJs
ZV9mYWlsZWQgPSBmYWxzZTs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgcGR1bXBfdHVwbGVzICpw
dDs8YnI+DQrCoCDCoCDCoCDCoCBjaGFyIG5hbWVbUlRFX0VUSF9OQU1FX01BWF9MRU5dOzxicj4N
Cjxicj4NCi3CoCDCoCDCoCDCoC8qIGRpc2FibGUgcGR1bXAgYW5kIGZyZWUgdGhlIHBkdW1wX3R1
cGxlIHJlc291cmNlcyAqLzxicj4NCivCoCDCoCDCoCDCoC8qIERpc2FibGUgYWxsIGNhbGxiYWNr
cyBmaXJzdDsgZnJlZWluZyBzaGFyZWQgb2JqZWN0cyBiZWZvcmUgdGhpcyBpcyB1bnNhZmUuICov
PGJyPg0KwqAgwqAgwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IG51bV90dXBsZXM7IGkrKykgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHB0ID0gJmFtcDtwZHVtcF90W2ldOzxicj4NCjxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIHJlbW92ZSBjYWxsYmFja3MgKi88YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaXNhYmxlX3BkdW1wKHB0KTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXQgPSBkaXNhYmxlX3BkdW1wKHB0KTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGRpc2FibGVfZmFpbGVkID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludGYoJnF1b3Q7cGR1bXAgZGlzYWJsZSBmYWlsZWQgKHR1
cGxlPSVkLCBlcnJubz0lZDogJXMpOyAmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7c2tpcCB0ZWFyZG93biB0byBhdm9pZCBzdGFs
ZSBjYWxsYmFjayBhY2Nlc3NcbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaSwgcnRlX2Vycm5vLCBydGVfc3RyZXJyb3IocnRlX2Vycm5v
KSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoH08YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGRpc2FibGVfZmFpbGVkKTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogZnJlZSB0aGUg
cGR1bXBfdHVwbGUgcmVzb3VyY2VzICovPGJyPg0KK8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAm
bHQ7IG51bV90dXBsZXM7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHB0ID0g
JmFtcDtwZHVtcF90W2ldOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB0cmFuc21pdCByZXN0IG9mIHRoZSBlbnF1ZXVl
ZCBwYWNrZXRzIG9mIHRoZSByaW5ncyBvbiB0bzxicj4NCmRpZmYgLS1naXQgYS9kb2MvZ3VpZGVz
L3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzA3LnJzdCBiL2RvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVh
c2VfMjZfMDcucnN0PGJyPg0KaW5kZXggNGNhMGE5YWM3Ny4uMTcwMGE1NmJjNyAxMDA2NDQ8YnI+
DQotLS0gYS9kb2MvZ3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzA3LnJzdDxicj4NCisrKyBi
L2RvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjZfMDcucnN0PGJyPg0KQEAgLTE3Nyw2ICsx
NzcsMTMgQEAgTmV3IEZlYXR1cmVzPGJyPg0KwqAgwqBBZGRlZCBBR0VOVFMubWQgZmlsZSBmb3Ig
QUkgcmV2aWV3PGJyPg0KwqAgwqBhbmQgc3VwcG9ydGluZyBzY3JpcHRzIHRvIHJldmlldyBwYXRj
aGVzIGFuZCBkb2N1bWVudGF0aW9uLjxicj4NCjxicj4NCisqICoqSGFyZGVuZWQgcGR1bXAgdGVh
cmRvd24gb24gZGlzYWJsZSBmYWlsdXJlLioqPGJyPg0KKzxicj4NCivCoCBIYXJkZW5lZCBwZHVt
cCByZXF1ZXN0IGNvbXBsZXRpb24gYW5kIGFwcGxpY2F0aW9uIGNsZWFudXAgYmVoYXZpb3Igc28g
dGltZW91dDxicj4NCivCoCBvciBkaXNhYmxlIGZhaWx1cmUgZG9lcyBub3QgdHJpZ2dlciBwcmVt
YXR1cmUgcGR1bXAgcmVzb3VyY2UgdGVhcmRvd24uPGJyPg0KK8KgIHBkdW1wIG5vdyB1c2VzIGFu
IG9wdC1pbiBNUCByZXF1ZXN0IG1vZGUgdGhhdCBpZ25vcmVzIHBlZXJzIHdpdGhvdXQgdGhlPGJy
Pg0KK8KgIHBkdW1wIGFjdGlvbiwgd2hpbGUgcHJlc2VydmluZyBsZWdhY3kgRUFMIE1QIGJlaGF2
aW9yIGZvciBhbGwgb3RoZXIgdXNlcnMuPGJyPg0KKzxicj4NCjxicj4NCsKgUmVtb3ZlZCBJdGVt
czxicj4NCsKgLS0tLS0tLS0tLS0tLTxicj4NCmRpZmYgLS1naXQgYS9saWIvZWFsL2NvbW1vbi9l
YWxfY29tbW9uX3Byb2MuYyBiL2xpYi9lYWwvY29tbW9uL2VhbF9jb21tb25fcHJvYy5jPGJyPg0K
aW5kZXggMDZmMTUxODE4Yy4uNWE0NThjMDQxNyAxMDA2NDQ8YnI+DQotLS0gYS9saWIvZWFsL2Nv
bW1vbi9lYWxfY29tbW9uX3Byb2MuYzxicj4NCisrKyBiL2xpYi9lYWwvY29tbW9uL2VhbF9jb21t
b25fcHJvYy5jPGJyPg0KQEAgLTU2LDYgKzU2LDcgQEAgc3RhdGljIHN0cnVjdCBhY3Rpb25fZW50
cnlfbGlzdCBhY3Rpb25fZW50cnlfbGlzdCA9PGJyPg0KwqBlbnVtIG1wX3R5cGUgezxicj4NCsKg
IMKgIMKgIMKgIE1QX01TRywgLyogU2hhcmUgbWVzc2FnZSB3aXRoIHBlZXJzLCB3aWxsIG5vdCBi
bG9jayAqLzxicj4NCsKgIMKgIMKgIMKgIE1QX1JFUSwgLyogUmVxdWVzdCBmb3IgaW5mb3JtYXRp
b24sIFdpbGwgYmxvY2sgZm9yIGEgcmVwbHkgKi88YnI+DQorwqAgwqAgwqAgwqBNUF9SRVFfSUdO
LCAvKiBSZXF1ZXN0IHdoZXJlIG1pc3NpbmcgYWN0aW9uIHNob3VsZCByZXR1cm4gaWdub3JlICov
PGJyPg0KwqAgwqAgwqAgwqAgTVBfUkVQLCAvKiBSZXNwb25zZSB0byBwcmV2aW91c2x5LXJlY2Vp
dmVkIHJlcXVlc3QgKi88YnI+DQrCoCDCoCDCoCDCoCBNUF9JR04sIC8qIFJlc3BvbnNlIHRlbGxp
bmcgcmVxdWVzdGVyIHRvIGlnbm9yZSB0aGlzIHJlc3BvbnNlICovPGJyPg0KwqB9Ozxicj4NCkBA
IC0zODQsMTEgKzM4NSwxMSBAQCBwcm9jZXNzX21zZyhzdHJ1Y3QgbXBfbXNnX2ludGVybmFsICpt
LCBzdHJ1Y3Qgc29ja2FkZHJfdW4gKnMpPGJyPg0KwqAgwqAgwqAgwqAgcHRocmVhZF9tdXRleF91
bmxvY2soJmFtcDttcF9tdXRleF9hY3Rpb24pOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIGlmICgh
YWN0aW9uKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG0tJmd0O3R5cGUgPT0g
TVBfUkVRICZhbXA7JmFtcDsgIWludGVybmFsX2NvbmYtJmd0O2luaXRfY29tcGxldGUpIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBpZiB0aGlzIGlzIGEgcmVx
dWVzdCwgYW5kIGluaXQgaXMgbm90IHlldCBjb21wbGV0ZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBhbmQgY2FsbGJhY2sgd2FzbiYjMzk7dCByZWdpc3RlcmVk
LCB3ZSBzaG91bGQgdGVsbCB0aGU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgKiByZXF1ZXN0ZXIgdG8gaWdub3JlIG91ciBleGlzdGVuY2UgYmVjYXVzZSB3ZSYjMzk7
cmUgbm90PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogeWV0IHJl
YWR5IHRvIHByb2Nlc3MgdGhpcyByZXF1ZXN0Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmICgobS0mZ3Q7dHlwZSA9PSBNUF9SRVEgJmFtcDsmYW1wOyAhaW50ZXJuYWxfY29uZi0mZ3Q7
aW5pdF9jb21wbGV0ZSkgfHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtLSZn
dDt0eXBlID09IE1QX1JFUV9JR04pIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAvKjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEFz
ayByZXF1ZXN0ZXIgdG8gaWdub3JlIHRoaXMgcGVlciB3aGVuIGFjdGlvbiBpcyBub3Q8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiByZWdpc3RlcmVkIGVpdGhlciBk
dWUgdG8gZWFybHkgaW5pdCBvciBleHBsaWNpdCByZXF1ZXN0IHBvbGljeS48YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCovPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IHJ0ZV9tcF9tc2cgZHVtbXk7PGJyPg0KPGJyPg0KQEAg
LTkzNiw3ICs5MzcsOCBAQCBtcF9yZXF1ZXN0X2FzeW5jKGNvbnN0IGNoYXIgKmRzdCwgc3RydWN0
IHJ0ZV9tcF9tc2cgKnJlcSw8YnI+DQo8YnI+DQrCoHN0YXRpYyBpbnQ8YnI+DQrCoG1wX3JlcXVl
c3Rfc3luYyhjb25zdCBjaGFyICpkc3QsIHN0cnVjdCBydGVfbXBfbXNnICpyZXEsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBydGVfbXBfcmVwbHkgKnJlcGx5LCBjb25zdCBzdHJ1
Y3QgdGltZXNwZWMgKnRzKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgcnRlX21w
X3JlcGx5ICpyZXBseSwgY29uc3Qgc3RydWN0IHRpbWVzcGVjICp0cyw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZW51bSBtcF90eXBlIHJlcV90eXBlKTxicj4NCsKgezxicj4NCsKgIMKgIMKg
IMKgIGludCByZXQ7PGJyPg0KwqAgwqAgwqAgwqAgcHRocmVhZF9jb25kYXR0cl90IGF0dHI7PGJy
Pg0KQEAgLTk1OSw3ICs5NjEsNyBAQCBtcF9yZXF1ZXN0X3N5bmMoY29uc3QgY2hhciAqZHN0LCBz
dHJ1Y3QgcnRlX21wX21zZyAqcmVxLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVy
biAtMTs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgcmV0ID0gc2Vu
ZF9tc2coZHN0LCByZXEsIE1QX1JFUSk7PGJyPg0KK8KgIMKgIMKgIMKgcmV0ID0gc2VuZF9tc2co
ZHN0LCByZXEsIHJlcV90eXBlKTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAocmV0ICZsdDsgMCkgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVBTF9MT0coRVJSLCAmcXVvdDtGYWlsIHRvIHNl
bmQgcmVxdWVzdCAlczolcyZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBkc3QsIHJlcS0mZ3Q7bmFtZSk7PGJyPg0KQEAgLTEwMTAsMTEgKzEwMTIsMjAgQEAg
UlRFX0VYUE9SVF9TWU1CT0wocnRlX21wX3JlcXVlc3Rfc3luYyk8YnI+DQrCoGludDxicj4NCsKg
cnRlX21wX3JlcXVlc3Rfc3luYyhzdHJ1Y3QgcnRlX21wX21zZyAqcmVxLCBzdHJ1Y3QgcnRlX21w
X3JlcGx5ICpyZXBseSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25zdCBzdHJ1Y3Qg
dGltZXNwZWMgKnRzKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJ0ZV9tcF9yZXF1
ZXN0X3N5bmNfZXgocmVxLCByZXBseSwgdHMsIDApOzxicj4NCit9PGJyPg0KKzxicj4NCitSVEVf
RVhQT1JUX1NZTUJPTChydGVfbXBfcmVxdWVzdF9zeW5jX2V4KTxicj4NCitpbnQ8YnI+DQorcnRl
X21wX3JlcXVlc3Rfc3luY19leChzdHJ1Y3QgcnRlX21wX21zZyAqcmVxLCBzdHJ1Y3QgcnRlX21w
X3JlcGx5ICpyZXBseSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3Qg
dGltZXNwZWMgKnRzLCB1aW50MzJfdCBmbGFncyk8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoCDCoCBp
bnQgZGlyX2ZkLCByZXQgPSAtMTs8YnI+DQrCoCDCoCDCoCDCoCBESVIgKm1wX2Rpcjs8YnI+DQrC
oCDCoCDCoCDCoCBzdHJ1Y3QgZGlyZW50ICplbnQ7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IHRp
bWVzcGVjIG5vdywgZW5kOzxicj4NCivCoCDCoCDCoCDCoGVudW0gbXBfdHlwZSByZXFfdHlwZSA9
IE1QX1JFUTs8YnI+DQrCoCDCoCDCoCDCoCBjb25zdCBzdHJ1Y3QgaW50ZXJuYWxfY29uZmlnICpp
bnRlcm5hbF9jb25mID08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlYWxfZ2V0X2ludGVy
bmFsX2NvbmZpZ3VyYXRpb24oKTs8YnI+DQo8YnI+DQpAQCAtMTAyNyw2ICsxMDM4LDE0IEBAIHJ0
ZV9tcF9yZXF1ZXN0X3N5bmMoc3RydWN0IHJ0ZV9tcF9tc2cgKnJlcSwgc3RydWN0IHJ0ZV9tcF9y
ZXBseSAqcmVwbHksPGJyPg0KwqAgwqAgwqAgwqAgaWYgKGNoZWNrX2lucHV0KHJlcSkgIT0gMCk8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVuZDs8YnI+DQo8YnI+DQorwqAgwqAg
wqAgwqBpZiAoZmxhZ3MgJmFtcDsgflJURV9NUF9SRVFfRl9JR05PUkVfTk9fQUNUSU9OKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Vycm5vID0gRUlOVkFMOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgaWYgKGZsYWdzICZhbXA7IFJURV9NUF9SRVFfRl9JR05PUkVfTk9fQUNU
SU9OKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlcV90eXBlID0gTVBfUkVRX0lHTjs8
YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgaWYgKGludGVybmFsX2NvbmYtJmd0O25vX3NoY29uZikg
ezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVBTF9MT0coREVCVUcsICZxdW90O05vIHNo
YXJlZCBmaWxlcyBtb2RlIGVuYWJsZWQsIElQQyBpcyBkaXNhYmxlZCZxdW90Oyk7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcnRlX2Vycm5vID0gRU5PVFNVUDs8YnI+DQpAQCAtMTA0Niw3
ICsxMDY1LDcgQEAgcnRlX21wX3JlcXVlc3Rfc3luYyhzdHJ1Y3QgcnRlX21wX21zZyAqcmVxLCBz
dHJ1Y3QgcnRlX21wX3JlcGx5ICpyZXBseSw8YnI+DQrCoCDCoCDCoCDCoCAvKiBmb3Igc2Vjb25k
YXJ5IHByb2Nlc3MsIHNlbmQgcmVxdWVzdCB0byB0aGUgcHJpbWFyeSBwcm9jZXNzIG9ubHkgKi88
YnI+DQrCoCDCoCDCoCDCoCBpZiAocnRlX2VhbF9wcm9jZXNzX3R5cGUoKSA9PSBSVEVfUFJPQ19T
RUNPTkRBUlkpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwdGhyZWFkX211dGV4X2xv
Y2soJmFtcDtwZW5kaW5nX3JlcXVlc3RzLmxvY2spOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldCA9IG1wX3JlcXVlc3Rfc3luYyhlYWxfbXBfc29ja2V0X3BhdGgoKSwgcmVxLCByZXBs
eSwgJmFtcDtlbmQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IG1wX3JlcXVl
c3Rfc3luYyhlYWxfbXBfc29ja2V0X3BhdGgoKSwgcmVxLCByZXBseSwgJmFtcDtlbmQsIHJlcV90
eXBlKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwdGhyZWFkX211dGV4X3VubG9jaygm
YW1wO3BlbmRpbmdfcmVxdWVzdHMubG9jayk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Z290byBlbmQ7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCkBAIC0xMDg2LDcgKzExMDUsNyBAQCBy
dGVfbXBfcmVxdWVzdF9zeW5jKHN0cnVjdCBydGVfbXBfbXNnICpyZXEsIHN0cnVjdCBydGVfbXBf
cmVwbHkgKnJlcGx5LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIHVubG9ja3MgdGhl
IG11dGV4IHdoaWxlIHdhaXRpbmcgZm9yIHJlc3BvbnNlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKiBsb2NrcyBvbiByZWNlaXZlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAqLzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChtcF9yZXF1ZXN0X3N5bmMocGF0
aCwgcmVxLCByZXBseSwgJmFtcDtlbmQpKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChtcF9yZXF1ZXN0X3N5bmMocGF0aCwgcmVxLCByZXBseSwgJmFtcDtlbmQsIHJlcV90eXBlKSk8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIHVubG9ja19lbmQ7
PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIHJldCA9IDA7PGJyPg0KZGlmZiAt
LWdpdCBhL2xpYi9lYWwvaW5jbHVkZS9ydGVfZWFsLmggYi9saWIvZWFsL2luY2x1ZGUvcnRlX2Vh
bC5oPGJyPg0KaW5kZXggNzI0MWYzYmU1ZC4uNDE1Yjk3NDk0NSAxMDA2NDQ8YnI+DQotLS0gYS9s
aWIvZWFsL2luY2x1ZGUvcnRlX2VhbC5oPGJyPg0KKysrIGIvbGliL2VhbC9pbmNsdWRlL3J0ZV9l
YWwuaDxicj4NCkBAIC0xNzMsNiArMTczLDE1IEBAIHN0cnVjdCBydGVfbXBfcmVwbHkgezxicj4N
CsKgIMKgIMKgIMKgIHN0cnVjdCBydGVfbXBfbXNnICptc2dzOyAvKiBjYWxsZXIgdG8gZnJlZSAq
Lzxicj4NCsKgfTs8YnI+DQo8YnI+DQorLyoqIFJlcXVlc3QgZmxhZ3MgZm9yIHJ0ZV9tcF9yZXF1
ZXN0X3N5bmNfZXgoKS4gKi88YnI+DQorZW51bSBydGVfbXBfcmVxdWVzdF9mbGFncyB7PGJyPg0K
K8KgIMKgIMKgIMKgLyoqPGJyPg0KK8KgIMKgIMKgIMKgICogQXNrIHBlZXJzIHRoYXQgZG8gbm90
IGhhdmUgYSByZWdpc3RlcmVkIGFjdGlvbiB0byByZXR1cm4gTVBfSUdOPGJyPg0KK8KgIMKgIMKg
IMKgICogaW5zdGVhZCBvZiBjYXVzaW5nIHRpbWVvdXQgZm9yIHRoaXMgcmVxdWVzdC48YnI+DQor
wqAgwqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqBSVEVfTVBfUkVRX0ZfSUdOT1JFX05PX0FD
VElPTiA9IDF1ICZsdDsmbHQ7IDAsPGJyPg0KK307PGJyPg0KKzxicj4NCsKgLyoqPGJyPg0KwqAg
KiBBY3Rpb24gZnVuY3Rpb24gdHlwZWRlZiB1c2VkIGJ5IG90aGVyIGNvbXBvbmVudHMuPGJyPg0K
wqAgKjxicj4NCkBAIC0yOTIsNiArMzAxLDMwIEBAIGludDxicj4NCsKgcnRlX21wX3JlcXVlc3Rf
c3luYyhzdHJ1Y3QgcnRlX21wX21zZyAqcmVxLCBzdHJ1Y3QgcnRlX21wX3JlcGx5ICpyZXBseSw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCB0aW1lc3BlYyAqdHMpOzxi
cj4NCjxicj4NCisvKio8YnI+DQorICogU2VuZCBhIHJlcXVlc3QgdG8gcGVlciBwcm9jZXNzZXMg
d2l0aCBleHBsaWNpdCByZXF1ZXN0IGZsYWdzLjxicj4NCisgKjxicj4NCisgKiBUaGlzIEFQSSBp
cyBlcXVpdmFsZW50IHRvIHJ0ZV9tcF9yZXF1ZXN0X3N5bmMoKSB3aXRoIG9wdC1pbiBiZWhhdmlv
cjxicj4NCisgKiBjb250cm9scyBwcm92aWRlZCB0aHJvdWdoIEBwIGZsYWdzLjxicj4NCisgKjxi
cj4NCisgKiBAcGFyYW0gcmVxPGJyPg0KKyAqwqAgwqBUaGUgcmVxIGFyZ3VtZW50IGNvbnRhaW5z
IHRoZSBjdXN0b21pemVkIHJlcXVlc3QgbWVzc2FnZS48YnI+DQorICogQHBhcmFtIHJlcGx5PGJy
Pg0KKyAqwqAgwqBUaGUgcmVwbHkgYXJndW1lbnQgd2lsbCBiZSBmb3Igc3RvcmluZyBhbGwgdGhl
IHJlcGxpZWQgbWVzc2FnZXM7PGJyPg0KKyAqwqAgwqB0aGUgY2FsbGVyIGlzIHJlc3BvbnNpYmxl
IGZvciBmcmVlIHJlcGx5LSZndDttc2dzLjxicj4NCisgKiBAcGFyYW0gdHM8YnI+DQorICrCoCDC
oFRoZSB0cyBhcmd1bWVudCBzcGVjaWZpZXMgaG93IGxvbmcgd2UgY2FuIHdhaXQgZm9yIHRoZSBw
ZWVyKHMpIHRvIHJlcGx5Ljxicj4NCisgKiBAcGFyYW0gZmxhZ3M8YnI+DQorICrCoCDCoEJpdG1h
c2sgb2YgdmFsdWVzIGZyb20gZW51bSBydGVfbXBfcmVxdWVzdF9mbGFncy48YnI+DQorICo8YnI+
DQorICogQHJldHVybjxicj4NCisgKsKgIC0gT24gc3VjY2VzcywgcmV0dXJuIDAuPGJyPg0KKyAq
wqAgLSBPbiBmYWlsdXJlLCByZXR1cm4gLTEsIGFuZCB0aGUgcmVhc29uIHdpbGwgYmUgc3RvcmVk
IGluIHJ0ZV9lcnJuby48YnI+DQorICovPGJyPg0KK2ludDxicj4NCitydGVfbXBfcmVxdWVzdF9z
eW5jX2V4KHN0cnVjdCBydGVfbXBfbXNnICpyZXEsIHN0cnVjdCBydGVfbXBfcmVwbHkgKnJlcGx5
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCB0aW1lc3BlYyAqdHMs
IHVpbnQzMl90IGZsYWdzKTs8YnI+DQorPGJyPg0KwqAvKio8YnI+DQrCoCAqIFNlbmQgYSByZXF1
ZXN0IHRvIHRoZSBwZWVyIHByb2Nlc3MgYW5kIGV4cGVjdCBhIHJlcGx5IGluIGEgc2VwYXJhdGUg
Y2FsbGJhY2suPGJyPg0KwqAgKjxicj4NCmRpZmYgLS1naXQgYS9saWIvZWFsL3dpbmRvd3MvZWFs
X21wLmMgYi9saWIvZWFsL3dpbmRvd3MvZWFsX21wLmM8YnI+DQppbmRleCA2NzAzMzU1MzE4Li4x
MDY2YTRkMmJjIDEwMDY0NDxicj4NCi0tLSBhL2xpYi9lYWwvd2luZG93cy9lYWxfbXAuYzxicj4N
CisrKyBiL2xpYi9lYWwvd2luZG93cy9lYWxfbXAuYzxicj4NCkBAIC01NiwxMCArNTYsMTkgQEAg
UlRFX0VYUE9SVF9TWU1CT0wocnRlX21wX3JlcXVlc3Rfc3luYyk8YnI+DQrCoGludDxicj4NCsKg
cnRlX21wX3JlcXVlc3Rfc3luYyhzdHJ1Y3QgcnRlX21wX21zZyAqcmVxLCBzdHJ1Y3QgcnRlX21w
X3JlcGx5ICpyZXBseSw8YnI+DQrCoCDCoCDCoCDCoCBjb25zdCBzdHJ1Y3QgdGltZXNwZWMgKnRz
KTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJ0ZV9tcF9yZXF1ZXN0X3N5bmNfZXgo
cmVxLCByZXBseSwgdHMsIDApOzxicj4NCit9PGJyPg0KKzxicj4NCitSVEVfRVhQT1JUX1NZTUJP
TChydGVfbXBfcmVxdWVzdF9zeW5jX2V4KTxicj4NCitpbnQ8YnI+DQorcnRlX21wX3JlcXVlc3Rf
c3luY19leChzdHJ1Y3QgcnRlX21wX21zZyAqcmVxLCBzdHJ1Y3QgcnRlX21wX3JlcGx5ICpyZXBs
eSw8YnI+DQorwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgdGltZXNwZWMgKnRzLCB1aW50MzJfdCBm
bGFncyk8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoCDCoCBSVEVfU0VUX1VTRUQocmVxKTs8YnI+DQrC
oCDCoCDCoCDCoCBSVEVfU0VUX1VTRUQocmVwbHkpOzxicj4NCsKgIMKgIMKgIMKgIFJURV9TRVRf
VVNFRCh0cyk7PGJyPg0KK8KgIMKgIMKgIMKgUlRFX1NFVF9VU0VEKGZsYWdzKTs8YnI+DQrCoCDC
oCDCoCDCoCBFQUxfTE9HX05PVF9JTVBMRU1FTlRFRCgpOzxicj4NCsKgIMKgIMKgIMKgIHJldHVy
biAtMTs8YnI+DQrCoH08YnI+DQpkaWZmIC0tZ2l0IGEvbGliL3BkdW1wL3J0ZV9wZHVtcC5jIGIv
bGliL3BkdW1wL3J0ZV9wZHVtcC5jPGJyPg0KaW5kZXggYWM5NGVmZTdmZi4uMzc2NGFlYjJkMyAx
MDA2NDQ8YnI+DQotLS0gYS9saWIvcGR1bXAvcnRlX3BkdW1wLmM8YnI+DQorKysgYi9saWIvcGR1
bXAvcnRlX3BkdW1wLmM8YnI+DQpAQCAtMyw5ICszLDEyIEBAPGJyPg0KwqAgKi88YnI+DQo8YnI+
DQrCoCNpbmNsdWRlICZsdDtzdGRsaWIuaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0O2Vycm5vLmgm
Z3Q7PGJyPg0KPGJyPg0KwqAjaW5jbHVkZSAmbHQ7ZWFsX2V4cG9ydC5oJmd0Ozxicj4NCisjaW5j
bHVkZSAmbHQ7cnRlX2VhbC5oJmd0Ozxicj4NCsKgI2luY2x1ZGUgJmx0O3J0ZV9hbGFybS5oJmd0
Ozxicj4NCisjaW5jbHVkZSAmbHQ7cnRlX2N5Y2xlcy5oJmd0Ozxicj4NCsKgI2luY2x1ZGUgJmx0
O3J0ZV9tYnVmLmgmZ3Q7PGJyPg0KwqAjaW5jbHVkZSAmbHQ7cnRlX2V0aGRldi5oJmd0Ozxicj4N
CsKgI2luY2x1ZGUgJmx0O3J0ZV9sY29yZS5oJmd0Ozxicj4NCkBAIC02OCw2ICs3MSw3IEBAIHN0
cnVjdCBwZHVtcF9yZXF1ZXN0IHs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBjb25zdCBzdHJ1Y3Qg
cnRlX2JwZl9wcm0gKnBybTs8YnI+DQrCoCDCoCDCoCDCoCB1aW50MzJfdCBzbmFwbGVuOzxicj4N
CivCoCDCoCDCoCDCoHVpbnQzMl90IGdlbmVyYXRpb247PGJyPg0KwqB9Ozxicj4NCjxicj4NCsKg
c3RydWN0IHBkdW1wX3Jlc3BvbnNlIHs8YnI+DQpAQCAtODEsNiArODUsMTEgQEAgc3RydWN0IHBk
dW1wX2J1bmRsZSB7PGJyPg0KwqAgwqAgwqAgwqAgY2hhciBwZWVyW107PGJyPg0KwqB9Ozxicj4N
Cjxicj4NCitzdHJ1Y3QgcGR1bXBfc2hhcmVkX2N0bCB7PGJyPg0KK8KgIMKgIMKgIMKgUlRFX0FU
T01JQyh1aW50MzJfdCkgZW5hYmxlZDs8YnI+DQorwqAgwqAgwqAgwqBSVEVfQVRPTUlDKHVpbnQz
Ml90KSBpbmZsaWdodDs8YnI+DQorfTs8YnI+DQorPGJyPg0KwqBzdGF0aWMgc3RydWN0IHBkdW1w
X3J4dHhfY2JzIHs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgcnRlX3JpbmcgKnJpbmc7PGJyPg0K
wqAgwqAgwqAgwqAgc3RydWN0IHJ0ZV9tZW1wb29sICptcDs8YnI+DQpAQCAtODgsMTEgKzk3LDEx
IEBAIHN0YXRpYyBzdHJ1Y3QgcGR1bXBfcnh0eF9jYnMgezxicj4NCsKgIMKgIMKgIMKgIGNvbnN0
IHN0cnVjdCBydGVfYnBmICpmaWx0ZXI7PGJyPg0KwqAgwqAgwqAgwqAgZW51bSBwZHVtcF92ZXJz
aW9uIHZlcjs8YnI+DQrCoCDCoCDCoCDCoCB1aW50MzJfdCBzbmFwbGVuOzxicj4NCivCoCDCoCDC
oCDCoHVpbnQzMl90IGdlbmVyYXRpb247PGJyPg0KwqAgwqAgwqAgwqAgUlRFX0FUT01JQyh1aW50
MzJfdCkgdXNlX2NvdW50Ozxicj4NCsKgfSByeF9jYnNbUlRFX01BWF9FVEhQT1JUU11bUlRFX01B
WF9RVUVVRVNfUEVSX1BPUlRdLDxicj4NCsKgdHhfY2JzW1JURV9NQVhfRVRIUE9SVFNdW1JURV9N
QVhfUVVFVUVTX1BFUl9QT1JUXTs8YnI+DQo8YnI+DQotPGJyPg0KwqAvKjxicj4NCsKgICogVGhl
IHBhY2tldCBjYXB0dXJlIHN0YXRpc3RpY3Mga2VlcCB0cmFjayBvZiBwYWNrZXRzPGJyPg0KwqAg
KiBhY2NlcHRlZCwgZmlsdGVyZWQgYW5kIGRyb3BwZWQuIFRoZXNlIGFyZSBwZXItcXVldWU8YnI+
DQpAQCAtMTAyLDkgKzExMSw1OSBAQCBzdGF0aWMgY29uc3QgY2hhciBNWl9SVEVfUERVTVBfU1RB
VFNbXSA9ICZxdW90O3J0ZV9wZHVtcF9zdGF0cyZxdW90Ozs8YnI+DQrCoHN0YXRpYyBzdHJ1Y3Qg
ezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBydGVfcGR1bXBfc3RhdHMgcnhbUlRFX01BWF9FVEhQ
T1JUU11bUlRFX01BWF9RVUVVRVNfUEVSX1BPUlRdOzxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBy
dGVfcGR1bXBfc3RhdHMgdHhbUlRFX01BWF9FVEhQT1JUU11bUlRFX01BWF9RVUVVRVNfUEVSX1BP
UlRdOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBwZHVtcF9zaGFyZWRfY3RsIHJ4X2N0bFtSVEVf
TUFYX0VUSFBPUlRTXVtSVEVfTUFYX1FVRVVFU19QRVJfUE9SVF07PGJyPg0KK8KgIMKgIMKgIMKg
c3RydWN0IHBkdW1wX3NoYXJlZF9jdGwgdHhfY3RsW1JURV9NQVhfRVRIUE9SVFNdW1JURV9NQVhf
UVVFVUVTX1BFUl9QT1JUXTs8YnI+DQorwqAgwqAgwqAgwqBSVEVfQVRPTUlDKHVpbnQzMl90KSBn
ZW5lcmF0aW9uOzxicj4NCsKgIMKgIMKgIMKgIGNvbnN0IHN0cnVjdCBydGVfbWVtem9uZSAqbXo7
PGJyPg0KwqB9ICpwZHVtcF9zdGF0czs8YnI+DQo8YnI+DQorc3RhdGljIGludDxicj4NCitwZHVt
cF9lbnRlcihzdHJ1Y3QgcGR1bXBfc2hhcmVkX2N0bCAqY3RsLCBjb25zdCBzdHJ1Y3QgcGR1bXBf
cnh0eF9jYnMgKmNicyk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IGdlbmVyYXRp
b24gPSBydGVfYXRvbWljX2xvYWRfZXhwbGljaXQoJmFtcDtwZHVtcF9zdGF0cy0mZ3Q7Z2VuZXJh
dGlvbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcnRlX21lbW9yeV9vcmRlcl9yZWxh
eGVkKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJ0ZV9hdG9taWNfbG9hZF9leHBsaWNp
dCgmYW1wO2N0bC0mZ3Q7ZW5hYmxlZCwgcnRlX21lbW9yeV9vcmRlcl9yZWxheGVkKSA9PSAwIHx8
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgY2JzLSZndDtnZW5lcmF0aW9uICE9IGdlbmVyYXRpb24p
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoHJ0ZV9hdG9taWNfZmV0Y2hfYWRkX2V4cGxpY2l0KCZhbXA7Y3RsLSZndDtpbmZsaWdo
dCwgMSwgcnRlX21lbW9yeV9vcmRlcl9hY3F1aXJlKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
Lyo8YnI+DQorwqAgwqAgwqAgwqAgKiBEaXNhYmxlL3JlLWVuYWJsZSBtYXkgcmFjZSB3aXRoIGNh
bGxiYWNrIGVudHJ5LiBSZS1jaGVjayBlbmFibGVkIGFuZDxicj4NCivCoCDCoCDCoCDCoCAqIGdl
bmVyYXRpb24gYWZ0ZXIgdGFraW5nIGluZmxpZ2h0IHJlZmVyZW5jZSBzbyBkaXNhYmxlIGNhbiB3
YWl0IGZvciB0aGlzPGJyPg0KK8KgIMKgIMKgIMKgICogY2FsbGJhY2sgdG8gZHJhaW4gYW5kIHN0
YWxlIGNhbGxiYWNrcyBiZWNvbWUgbm8tb3AuPGJyPg0KK8KgIMKgIMKgIMKgICovPGJyPg0KK8Kg
IMKgIMKgIMKgZ2VuZXJhdGlvbiA9IHJ0ZV9hdG9taWNfbG9hZF9leHBsaWNpdCgmYW1wO3BkdW1w
X3N0YXRzLSZndDtnZW5lcmF0aW9uLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBydGVfbWVtb3J5X29yZGVyX3Jl
bGF4ZWQpOzxicj4NCivCoCDCoCDCoCDCoGlmIChydGVfYXRvbWljX2xvYWRfZXhwbGljaXQoJmFt
cDtjdGwtJmd0O2VuYWJsZWQsIHJ0ZV9tZW1vcnlfb3JkZXJfcmVsYXhlZCkgIT0gMCAmYW1wOyZh
bXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgY2JzLSZndDtnZW5lcmF0aW9uID09IGdlbmVyYXRp
b24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDE7PGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoHJ0ZV9hdG9taWNfZmV0Y2hfc3ViX2V4cGxpY2l0KCZhbXA7Y3RsLSZndDtpbmZs
aWdodCwgMSwgcnRlX21lbW9yeV9vcmRlcl9yZWxlYXNlKTs8YnI+DQorwqAgwqAgwqAgwqByZXR1
cm4gMDs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIF9fcnRlX2Fsd2F5c19pbmxpbmUgdm9p
ZDxicj4NCitwZHVtcF9leGl0KHN0cnVjdCBwZHVtcF9zaGFyZWRfY3RsICpjdGwpPGJyPg0KK3s8
YnI+DQorwqAgwqAgwqAgwqBydGVfYXRvbWljX2ZldGNoX3N1Yl9leHBsaWNpdCgmYW1wO2N0bC0m
Z3Q7aW5mbGlnaHQsIDEsIHJ0ZV9tZW1vcnlfb3JkZXJfcmVsZWFzZSk7PGJyPg0KK308YnI+DQor
PGJyPg0KK3N0YXRpYyBpbnQ8YnI+DQorcGR1bXBfd2FpdF9pbmZsaWdodChzdHJ1Y3QgcGR1bXBf
c2hhcmVkX2N0bCAqY3RsKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgdWludDY0X3QgZW5kX3Rz
YyA9IHJ0ZV9nZXRfdGltZXJfY3ljbGVzKCkgKyBNUF9USU1FT1VUX1MgKiBydGVfZ2V0X3RpbWVy
X2h6KCk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHdoaWxlIChydGVfYXRvbWljX2xvYWRfZXhw
bGljaXQoJmFtcDtjdGwtJmd0O2luZmxpZ2h0LCBydGVfbWVtb3J5X29yZGVyX2FjcXVpcmUpICE9
IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocnRlX2dldF90aW1lcl9jeWNs
ZXMoKSAmZ3Q7IGVuZF90c2MpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIC1FVElNRURPVVQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX3Bh
dXNlKCk7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4g
MDs8YnI+DQorfTxicj4NCis8YnI+DQrCoHN0YXRpYyB2b2lkPGJyPg0KwqBwZHVtcF9jYl93YWl0
KHN0cnVjdCBwZHVtcF9yeHR4X2NicyAqY2JzKTxicj4NCsKgezxicj4NCkBAIC0yMjQsMTIgKzI4
MywxNyBAQCBwZHVtcF9yeCh1aW50MTZfdCBwb3J0LCB1aW50MTZfdCBxdWV1ZSw8YnI+DQrCoCDC
oCDCoCDCoCB1aW50MTZfdCBtYXhfcGt0cyBfX3J0ZV91bnVzZWQsIHZvaWQgKnVzZXJfcGFyYW1z
KTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBwZHVtcF9yeHR4X2NicyAqY2JzID0g
dXNlcl9wYXJhbXM7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHBkdW1wX3NoYXJlZF9jdGwgKmN0
bCA9ICZhbXA7cGR1bXBfc3RhdHMtJmd0O3J4X2N0bFtwb3J0XVtxdWV1ZV07PGJyPg0KwqAgwqAg
wqAgwqAgc3RydWN0IHJ0ZV9wZHVtcF9zdGF0cyAqc3RhdHMgPSAmYW1wO3BkdW1wX3N0YXRzLSZn
dDtyeFtwb3J0XVtxdWV1ZV07PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFwZHVtcF9lbnRl
cihjdGwsIGNicykpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIG5iX3BrdHM7
PGJyPg0KKzxicj4NCsKgIMKgIMKgIMKgIHBkdW1wX2NiX2hvbGQoY2JzKTs8YnI+DQrCoCDCoCDC
oCDCoCBwZHVtcF9jb3B5KHBvcnQsIHF1ZXVlLCBSVEVfUENBUE5HX0RJUkVDVElPTl9JTiw8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBrdHMsIG5iX3BrdHMsIGNicywgc3RhdHMp
Ozxicj4NCsKgIMKgIMKgIMKgIHBkdW1wX2NiX3JlbGVhc2UoY2JzKTs8YnI+DQorwqAgwqAgwqAg
wqBwZHVtcF9leGl0KGN0bCk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJuIG5iX3BrdHM7
PGJyPg0KwqB9PGJyPg0KQEAgLTIzOSwxMiArMzAzLDE3IEBAIHBkdW1wX3R4KHVpbnQxNl90IHBv
cnQsIHVpbnQxNl90IHF1ZXVlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBy
dGVfbWJ1ZiAqKnBrdHMsIHVpbnQxNl90IG5iX3BrdHMsIHZvaWQgKnVzZXJfcGFyYW1zKTxicj4N
CsKgezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBwZHVtcF9yeHR4X2NicyAqY2JzID0gdXNlcl9w
YXJhbXM7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHBkdW1wX3NoYXJlZF9jdGwgKmN0bCA9ICZh
bXA7cGR1bXBfc3RhdHMtJmd0O3R4X2N0bFtwb3J0XVtxdWV1ZV07PGJyPg0KwqAgwqAgwqAgwqAg
c3RydWN0IHJ0ZV9wZHVtcF9zdGF0cyAqc3RhdHMgPSAmYW1wO3BkdW1wX3N0YXRzLSZndDt0eFtw
b3J0XVtxdWV1ZV07PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFwZHVtcF9lbnRlcihjdGws
IGNicykpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIG5iX3BrdHM7PGJyPg0K
Kzxicj4NCsKgIMKgIMKgIMKgIHBkdW1wX2NiX2hvbGQoY2JzKTs8YnI+DQrCoCDCoCDCoCDCoCBw
ZHVtcF9jb3B5KHBvcnQsIHF1ZXVlLCBSVEVfUENBUE5HX0RJUkVDVElPTl9PVVQsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwa3RzLCBuYl9wa3RzLCBjYnMsIHN0YXRzKTs8YnI+
DQrCoCDCoCDCoCDCoCBwZHVtcF9jYl9yZWxlYXNlKGNicyk7PGJyPg0KK8KgIMKgIMKgIMKgcGR1
bXBfZXhpdChjdGwpOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIHJldHVybiBuYl9wa3RzOzxicj4N
CsKgfTxicj4NCkBAIC0yNTUsMjAgKzMyNCw0MyBAQCBwZHVtcF9yZWdpc3Rlcl9yeF9jYWxsYmFj
a3MoZW51bSBwZHVtcF92ZXJzaW9uIHZlciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB1aW50MTZfdCBlbmRfcSwgdWludDE2X3QgcG9ydCwgdWludDE2X3Qg
cXVldWUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3Ry
dWN0IHJ0ZV9yaW5nICpyaW5nLCBzdHJ1Y3QgcnRlX21lbXBvb2wgKm1wLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBydGVfYnBmICpmaWx0ZXIs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDE2X3Qg
b3BlcmF0aW9uLCB1aW50MzJfdCBzbmFwbGVuKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQxNl90IG9wZXJhdGlvbiwgdWludDMyX3Qgc25hcGxlbiw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MzJfdCBn
ZW5lcmF0aW9uKTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIHVpbnQxNl90IHFpZDs8YnI+DQo8
YnI+DQrCoCDCoCDCoCDCoCBxaWQgPSAocXVldWUgPT0gUlRFX1BEVU1QX0FMTF9RVUVVRVMpID8g
MCA6IHF1ZXVlOzxicj4NCsKgIMKgIMKgIMKgIGZvciAoOyBxaWQgJmx0OyBlbmRfcTsgcWlkKysp
IHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgcGR1bXBfcnh0eF9jYnMgKmNi
cyA9ICZhbXA7cnhfY2JzW3BvcnRdW3FpZF07PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3RydWN0IHBkdW1wX3NoYXJlZF9jdGwgKmN0bCA9ICZhbXA7cGR1bXBfc3RhdHMtJmd0O3J4X2N0
bFtwb3J0XVtxaWRdOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChvcGVy
YXRpb24gPT0gRU5BQkxFKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaW50IHJldDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgaWYgKGNicy0mZ3Q7Y2IpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBQRFVNUF9MT0dfTElORShFUlIsPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7cnggY2Fs
bGJhY2sgZm9yIHBvcnQ9JWQgcXVldWU9JWQsIGFscmVhZHkgZXhpc3RzJnF1b3Q7LDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHBvcnQsIHFpZCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIC1FRVhJU1Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGNicy0mZ3Q7Z2VuZXJhdGlvbiA9PSBnZW5lcmF0aW9u
ICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBydGVfYXRvbWljX2xvYWRfZXhwbGljaXQoJmFtcDtjdGwtJmd0O2VuYWJs
ZWQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcnRlX21lbW9yeV9vcmRlcl9yZWxheGVkKSAhPSAwKSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgUERVTVBfTE9HX0xJTkUoRVJSLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O3J4IGNhbGxi
YWNrIGZvciBwb3J0PSVkIHF1ZXVlPSVkLCBhbHJlYWR5IGV4aXN0cyZxdW90Oyw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBwb3J0LCBxaWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUVYSVNUOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUERVTVBfTE9H
X0xJTkUoREVCVUcsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7cmVjb25jaWxpbmcgc3RhbGUgcnggY2FsbGJhY2sg
Zm9yIHBvcnQ9JWQgcXVldWU9JWQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDsgb2xkX2dlbj0ldSBuZXdf
Z2VuPSV1JnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcnQsIHFpZCwgY2JzLSZndDtnZW5lcmF0aW9uLCBnZW5l
cmF0aW9uKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gcnRlX2V0aF9yZW1vdmVfcnhfY2FsbGJhY2socG9ydCwgcWlkLCBj
YnMtJmd0O2NiKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFBEVU1QX0xPR19MSU5FKEVSUiw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtmYWlsZWQgdG8gcmVjb25jaWxlIHN0YWxlIHJ4IGNhbGxi
YWNrLCBlcnJubz0lZCZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtcmV0KTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gcmV0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBwZHVtcF9jYl93YWl0KGNicyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY2JzLSZndDtjYiA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGNicy0mZ3Q7dXNlX2NvdW50ID0gMDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBjYnMtJmd0O3ZlciA9IHZlcjs8YnI+DQpAQCAtMjc2LDYgKzM2OCw3
IEBAIHBkdW1wX3JlZ2lzdGVyX3J4X2NhbGxiYWNrcyhlbnVtIHBkdW1wX3ZlcnNpb24gdmVyLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNicy0mZ3Q7bXAgPSBtcDs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYnMtJmd0O3NuYXBsZW4g
PSBzbmFwbGVuOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNicy0m
Z3Q7ZmlsdGVyID0gZmlsdGVyOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNicy0mZ3Q7Z2VuZXJhdGlvbiA9IGdlbmVyYXRpb247PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2JzLSZndDtjYiA9IHJ0ZV9ldGhfYWRkX2ZpcnN0
X3J4X2NhbGxiYWNrKHBvcnQsIHFpZCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBwZHVtcF9yeCwgY2JzKTs8YnI+DQpAQCAtMjg2LDEwICszNzksMTUgQEAgcGR1
bXBfcmVnaXN0ZXJfcnhfY2FsbGJhY2tzKGVudW0gcGR1bXBfdmVyc2lvbiB2ZXIsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJ0ZV9l
cnJubzs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2F0b21pY19zdG9yZV9l
eHBsaWNpdCgmYW1wO2N0bC0mZ3Q7aW5mbGlnaHQsIDAsIHJ0ZV9tZW1vcnlfb3JkZXJfcmVsYXhl
ZCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2F0b21pY19z
dG9yZV9leHBsaWNpdCgmYW1wO2N0bC0mZ3Q7ZW5hYmxlZCwgMSwgcnRlX21lbW9yeV9vcmRlcl9y
ZWxlYXNlKTs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
bWVtc2V0KCZhbXA7cGR1bXBfc3RhdHMtJmd0O3J4W3BvcnRdW3FpZF0sIDAsIHNpemVvZihzdHJ1
Y3QgcnRlX3BkdW1wX3N0YXRzKSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNl
IGlmIChvcGVyYXRpb24gPT0gRElTQUJMRSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGludCByZXQ7PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcnRlX2F0b21pY19zdG9yZV9leHBsaWNpdCgmYW1wO2N0bC0mZ3Q7ZW5hYmxl
ZCwgMCwgcnRlX21lbW9yeV9vcmRlcl9yZWxlYXNlKTs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGNicy0mZ3Q7Y2IgPT0gTlVMTCkgezxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBEVU1QX0xPR19M
SU5FKEVSUiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtubyBleGlzdGluZyByeCBjYWxsYmFjayBmb3IgcG9ydD0l
ZCBxdWV1ZT0lZCZxdW90Oyw8YnI+DQpAQCAtMjk4LDYgKzM5NiwxMSBAQCBwZHVtcF9yZWdpc3Rl
cl9yeF9jYWxsYmFja3MoZW51bSBwZHVtcF92ZXJzaW9uIHZlciw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcmV0ID0gcnRlX2V0aF9yZW1vdmVfcnhfY2FsbGJhY2socG9ydCwgcWlkLCBjYnMt
Jmd0O2NiKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmV0
ICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC8qIEtlZXAgc3RhdGUgY29oZXJlbnQ6IGNhbGxiYWNrIGlzIHN0aWxsIHJlZ2lzdGVy
ZWQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICogc28gcmVzdG9yZSBlbmFibGVkLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9hdG9taWNfc3RvcmVfZXhwbGljaXQoJmFtcDtjdGwtJmd0
O2VuYWJsZWQsIDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX21lbW9yeV9vcmRlcl9yZWxlYXNl
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQ
RFVNUF9MT0dfTElORShFUlIsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7ZmFpbGVkIHRvIHJlbW92ZSByeCBjYWxs
YmFjaywgZXJybm89JWQmcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLXJldCk7PGJyPg0KQEAgLTMwNSw2ICs0MDgs
MTAgQEAgcGR1bXBfcmVnaXN0ZXJfcnhfY2FsbGJhY2tzKGVudW0gcGR1bXBfdmVyc2lvbiB2ZXIs
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBkdW1wX2NiX3dhaXQoY2JzKTs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYnMtJmd0O2NiID0gTlVMTDs8YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcGR1bXBfd2Fp
dF9pbmZsaWdodChjdGwpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChyZXQgJmx0OyAwKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQpAQCAtMzE2LDcgKzQyMyw4IEBAIHBkdW1wX3Jl
Z2lzdGVyX3R4X2NhbGxiYWNrcyhlbnVtIHBkdW1wX3ZlcnNpb24gdmVyLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQxNl90IGVuZF9xLCB1aW50MTZf
dCBwb3J0LCB1aW50MTZfdCBxdWV1ZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzdHJ1Y3QgcnRlX3JpbmcgKnJpbmcsIHN0cnVjdCBydGVfbWVtcG9vbCAq
bXAsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0
IHJ0ZV9icGYgKmZpbHRlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB1aW50MTZfdCBvcGVyYXRpb24sIHVpbnQzMl90IHNuYXBsZW4pPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDE2X3Qgb3BlcmF0aW9uLCB1
aW50MzJfdCBzbmFwbGVuLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHVpbnQzMl90IGdlbmVyYXRpb24pPGJyPg0KwqB7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgdWludDE2X3QgcWlkOzxicj4NCkBAIC0zMjQsMTMgKzQzMiwzNiBAQCBwZHVtcF9yZWdpc3Rl
cl90eF9jYWxsYmFja3MoZW51bSBwZHVtcF92ZXJzaW9uIHZlciw8YnI+DQrCoCDCoCDCoCDCoCBx
aWQgPSAocXVldWUgPT0gUlRFX1BEVU1QX0FMTF9RVUVVRVMpID8gMCA6IHF1ZXVlOzxicj4NCsKg
IMKgIMKgIMKgIGZvciAoOyBxaWQgJmx0OyBlbmRfcTsgcWlkKyspIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzdHJ1Y3QgcGR1bXBfcnh0eF9jYnMgKmNicyA9ICZhbXA7dHhfY2JzW3Bv
cnRdW3FpZF07PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHBkdW1wX3NoYXJl
ZF9jdGwgKmN0bCA9ICZhbXA7cGR1bXBfc3RhdHMtJmd0O3R4X2N0bFtwb3J0XVtxaWRdOzxicj4N
Cjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChvcGVyYXRpb24gPT0gRU5BQkxFKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50IHJldDs8YnI+DQor
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGNicy0mZ3Q7Y2Ip
IHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQ
RFVNUF9MT0dfTElORShFUlIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7dHggY2FsbGJhY2sgZm9yIHBvcnQ9JWQg
cXVldWU9JWQsIGFscmVhZHkgZXhpc3RzJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcnQsIHFpZCk7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1F
RVhJU1Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKGNicy0mZ3Q7Z2VuZXJhdGlvbiA9PSBnZW5lcmF0aW9uICZhbXA7JmFtcDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVf
YXRvbWljX2xvYWRfZXhwbGljaXQoJmFtcDtjdGwtJmd0O2VuYWJsZWQsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cnRlX21lbW9yeV9vcmRlcl9yZWxheGVkKSAhPSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUERVTVBfTE9HX0xJTkUo
RVJSLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O3R4IGNhbGxiYWNrIGZvciBwb3J0PSVkIHF1
ZXVlPSVkLCBhbHJlYWR5IGV4aXN0cyZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwb3J0LCBx
aWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiAtRUVYSVNUOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUERVTVBfTE9HX0xJTkUoREVCVUcsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgJnF1b3Q7cmVjb25jaWxpbmcgc3RhbGUgdHggY2FsbGJhY2sgZm9yIHBvcnQ9JWQgcXVldWU9
JWQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmcXVvdDsgb2xkX2dlbj0ldSBuZXdfZ2VuPSV1JnF1b3Q7LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHBvcnQsIHFpZCwgY2JzLSZndDtnZW5lcmF0aW9uLCBnZW5lcmF0aW9uKTs8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0g
cnRlX2V0aF9yZW1vdmVfdHhfY2FsbGJhY2socG9ydCwgcWlkLCBjYnMtJmd0O2NiKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0ICZs
dDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFBEVU1QX0xPR19MSU5FKEVSUiw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAm
cXVvdDtmYWlsZWQgdG8gcmVjb25jaWxlIHN0YWxlIHR4IGNhbGxiYWNrLCBlcnJubz0lZCZxdW90
Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtcmV0KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGR1bXBf
Y2Jfd2FpdChjYnMpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNicy0mZ3Q7Y2IgPSBOVUxMOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
YnMtJmd0O3VzZV9jb3VudCA9IDA7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgY2JzLSZndDt2ZXIgPSB2ZXI7PGJyPg0KQEAgLTMzOCw2ICs0NjksNyBAQCBwZHVtcF9y
ZWdpc3Rlcl90eF9jYWxsYmFja3MoZW51bSBwZHVtcF92ZXJzaW9uIHZlciw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYnMtJmd0O21wID0gbXA7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2JzLSZndDtzbmFwbGVuID0gc25hcGxlbjs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYnMtJmd0O2ZpbHRlciA9
IGZpbHRlcjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYnMtJmd0
O2dlbmVyYXRpb24gPSBnZW5lcmF0aW9uOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGNicy0mZ3Q7Y2IgPSBydGVfZXRoX2FkZF90eF9jYWxsYmFjayhwb3J0
LCBxaWQsIHBkdW1wX3R4LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGNicyk7PGJyPg0KQEAgLTM0NywxMCArNDc5LDE1IEBAIHBkdW1wX3JlZ2lzdGVyX3R4X2Nh
bGxiYWNrcyhlbnVtIHBkdW1wX3ZlcnNpb24gdmVyLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJ0ZV9lcnJubyk7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJ0
ZV9lcnJubzs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9hdG9taWNfc3Rv
cmVfZXhwbGljaXQoJmFtcDtjdGwtJmd0O2luZmxpZ2h0LCAwLCBydGVfbWVtb3J5X29yZGVyX3Jl
bGF4ZWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9hdG9t
aWNfc3RvcmVfZXhwbGljaXQoJmFtcDtjdGwtJmd0O2VuYWJsZWQsIDEsIHJ0ZV9tZW1vcnlfb3Jk
ZXJfcmVsZWFzZSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbWVt
c2V0KCZhbXA7cGR1bXBfc3RhdHMtJmd0O3R4W3BvcnRdW3FpZF0sIDAsIHNpemVvZihzdHJ1Y3Qg
cnRlX3BkdW1wX3N0YXRzKSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIGlm
IChvcGVyYXRpb24gPT0gRElTQUJMRSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGludCByZXQ7PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcnRlX2F0b21pY19zdG9yZV9leHBsaWNpdCgmYW1wO2N0bC0mZ3Q7ZW5hYmxlZCwg
MCwgcnRlX21lbW9yeV9vcmRlcl9yZWxlYXNlKTs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGNicy0mZ3Q7Y2IgPT0gTlVMTCkgezxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBEVU1QX0xPR19MSU5F
KEVSUiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmcXVvdDtubyBleGlzdGluZyB0eCBjYWxsYmFjayBmb3IgcG9ydD0lZCBx
dWV1ZT0lZCZxdW90Oyw8YnI+DQpAQCAtMzU5LDYgKzQ5NiwxMSBAQCBwZHVtcF9yZWdpc3Rlcl90
eF9jYWxsYmFja3MoZW51bSBwZHVtcF92ZXJzaW9uIHZlciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmV0ID0gcnRlX2V0aF9yZW1vdmVfdHhfY2FsbGJhY2socG9ydCwgcWlkLCBjYnMtJmd0
O2NiKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmV0ICZs
dDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoC8qIEtlZXAgc3RhdGUgY29oZXJlbnQ6IGNhbGxiYWNrIGlzIHN0aWxsIHJlZ2lzdGVyZWQs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICog
c28gcmVzdG9yZSBlbmFibGVkLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJ0ZV9hdG9taWNfc3RvcmVfZXhwbGljaXQoJmFtcDtjdGwtJmd0O2Vu
YWJsZWQsIDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX21lbW9yeV9vcmRlcl9yZWxlYXNlKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQRFVN
UF9MT0dfTElORShFUlIsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7ZmFpbGVkIHRvIHJlbW92ZSB0eCBjYWxsYmFj
aywgZXJybm89JWQmcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLXJldCk7PGJyPg0KQEAgLTM2Nyw2ICs1MDksMTAg
QEAgcGR1bXBfcmVnaXN0ZXJfdHhfY2FsbGJhY2tzKGVudW0gcGR1bXBfdmVyc2lvbiB2ZXIsPGJy
Pg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGR1bXBfY2Jfd2Fp
dChjYnMpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNicy0mZ3Q7
Y2IgPSBOVUxMOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXQgPSBwZHVtcF93YWl0X2luZmxpZ2h0KGN0bCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCkBAIC00NTksNyAr
NjA1LDggQEAgc2V0X3BkdW1wX3J4dHhfY2JzKGNvbnN0IHN0cnVjdCBwZHVtcF9yZXF1ZXN0ICpw
KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVuZF9xID0gKHF1ZXVlID09IFJURV9QRFVN
UF9BTExfUVVFVUVTKSA/IG5iX3J4X3EgOiBxdWV1ZSArIDE7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcmV0ID0gcGR1bXBfcmVnaXN0ZXJfcnhfY2FsbGJhY2tzKHAtJmd0O3ZlciwgZW5k
X3EsIHBvcnQsIHF1ZXVlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJpbmcsIG1wLCBmaWx0ZXIs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb3BlcmF0aW9uLCBwLSZndDtzbmFwbGVuKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBvcGVyYXRpb24sIHAtJmd0O3NuYXBsZW4sPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcC0mZ3Q7Z2VuZXJhdGlvbik7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aWYgKHJldCAmbHQ7IDApPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cmV0dXJuIHJldDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KQEAgLTQ2OSw3ICs2MTYsOCBAQCBz
ZXRfcGR1bXBfcnh0eF9jYnMoY29uc3Qgc3RydWN0IHBkdW1wX3JlcXVlc3QgKnApPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZW5kX3EgPSAocXVldWUgPT0gUlRFX1BEVU1QX0FMTF9RVUVV
RVMpID8gbmJfdHhfcSA6IHF1ZXVlICsgMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXQgPSBwZHVtcF9yZWdpc3Rlcl90eF9jYWxsYmFja3MocC0mZ3Q7dmVyLCBlbmRfcSwgcG9ydCwg
cXVldWUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmluZywgbXAsIGZpbHRlciw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBvcGVyYXRpb24sIHAtJmd0O3NuYXBsZW4pOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG9wZXJhdGlvbiwgcC0mZ3Q7c25hcGxlbiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBw
LSZndDtnZW5lcmF0aW9uKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmV0ICZs
dDsgMCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gcmV0
Ozxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQpAQCAtNDc3LDEyICs2MjUsMTQgQEAgc2V0X3BkdW1w
X3J4dHhfY2JzKGNvbnN0IHN0cnVjdCBwZHVtcF9yZXF1ZXN0ICpwKTxicj4NCsKgIMKgIMKgIMKg
IHJldHVybiByZXQ7PGJyPg0KwqB9PGJyPg0KPGJyPg0KLXN0YXRpYyB2b2lkPGJyPg0KLXBkdW1w
X3JlcXVlc3RfdG9fc2Vjb25kYXJ5KGNvbnN0IHN0cnVjdCBwZHVtcF9yZXF1ZXN0ICpyZXEpPGJy
Pg0KK3N0YXRpYyBpbnQ8YnI+DQorcGR1bXBfcmVxdWVzdF90b19zZWNvbmRhcnlfc3luYyhjb25z
dCBzdHJ1Y3QgcGR1bXBfcmVxdWVzdCAqcmVxKTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIHN0
cnVjdCBydGVfbXBfbXNnIG1wX3JlcSA9IHsgfTs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgcnRl
X21wX3JlcGx5IG1wX3JlcGx5Ozxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCB0aW1lc3BlYyB0cyA9
IHsudHZfc2VjID0gTVBfVElNRU9VVF9TLCAudHZfbnNlYyA9IDB9Ozxicj4NCivCoCDCoCDCoCDC
oGludCByZXQgPSAwOzxicj4NCivCoCDCoCDCoCDCoHVpbnQxNl90IGk7PGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgUERVTVBfTE9HX0xJTkUoREVCVUcsICZxdW90O2ZvcndhcmQgcmVxICVzIHRvIHNl
Y29uZGFyeSZxdW90OywgcGR1bXBfb3BuYW1lKHJlcS0mZ3Q7b3ApKTs8YnI+DQo8YnI+DQpAQCAt
NDkwLDE0ICs2NDAsNDEgQEAgcGR1bXBfcmVxdWVzdF90b19zZWNvbmRhcnkoY29uc3Qgc3RydWN0
IHBkdW1wX3JlcXVlc3QgKnJlcSk8YnI+DQrCoCDCoCDCoCDCoCBzdHJsY3B5KDxhIGhyZWY9Imh0
dHA6Ly9tcF9yZXEubmFtZSIgcmVsPSJub3JlZmVycmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2Js
YW5rIj5tcF9yZXEubmFtZTwvYT4sIFBEVU1QX01QLCBzaXplb2YoPGEgaHJlZj0iaHR0cDovL21w
X3JlcS5uYW1lIiByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPm1w
X3JlcS5uYW1lPC9hPikpOzxicj4NCsKgIMKgIMKgIMKgIG1wX3JlcS5sZW5fcGFyYW0gPSBzaXpl
b2YoKnJlcSk7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJ0ZV9tcF9yZXF1ZXN0X3N5bmMo
JmFtcDttcF9yZXEsICZhbXA7bXBfcmVwbHksICZhbXA7dHMpICE9IDApPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgUERVTVBfTE9HX0xJTkUoRVJSLCAmcXVvdDtydGVfbXBfcmVxdWVzdF9z
eW5jIGZhaWxlZCZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJ0ZV9tcF9yZXF1ZXN0X3N5
bmNfZXgoJmFtcDttcF9yZXEsICZhbXA7bXBfcmVwbHksICZhbXA7dHMsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01QX1JFUV9G
X0lHTk9SRV9OT19BQ1RJT04pICE9IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQ
RFVNUF9MT0dfTElORShFUlIsICZxdW90O3J0ZV9tcF9yZXF1ZXN0X3N5bmMgZmFpbGVkOiAlcyZx
dW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
dHJlcnJvcihydGVfZXJybm8pKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
LXJ0ZV9lcnJubzs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgZWxz
ZSBpZiAobXBfcmVwbHkubmJfc2VudCAhPSBtcF9yZXBseS5uYl9yZWNlaXZlZCk8YnI+DQorwqAg
wqAgwqAgwqBpZiAobXBfcmVwbHkubmJfc2VudCAhPSBtcF9yZXBseS5uYl9yZWNlaXZlZCkgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBEVU1QX0xPR19MSU5FKEVSUiwgJnF1b3Q7bm90
IGFsbCBzZWNvbmRhcnkmIzM5O3MgcmVwbGllZCAoc2VudCAldSByZWN2ICV1KSZxdW90Oyw8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1wX3JlcGx5
Lm5iX3NlbnQsIG1wX3JlcGx5Lm5iX3JlY2VpdmVkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXQgPSAtRVRJTUVET1VUOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IG1wX3JlcGx5Lm5iX3JlY2VpdmVkOyBpKyspIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX21wX21zZyAqbXBfcmVwID0g
JmFtcDttcF9yZXBseS5tc2dzW2ldOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0
IHN0cnVjdCBwZHVtcF9yZXNwb25zZSAqcmVzcDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKG1wX3JlcC0mZ3Q7bGVuX3BhcmFtICE9IHNpemVvZigqcmVzcCkpIHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQRFVNUF9MT0dfTElORShFUlIs
ICZxdW90O2ludmFsaWQgc2Vjb25kYXJ5IHJlcGx5IHNpemUgJXUmcXVvdDssIG1wX3JlcC0mZ3Q7
bGVuX3BhcmFtKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
cmV0ID09IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0ID0gLUVJTlZBTDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjb250aW51ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3AgPSAoY29uc3Qgc3RydWN0IHBkdW1wX3Jlc3Bv
bnNlICopbXBfcmVwLSZndDtwYXJhbTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
cmVzcC0mZ3Q7ZXJyX3ZhbHVlICE9IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBQRFVNUF9MT0dfTElORShFUlIsICZxdW90O3NlY29uZGFyeSByZXBseSBmYWls
ZWQ6IG9wPSV1IGVycj0lZCZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVzcC0mZ3Q7cmVzX29wLCByZXNwLSZndDtl
cnJfdmFsdWUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChy
ZXQgPT0gMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXQgPSByZXNwLSZndDtlcnJfdmFsdWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfTxicj4NCivCoCDCoCDCoCDCoH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBmcmVlKG1wX3Jl
cGx5Lm1zZ3MpOzxicj4NCivCoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KwqB9PGJyPg0KPGJy
Pg0KwqAvKiBBbGxvY2F0ZSB0ZW1wb3Jhcnkgc3RvcmFnZSBmb3IgcGFzc2luZyBzdGF0ZSB0byB0
aGUgYWxhcm0gdGhyZWFkIGZvciBkZWZlcnJlZCBoYW5kbGluZyAqLzxicj4NCkBAIC01NTYsNyAr
NzMzLDEwIEBAIHBkdW1wX2hhbmRsZV9wcmltYXJ5X3JlcXVlc3QoY29uc3Qgc3RydWN0IHJ0ZV9t
cF9tc2cgKm1wX21zZywgY29uc3Qgdm9pZCAqcGVlcik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBQRFVNUF9MT0dfTElORShERUJVRywgJnF1b3Q7c2Vjb25kYXJ5IHBkdW1wICVzJnF1b3Q7
LCBwZHVtcF9vcG5hbWUocmVxLSZndDtvcCkpOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIC8qIENhbiBqdXN0IGRvIGl0IG5vdywgbm8gbmVlZCBmb3IgaW50ZXJydXB0IHRocmVh
ZCAqLzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IHNldF9wZHVtcF9yeHR4X2Ni
cyhyZXEpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXEtJmd0O29wID09IEVO
QUJMRSB8fCByZXEtJmd0O29wID09IERJU0FCTEUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0ID0gc2V0X3BkdW1wX3J4dHhfY2JzKHJlcSk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZWxzZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldCA9IC1FSU5WQUw7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIHJldHVybiBwZHVtcF9zZW5kX3Jlc3BvbnNlKHJlcSwgcmV0LCBwZWVyKTs8YnI+DQpA
QCAtNTY5LDE3ICs3NDksMjkgQEAgX19wZHVtcF9yZXF1ZXN0KHZvaWQgKnBhcmFtKTxicj4NCsKg
ezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBwZHVtcF9idW5kbGUgKmJ1bmRsZSA9IHBhcmFtOzxi
cj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBydGVfbXBfbXNnICptc2cgPSAmYW1wO2J1bmRsZS0mZ3Q7
bXNnOzxicj4NCi3CoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBwZHVtcF9yZXF1ZXN0ICpyZXEgPTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChjb25zdCBzdHJ1Y3QgcGR1bXBfcmVxdWVzdCAq
KW1zZy0mZ3Q7cGFyYW07PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHBkdW1wX3JlcXVlc3QgKnJl
cSA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0cnVjdCBwZHVtcF9yZXF1ZXN0ICop
bXNnLSZndDtwYXJhbTs8YnI+DQrCoCDCoCDCoCDCoCBpbnQgcmV0Ozxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIFBEVU1QX0xPR19MSU5FKERFQlVHLCAmcXVvdDtwcmltYXJ5IHBkdW1wICVzJnF1b3Q7
LCBwZHVtcF9vcG5hbWUocmVxLSZndDtvcCkpOzxicj4NCjxicj4NCivCoCDCoCDCoCDCoGlmIChy
ZXEtJmd0O29wID09IERJU0FCTEUpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXEt
Jmd0O2dlbmVyYXRpb24gPSBydGVfYXRvbWljX2ZldGNoX2FkZF9leHBsaWNpdCgmYW1wO3BkdW1w
X3N0YXRzLSZndDtnZW5lcmF0aW9uLCAxLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBydGVfbWVtb3J5X29yZGVyX2FjcV9yZWwpICsgMTs8YnI+DQorwqAgwqAgwqAgwqB9IGVs
c2UgaWYgKHJlcS0mZ3Q7b3AgPT0gRU5BQkxFKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmVxLSZndDtnZW5lcmF0aW9uID0gcnRlX2F0b21pY19sb2FkX2V4cGxpY2l0KCZhbXA7cGR1
bXBfc3RhdHMtJmd0O2dlbmVyYXRpb24sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJ0ZV9tZW1vcnlfb3JkZXJfYWNxdWlyZSk7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8
YnI+DQrCoCDCoCDCoCDCoCByZXQgPSBzZXRfcGR1bXBfcnh0eF9jYnMocmVxKTs8YnI+DQo8YnI+
DQotwqAgwqAgwqAgwqAvKiBQcmltYXJ5IHByb2Nlc3MgaXMgcmVzcG9uc2libGUgZm9yIGJyb2Fk
Y2FzdGluZyByZXF1ZXN0IHRvIGFsbCBzZWNvbmRhcmllcyAqLzxicj4NCivCoCDCoCDCoCDCoC8q
PGJyPg0KK8KgIMKgIMKgIMKgICogUHJpbWFyeSBwcm9jZXNzIGlzIHJlc3BvbnNpYmxlIGZvciBi
cm9hZGNhc3RpbmcgdGhlIHJlcXVlc3QgdG8gYWxsPGJyPg0KK8KgIMKgIMKgIMKgICogc2Vjb25k
YXJpZXMuIFRoZSBzeW5jIHJlcXVlc3QgdXNlcyBvcHQtaW4gaWdub3JlLW1pc3NpbmctYWN0aW9u
IG1vZGUgc288YnI+DQorwqAgwqAgwqAgwqAgKiBwZHVtcCBkb2VzIG5vdCBkZXBlbmQgb24gdW5y
ZWxhdGVkIHNlY29uZGFyeSBwcm9jZXNzZXMuPGJyPg0KK8KgIMKgIMKgIMKgICovPGJyPg0KwqAg
wqAgwqAgwqAgaWYgKHJldCA9PSAwKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBkdW1w
X3JlcXVlc3RfdG9fc2Vjb25kYXJ5KHJlcSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0ID0gcGR1bXBfcmVxdWVzdF90b19zZWNvbmRhcnlfc3luYyhyZXEpOzxicj4NCjxicj4NCsKg
IMKgIMKgIMKgIHBkdW1wX3NlbmRfcmVzcG9uc2UocmVxLCByZXQsIGJ1bmRsZS0mZ3Q7cGVlcik7
PGJyPg0KwqAgwqAgwqAgwqAgZnJlZShidW5kbGUpOzxicj4NCkBAIC02NTksNiArODUxLDkgQEAg
cnRlX3BkdW1wX2luaXQodm9pZCk8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBwZHVtcF9zdGF0cyA9
IG16LSZndDthZGRyOzxicj4NCsKgIMKgIMKgIMKgIHBkdW1wX3N0YXRzLSZndDtteiA9IG16Ozxi
cj4NCivCoCDCoCDCoCDCoGlmIChydGVfZWFsX3Byb2Nlc3NfdHlwZSgpID09IFJURV9QUk9DX1BS
SU1BUlkpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2F0b21pY19zdG9yZV9leHBs
aWNpdCgmYW1wO3BkdW1wX3N0YXRzLSZndDtnZW5lcmF0aW9uLCAxLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9t
ZW1vcnlfb3JkZXJfcmVsZWFzZSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJuIDA7PGJy
Pg0KwqB9PGJyPg0KZGlmZiAtLWdpdCBhL2xpYi9wZHVtcC9ydGVfcGR1bXAuaCBiL2xpYi9wZHVt
cC9ydGVfcGR1bXAuaDxicj4NCmluZGV4IDFlMzJkNDYwOTcuLjc3ZTU5MTQ0MjAgMTAwNjQ0PGJy
Pg0KLS0tIGEvbGliL3BkdW1wL3J0ZV9wZHVtcC5oPGJyPg0KKysrIGIvbGliL3BkdW1wL3J0ZV9w
ZHVtcC5oPGJyPg0KQEAgLTY0LDcgKzY0LDcgQEAgcnRlX3BkdW1wX3VuaW5pdCh2b2lkKTs8YnI+
DQrCoCAqwqAgcXVldWVzIG9mIGEgZ2l2ZW4gcG9ydC48YnI+DQrCoCAqIEBwYXJhbSBmbGFnczxi
cj4NCsKgICrCoCBmbGFncyBzcGVjaWZpZXMgUlRFX1BEVU1QX0ZMQUdfUlgvUlRFX1BEVU1QX0ZM
QUdfVFgvUlRFX1BEVU1QX0ZMQUdfUlhUWDxicj4NCi0gKsKgIG9uIHdoaWNoIHBhY2tldCBjYXB0
dXJpbmcgc2hvdWxkIGJlIGVuYWJsZWQgZm9yIGEgZ2l2ZW4gcG9ydCBhbmQgcXVldWUuPGJyPg0K
KyAqwqAgb24gd2hpY2ggcGFja2V0IGNhcHR1cmluZyBzaG91bGQgYmUgZGlzYWJsZWQgZm9yIGEg
Z2l2ZW4gcG9ydCBhbmQgcXVldWUuPGJyPg0KwqAgKiBAcGFyYW0gcmluZzxicj4NCsKgICrCoCBy
aW5nIG9uIHdoaWNoIGNhcHR1cmVkIHBhY2tldHMgd2lsbCBiZSBlbnF1ZXVlZCBmb3IgdXNlci48
YnI+DQrCoCAqIEBwYXJhbSBtcDxicj4NCkBAIC03Miw2ICs3MiwxMSBAQCBydGVfcGR1bXBfdW5p
bml0KHZvaWQpOzxicj4NCsKgICogQHBhcmFtIGZpbHRlcjxicj4NCsKgICrCoCBVbnVzZWQgc2hv
dWxkIGJlIE5VTEwuPGJyPg0KwqAgKjxicj4NCisgKiBAbm90ZTxicj4NCisgKsKgIEluIGFwcGxp
Y2F0aW9ucyB0aGF0IGVuYWJsZSBjYXB0dXJlIG9uIG11bHRpcGxlIGludGVyZmFjZXMsIGVuYWJs
ZSBtYXkgYmU8YnI+DQorICrCoCBwYXJ0aWFsbHkgYXBwbGllZCBiZWZvcmUgYW4gZXJyb3IgaXMg
cmV0dXJuZWQuIENhbGxlcnMgc2hvdWxkIGV4cGxpY2l0bHk8YnI+DQorICrCoCB1bndpbmQgcGFy
dGlhbCBlbmFibGUgc3RhdGUuPGJyPg0KKyAqPGJyPg0KwqAgKiBAcmV0dXJuPGJyPg0KwqAgKsKg
IMKgIDAgb24gc3VjY2VzcywgLTEgb24gZXJyb3IsIHJ0ZV9lcnJubyBpcyBzZXQgYWNjb3JkaW5n
bHkuPGJyPg0KwqAgKi88YnI+DQpAQCAtMTAzLDYgKzEwOCwxMSBAQCBydGVfcGR1bXBfZW5hYmxl
KHVpbnQxNl90IHBvcnQsIHVpbnQxNl90IHF1ZXVlLCB1aW50MzJfdCBmbGFncyw8YnI+DQrCoCAq
IEBwYXJhbSBwcm08YnI+DQrCoCAqwqAgVXNlIEJQRiBwcm9ncmFtIHRvIHJ1biB0byBmaWx0ZXIg
cGFja2VzIChjYW4gYmUgTlVMTCk8YnI+DQrCoCAqPGJyPg0KKyAqIEBub3RlPGJyPg0KKyAqwqAg
SW4gYXBwbGljYXRpb25zIHRoYXQgZW5hYmxlIGNhcHR1cmUgb24gbXVsdGlwbGUgaW50ZXJmYWNl
cywgZW5hYmxlIG1heSBiZTxicj4NCisgKsKgIHBhcnRpYWxseSBhcHBsaWVkIGJlZm9yZSBhbiBl
cnJvciBpcyByZXR1cm5lZC4gQ2FsbGVycyBzaG91bGQgZXhwbGljaXRseTxicj4NCisgKsKgIHVu
d2luZCBwYXJ0aWFsIGVuYWJsZSBzdGF0ZS48YnI+DQorICo8YnI+DQrCoCAqIEByZXR1cm48YnI+
DQrCoCAqwqAgwqAgMCBvbiBzdWNjZXNzLCAtMSBvbiBlcnJvciwgcnRlX2Vycm5vIGlzIHNldCBh
Y2NvcmRpbmdseS48YnI+DQrCoCAqLzxicj4NCkBAIC0xMjQsNyArMTM0LDE0IEBAIHJ0ZV9wZHVt
cF9lbmFibGVfYnBmKHVpbnQxNl90IHBvcnRfaWQsIHVpbnQxNl90IHF1ZXVlLDxicj4NCsKgICrC
oCBxdWV1ZXMgb2YgYSBnaXZlbiBwb3J0Ljxicj4NCsKgICogQHBhcmFtIGZsYWdzPGJyPg0KwqAg
KsKgIGZsYWdzIHNwZWNpZmllcyBSVEVfUERVTVBfRkxBR19SWC9SVEVfUERVTVBfRkxBR19UWC9S
VEVfUERVTVBfRkxBR19SWFRYPGJyPg0KLSAqwqAgb24gd2hpY2ggcGFja2V0IGNhcHR1cmluZyBz
aG91bGQgYmUgZW5hYmxlZCBmb3IgYSBnaXZlbiBwb3J0IGFuZCBxdWV1ZS48YnI+DQorICrCoCBv
biB3aGljaCBwYWNrZXQgY2FwdHVyaW5nIHNob3VsZCBiZSBkaXNhYmxlZCBmb3IgYSBnaXZlbiBw
b3J0IGFuZCBxdWV1ZS48YnI+DQorICo8YnI+DQorICogQG5vdGU8YnI+DQorICrCoCBBIGRpc2Fi
bGUgZmFpbHVyZSAoaW5jbHVkaW5nIHRpbWVvdXQvbm8gcmVzcG9uc2UpIG1lYW5zIHRlYXJkb3du
IGlzIG5vdDxicj4NCisgKsKgIGNvbXBsZXRlIGFjcm9zcyBwZHVtcC1lbmFibGVkIHBlZXJzLiBU
aGUgY2FsbGVyIG11c3Qgbm90IHJlbGVhc2Ugc2hhcmVkPGJyPg0KKyAqwqAgcGR1bXAgcmVzb3Vy
Y2VzIGFuZCBtdXN0IG5vdCB1bmluaXRpYWxpemUgcGR1bXAgZm9yIHRoYXQgY2FwdHVyZSBzZXNz
aW9uPGJyPg0KKyAqwqAgdW50aWwgZGlzYWJsZSBzdWNjZWVkcy4gUmVsZWFzaW5nIHJlc291cmNl
cyBvbiBkaXNhYmxlIGZhaWx1cmUgY2FuIGxlYWQgdG88YnI+DQorICrCoCBjcmFzaGVzIGluIHBl
ZXIgcHJvY2Vzc2VzIHN0aWxsIGFjY2Vzc2luZyB0aG9zZSByZXNvdXJjZXMuPGJyPg0KwqAgKjxi
cj4NCsKgICogQHJldHVybjxicj4NCsKgICrCoCDCoCAwIG9uIHN1Y2Nlc3MsIC0xIG9uIGVycm9y
LCBydGVfZXJybm8gaXMgc2V0IGFjY29yZGluZ2x5Ljxicj4NCkBAIC0xNTMsNiArMTcwLDExIEBA
IHJ0ZV9wZHVtcF9kaXNhYmxlKHVpbnQxNl90IHBvcnQsIHVpbnQxNl90IHF1ZXVlLCB1aW50MzJf
dCBmbGFncyk7PGJyPg0KwqAgKiBAcGFyYW0gZmlsdGVyPGJyPg0KwqAgKsKgIHVudXNlZCBzaG91
bGQgYmUgTlVMTDxicj4NCsKgICo8YnI+DQorICogQG5vdGU8YnI+DQorICrCoCBJbiBhcHBsaWNh
dGlvbnMgdGhhdCBlbmFibGUgY2FwdHVyZSBvbiBtdWx0aXBsZSBpbnRlcmZhY2VzLCBlbmFibGUg
bWF5IGJlPGJyPg0KKyAqwqAgcGFydGlhbGx5IGFwcGxpZWQgYmVmb3JlIGFuIGVycm9yIGlzIHJl
dHVybmVkLiBDYWxsZXJzIHNob3VsZCBleHBsaWNpdGx5PGJyPg0KKyAqwqAgdW53aW5kIHBhcnRp
YWwgZW5hYmxlIHN0YXRlLjxicj4NCisgKjxicj4NCsKgICogQHJldHVybjxicj4NCsKgICrCoCDC
oCAwIG9uIHN1Y2Nlc3MsIC0xIG9uIGVycm9yLCBydGVfZXJybm8gaXMgc2V0IGFjY29yZGluZ2x5
Ljxicj4NCsKgICovPGJyPg0KQEAgLTE4Niw2ICsyMDgsMTEgQEAgcnRlX3BkdW1wX2VuYWJsZV9i
eV9kZXZpY2VpZChjaGFyICpkZXZpY2VfaWQsIHVpbnQxNl90IHF1ZXVlLDxicj4NCsKgICogQHBh
cmFtIGZpbHRlcjxicj4NCsKgICrCoCBVc2UgQlBGIHByb2dyYW0gdG8gcnVuIHRvIGZpbHRlciBw
YWNrZXMgKGNhbiBiZSBOVUxMKTxicj4NCsKgICo8YnI+DQorICogQG5vdGU8YnI+DQorICrCoCBJ
biBhcHBsaWNhdGlvbnMgdGhhdCBlbmFibGUgY2FwdHVyZSBvbiBtdWx0aXBsZSBpbnRlcmZhY2Vz
LCBlbmFibGUgbWF5IGJlPGJyPg0KKyAqwqAgcGFydGlhbGx5IGFwcGxpZWQgYmVmb3JlIGFuIGVy
cm9yIGlzIHJldHVybmVkLiBDYWxsZXJzIHNob3VsZCBleHBsaWNpdGx5PGJyPg0KKyAqwqAgdW53
aW5kIHBhcnRpYWwgZW5hYmxlIHN0YXRlLjxicj4NCisgKjxicj4NCsKgICogQHJldHVybjxicj4N
CsKgICrCoCDCoCAwIG9uIHN1Y2Nlc3MsIC0xIG9uIGVycm9yLCBydGVfZXJybm8gaXMgc2V0IGFj
Y29yZGluZ2x5Ljxicj4NCsKgICovPGJyPg0KQEAgLTIxMCw3ICsyMzcsMTQgQEAgcnRlX3BkdW1w
X2VuYWJsZV9icGZfYnlfZGV2aWNlaWQoY29uc3QgY2hhciAqZGV2aWNlX2lkLCB1aW50MTZfdCBx
dWV1ZSw8YnI+DQrCoCAqwqAgcXVldWVzIG9mIGEgZ2l2ZW4gZGV2aWNlIGlkLjxicj4NCsKgICog
QHBhcmFtIGZsYWdzPGJyPg0KwqAgKsKgIGZsYWdzIHNwZWNpZmllcyBSVEVfUERVTVBfRkxBR19S
WC9SVEVfUERVTVBfRkxBR19UWC9SVEVfUERVTVBfRkxBR19SWFRYPGJyPg0KLSAqwqAgb24gd2hp
Y2ggcGFja2V0IGNhcHR1cmluZyBzaG91bGQgYmUgZW5hYmxlZCBmb3IgYSBnaXZlbiBwb3J0IGFu
ZCBxdWV1ZS48YnI+DQorICrCoCBvbiB3aGljaCBwYWNrZXQgY2FwdHVyaW5nIHNob3VsZCBiZSBk
aXNhYmxlZCBmb3IgYSBnaXZlbiBwb3J0IGFuZCBxdWV1ZS48YnI+DQorICo8YnI+DQorICogQG5v
dGU8YnI+DQorICrCoCBBIGRpc2FibGUgZmFpbHVyZSAoaW5jbHVkaW5nIHRpbWVvdXQvbm8gcmVz
cG9uc2UpIG1lYW5zIHRlYXJkb3duIGlzIG5vdDxicj4NCisgKsKgIGNvbXBsZXRlIGFjcm9zcyBw
ZHVtcC1lbmFibGVkIHBlZXJzLiBUaGUgY2FsbGVyIG11c3Qgbm90IHJlbGVhc2Ugc2hhcmVkPGJy
Pg0KKyAqwqAgcGR1bXAgcmVzb3VyY2VzIGFuZCBtdXN0IG5vdCB1bmluaXRpYWxpemUgcGR1bXAg
Zm9yIHRoYXQgY2FwdHVyZSBzZXNzaW9uPGJyPg0KKyAqwqAgdW50aWwgZGlzYWJsZSBzdWNjZWVk
cy4gUmVsZWFzaW5nIHJlc291cmNlcyBvbiBkaXNhYmxlIGZhaWx1cmUgY2FuIGxlYWQgdG88YnI+
DQorICrCoCBjcmFzaGVzIGluIHBlZXIgcHJvY2Vzc2VzIHN0aWxsIGFjY2Vzc2luZyB0aG9zZSBy
ZXNvdXJjZXMuPGJyPg0KwqAgKjxicj4NCsKgICogQHJldHVybjxicj4NCsKgICrCoCDCoCAwIG9u
IHN1Y2Nlc3MsIC0xIG9uIGVycm9yLCBydGVfZXJybm8gaXMgc2V0IGFjY29yZGluZ2x5Ljxicj4N
Ci0tIDxicj4NCjIuNDMuMDxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj4NCg==
--0000000000003688f50655e151a4--
