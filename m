Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE8C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 09:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0763402E0;
	Wed,  1 Jul 2026 11:47:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AB99D40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 11:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782899241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmzOfa0U+akAte8Tmz5OxeYbV/RNxdbgpzxykrY6BfU=;
 b=AcRb4EXeDc6ws37LtfNDKTilGVwHaGEuMrP5HPltlzVLu1wH+NY/XNQmCtyMqoMedVupML
 flbG3/F6w4tnmHXbyao4SMl5nkBb2iorpAyZUF7HSRm2SMtlZ6BU3hHyvn9L5OaqY7P6HP
 Dl8LFcFMZwnNFDZL7lxhsSB/SGPdt/A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-8ksMOf-6O8m_3kaj0iRUsg-1; Wed, 01 Jul 2026 05:47:20 -0400
X-MC-Unique: 8ksMOf-6O8m_3kaj0iRUsg-1
X-Mimecast-MFC-AGG-ID: 8ksMOf-6O8m_3kaj0iRUsg_1782899238
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-399c5ee9eeeso2688031fa.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 02:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782899238; x=1783504038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmzOfa0U+akAte8Tmz5OxeYbV/RNxdbgpzxykrY6BfU=;
 b=RVkzuXg24/DBBuCqiPCMFuTxVhFfyBsk6L5Bcdy2z3ykgOURkRUFF/SB6//BAQQrxh
 pB5EEBFX183OACOfqajLqwxtoggJhlwlRt0wqfjFM1vB4MHb1vZUQpMXAEtIWnSqLXp0
 KecLAnRrIlgj5XGtVj5GeDBqJC2SaNO9F3PvtP/O+JKx4SSwKFy0JXJrM6yGk89M4raq
 nDfRPuokOzkcuI2L5i/HMj4vaKNXQDWrW+3SOY2uHydWIXR01zIPVg7a+YlEIG9PIxVI
 PtKK+BEqlCxLRVxSnoSai7jGUZNlPaZb0LvhxoXzmNb9kMU5H0TSvaIIWWH/vtK939JN
 //Hw==
X-Gm-Message-State: AOJu0YzwuLQ+RI48ZB3HIXgKLtNrlZZomIy17ApAqEgAdBZ1OsrnD9Vq
 vOqo1JnPmSJIxXc0VeyCjus/w3bDzsTV+MqcUUuQ1RdEHShoHbVC1EaQDxkCSepjMiSdUv7lSBn
 R9RJOSXXGcXauCvFIvJmO5Anzl97/fSlA2Szjj5YLjU0Q3b90yCr+pwQBn4mTAgvx6uvL0yPjxx
 En8JYtIFl6pOmF2REAftk=
X-Gm-Gg: AfdE7clICsbUpz53AOUUXB3mGzHP/XshiBYBaWa9K31cNwbKPgFB0zHqKSAV/+Z/X8A
 lTNC8LJp45cHLN0+1QS0A9oqDuinH8TRtVNfyMBmTOHpayDiXKTsMo+I5KVfn+3YV0rVpy2qkT2
 Zuw4SR6t2oTTiL8WOOMXqjEm8x9W8MirVkgCgtD+dVTlWH4iOT1f7l3LJAwzqBnt9MuHQF2KhT/
 nT8bq0uOPIi0QZgK9qsTfXVBj3FW1+FNV2OG/DBmZj+tzNOZR0gdDDtg6g=
X-Received: by 2002:a2e:be0b:0:b0:396:76f9:ac7e with SMTP id
 38308e7fff4ca-39b340542c3mr1927151fa.18.1782899237823; 
 Wed, 01 Jul 2026 02:47:17 -0700 (PDT)
X-Received: by 2002:a2e:be0b:0:b0:396:76f9:ac7e with SMTP id
 38308e7fff4ca-39b340542c3mr1927001fa.18.1782899237300; Wed, 01 Jul 2026
 02:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1782469943.git.anatoly.burakov@intel.com>
 <c4564e3c9e7ad675c60655b80cac1a077ad24bb1.1782469943.git.anatoly.burakov@intel.com>
In-Reply-To: <c4564e3c9e7ad675c60655b80cac1a077ad24bb1.1782469943.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Jul 2026 11:47:05 +0200
X-Gm-Features: AVVi8CdZuevSRSYMLBhG3FqX5f14zIjS_WffyuAx29jHy6EWwAPduSVhRKEAuN4
Message-ID: <CAJFAV8wmRsznO6S6gz0cmnhAs+QHW1k=7oFo3DhR9--A-Myo5Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] eal: fix async IPC memory leaks on partial failure
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Jianfeng Tan <jianfeng.tan@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dYNRBl3-UIaUg39gTCZP3LWuWGf-dspRS3fkpDbsJaM_1782899238
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 26 Jun 2026 at 12:34, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> When rte_mp_request_async() fails to send requests to all peers,
> copy and param can lose ownership and leak.
>
> However, we cannot simply free them unconditionally, as "partial failure"
> means some requests were already queued and thus still reference `copy` and
> `param`, so freeing them directly on the error path can cause
> use-after-free when those requests are later handled by the async timeout.
>
> Fix this by rolling back queued requests from the current batch, and reset
> nb_sent to 0. Freeing the requests is now safe even if some requests were
> sent, as any responses or timeouts will not find the request ID in the
> queue and will safely exit without doing anything.
>
> Coverity issue: 501503
>
> Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  lib/eal/common/eal_common_proc.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
> index 991bf215a3..0cffc7a127 100644
> --- a/lib/eal/common/eal_common_proc.c
> +++ b/lib/eal/common/eal_common_proc.c
> @@ -1245,6 +1245,32 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
>                 } else if (mp_request_async(path, copy, param, ts))
>                         ret = -1;
>         }
> +
> +       /*
> +        * On partial failure, roll back all queued requests. We hold the lock
> +        * so no one else touches the queue. All requests in this batch share
> +        * the same param pointer. Stale alarms will fire and harmlessly find
> +        * nothing via ID-based lookup.
> +        */
> +       if (ret != 0 && reply->nb_sent > 0) {
> +               struct pending_request *r, *next;
> +
> +               for (r = TAILQ_FIRST(&pending_requests.requests);
> +                               r != NULL; r = next) {
> +                       next = TAILQ_NEXT(r, next);
> +                       if (r->type == REQUEST_TYPE_ASYNC &&
> +                                       r->async.param == param) {
> +                               TAILQ_REMOVE(&pending_requests.requests,
> +                                               r, next);
> +                               free(r->reply);
> +                               /* r->request == copy, freed below after the loop */
> +                               free(r);
> +                       }
> +               }
> +               /* requests on the queue were removed so keep things consistent */
> +               reply->nb_sent = 0;
> +       }
> +

Please, don't reimplement the safe macro.

I plan to update this with:

@@ -1252,15 +1252,11 @@ rte_mp_request_async(struct rte_mp_msg *req,
const struct timespec *ts,
         * nothing via ID-based lookup.
         */
        if (ret != 0 && reply->nb_sent > 0) {
-               struct pending_request *r, *next;
-
-               for (r = TAILQ_FIRST(&pending_requests.requests);
-                               r != NULL; r = next) {
-                       next = TAILQ_NEXT(r, next);
-                       if (r->type == REQUEST_TYPE_ASYNC &&
-                                       r->async.param == param) {
-                               TAILQ_REMOVE(&pending_requests.requests,
-                                               r, next);
+               struct pending_request *r, *tmp;
+
+               RTE_TAILQ_FOREACH_SAFE(r, &pending_requests.requests,
next, tmp) {
+                       if (r->type == REQUEST_TYPE_ASYNC &&
r->async.param == param) {
+
TAILQ_REMOVE(&pending_requests.requests, r, next);
                                free(r->reply);
                                /* r->request == copy, freed below
after the loop */
                                free(r);

Objection?
If not, I'll update while applying.


-- 
David Marchand

