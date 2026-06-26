Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9BEC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 13:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E430B40647;
	Sun, 28 Jun 2026 15:28:12 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 38B264025F
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:05:30 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-137eb0d76beso972429c88.0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782461129; x=1783065929; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAzDm8oPqfUGnA56NlcfuZ4o7fWufq3ulqX7CD9GI60=;
 b=UAGErVwDGiU6Gg49PY+rbdKw3dIElto/cRjQoFa8unpKzj22lfwPsjDba6NsIpiTaN
 DXbp+l8yn8LkPFcuwM/1WS/2r3aIFRlQ5KlffwhgBcm4PQ3VGWNpy0wvtNFvLrfxGE1Q
 th/YFWFTcpII+pGFd5p6NT50yIKPKq+Th7TJWiFeajjXitVlGzZy/rKtUKa68HE/8LIs
 1UuZSnEjbRHhou4tBTW9jAIXEfkUZk1wJ34ZHUOf9Uqp/kkgKtE8h79M5NgLB4BwMvAE
 dHOntxDEQM+pF2Qo3iFw4WIvvEgFvZ9p0zBC+qgOOCR5jlSeb/r1faHXDzdwQ8zHHZqj
 Gl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782461129; x=1783065929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XAzDm8oPqfUGnA56NlcfuZ4o7fWufq3ulqX7CD9GI60=;
 b=U7NL9hui6HBRt3pctFjTd0m3hx7xoSwAdK4X2sr6ypjqrH0F3tqQqEEukcc6+DGPs6
 YGRi7l52OSbYQvvL4prPGDBjf88ojbktsokI3rZJdY4xHxHEXrxrPL2egVWBpSLIG/ox
 nzKGfIo5hj+poUH9dF24F2VQfWegsZ/lYJrgVLdVl3ZjHJI8CEmpyaI+moZ8mFW8NZEp
 wv8saQd1pqXfT5AASQivjLOFxxhClAlxfdLF7dYhAyx5CZaYT3DMBdlOtwlESUlCX2YX
 /5oWJcRxpqYwmAGX1/ljdAyrSLGCRXks8/FdZl/Mcg+eal6/8jVPiG/FGgPGsWhIWF8q
 Vd3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QNgMNUvHMTCGVWGCVm6vQ0E+l9nl3Gud8LztSPWPc5JqDXY2lwSaZuifjSP3BrQs9U9U=@dpdk.org
X-Gm-Message-State: AOJu0Yxnh86zLbOkg26ifF103zqCRE7lDuJ8dQMuZBvkcCgTN9LGJhJa
 d4hpGrlCKi7C0RqV5VSJmipQYmrp9rlkZKT+sS70yb8rcDOc5gqQIAi1
X-Gm-Gg: AfdE7cmU2CHLlWpAhVQRACyMHrhhVZeleUZviaXhbx2/4aTWTam4cpRSV8rybcaWqQg
 7GOZFDSYk+6TApWTNQaNMYqsCVfFyXXJ9RoB8M+jslSXBDtjo27YTVwb6hDQrxVywKePET3k+wg
 hoK9ei3YZOK6qwjLzzCo7y4BCGOxr1lKRhkSb7TZQ+KT5qBtnkXe2WCdXST8by6wk4Qu43g78af
 nEiHrprLc/4xfsaDYt8dXWQUs9tc3ENWZwNxKKpKA2VGLpyYlVZn8pzulCtjG9wMZcHm5RrnhWr
 Hp9j/Vw2qOKhhUP2LAf5TNaTZNJZdmtf+LgrvzCJIxdf/NNt2GmwlMt1FMPxx6k5zVGu3gVLfNA
 SnGIZMFENvw3r9e2Hl3rlsYgB3CJ/qxGQCsOlSakRjs3Oqj9TI/HdwywfDwyLnqtwxyxkCnKC6I
 R2lOq7zlBUFIKvA4vn+9E=
X-Received: by 2002:a05:7022:f404:b0:138:4021:b20a with SMTP id
 a92af1059eb24-139c3c123f5mr11962221c88.3.1782461128818; 
 Fri, 26 Jun 2026 01:05:28 -0700 (PDT)
Received: from dev-template-2404.. ([192.19.252.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e42338f9sm3334421c88.0.2026.06.26.01.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 01:05:27 -0700 (PDT)
From: samar yadav <samaryadav5@gmail.com>
X-Google-Original-From: samar yadav <ysamar@vmware.com>
To: stephen@networkplumber.org
Cc: chenbox@nvidia.com, dev@dpdk.org, maxime.coquelin@redhat.com,
 samaryadav5@gmail.com, stable@dpdk.org, tiwei.bie@intel.com
Subject: Re: [PATCH] net/virtio-user: fix eventfd sharing in secondary process
Date: Fri, 26 Jun 2026 08:05:13 +0000
Message-ID: <20260626080513.2371033-1-ysamar@vmware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081610.780c4b0f@phoenix.local>
References: <20260624081610.780c4b0f@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jun 2026 15:28:09 +0200
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

On Wed, 24 Jun 2026 08:16:10 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> > +	/*
> > +	 * Serialize closing/freeing the kick/call fd arrays against the MP
> > +	 * handler, which reads them under the same lock to share them with
> > +	 * secondary processes.
> > +	 */
> > +	pthread_mutex_lock(&dev->mutex);
> >  	virtio_user_dev_uninit_notify(dev);
> > -
> >  	virtio_user_free_vrings(dev);
> > +	pthread_mutex_unlock(&dev->mutex);
>
> Related bug. virtio_user is not initializing mutex as safe between
> processes. See rte_thread_mutex_init_shared() vs pthread_mutex_init()

Agreed on the related pthread_mutex_init bug.
In this patch dev->mutex is only ever locked by the primary process:
the MP handler runs in the primary's EAL dispatch thread, and the
teardown path in virtio_user_dev_uninit() is primary-only. The
secondary communicates via rte_mp_request_sync() over the EAL socket
and never calls pthread_mutex_lock() on dev->mutex directly.

That said, POSIX requires PTHREAD_PROCESS_SHARED for a mutex stored in
shared memory regardless of which processes actually lock it, and other
DPDK multiprocess-aware code already uses rte_thread_mutex_init_shared()
 for shared-memory mutexes. The pthread_mutex_init(&dev->mutex, NULL) call predates this 
patch but since this patch explicitly documents the lock's role I will fix the
initialisation in v2:

-	pthread_mutex_init(&dev->mutex, NULL);
+	rte_thread_mutex_init_shared(&dev->mutex);

Samar Yadav
