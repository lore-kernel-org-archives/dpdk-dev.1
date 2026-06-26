Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4EBC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 13:28:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E38C9402F1;
	Sun, 28 Jun 2026 15:28:11 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 49384400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:04:45 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30b6dad2382so1529758eec.0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782461084; x=1783065884; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5Vs8TmTNXZ95nFMQfsrcAuKiQUMmY8GemCtNlHjOoU=;
 b=mGIpKPJN7gtPnK5lnKuK4mADRnM+9zkxOCwIIMNCEUO0qEbkhFBXcpMTogsH24RRfM
 45tsVWhlMZuQvd0UfxaUNmk6PQU5ZmhColKGcLZUUrkUyAJKIFNHCDn+De98c9OqbGdz
 Pgfl88pEeZEZhYl98abHqO34sMwdw7IcyFJOchjPG998w8UEi8mAG9avOPg3hheYoG0a
 FBZBdSDvCXyEIQ2r4iUMLVSICXQUWUWnWHoQwFMXgii25FJnLrEbjbdQVOpSVMKkMfSD
 hthVaU0werWphgIXk3t7KR29RJVNXrD0CKr4WtHX19DF0GnNE05w1gRetef0OhNZWUZX
 jZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782461084; x=1783065884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5Vs8TmTNXZ95nFMQfsrcAuKiQUMmY8GemCtNlHjOoU=;
 b=lQp5b6Tqy4QUlfg4TJ5LQ6jtlaQN2vDaFx0J/n1qdsklev2JjeXgKDkVP7Ed5y8C96
 zBuYBLgyr941lTCgcPWCPx9UbNscMwj9xegHuEusDR4yEYIcyt66OG/Lcmujv6mRaRbr
 Lzz87O5C49aEqXIBwgSBufKdyEui8C/3b9pRbZXPPHjcUxhlovRmr7jBBdwdYZxvf3UN
 InA68e4y1lY5oxacB883cZWr93B+YlUaf8s2jOhhPkn0eYqDAppd++qOvDyzI3869UvY
 gu37XTihZW7OR0XZYEYHQU9AC7w49dvNQj66oV49FPD79VCgXPoVmuF7uB0FXzc/Zy+p
 6YfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYDgnfs9sBa+jXGNH3Zq+QX7gJ5vznsm3Ogq0y9lthR9gdIFu+vaLzLZk4fMHjVMmsPA4=@dpdk.org
X-Gm-Message-State: AOJu0YxbrDwn0jFMg8zH+8qPfLsZpH450QIwyc1wVK+fGQdNm30HQWdg
 8NVDGL0q95bmhPWA0OkpYRxoF2o4hHgTdiGRiXc09792RMBqdl9f228Y
X-Gm-Gg: AfdE7ck8mKpUILwqvClSXo0A7dSfQlWvtQB52+JS3baco6CbE5XaByH5xxt5h2BDyzw
 3obpZpXGgAw0ocDA2IPL3/gvH1xkIZoMI9LepxJcC1pMvoFY84LacFeorORoQQFyg0dbmtNrAG7
 WaTggfUG66OM7d5T0J6yfRMXApHIWAj0pLVWP2PejhXZzbKWFOo+OlPfgzBuZ46L1FrFFySTZpi
 U1EZJhkAW8qNdnA4RKjpaUaOhmEZw1GfaVzhY8BugI5eaH11bZNAn32FC0aePSLNVvjUSG41T0q
 CLtGEljORyizGRT6bY3XrUEmcAezedK7i9LoPW6xUl0WtH+kSGTJ1QTIhCK+yQ4sHIaksWyNycT
 z1AJCeqVXqgHqVHWg3KuRR/Cdkapb3akE25P1JI2A3wMLJb/mlh5S41cVLuKDfqiJWATX6SiR25
 r8dm8SRovdEjeBh3AjCq8=
X-Received: by 2002:a05:7301:60c:b0:30b:e14e:b5e0 with SMTP id
 5a478bee46e88-30c84d9ba0dmr5741119eec.34.1782461084134; 
 Fri, 26 Jun 2026 01:04:44 -0700 (PDT)
Received: from dev-template-2404.. ([192.19.252.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm17297717eec.16.2026.06.26.01.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 01:04:43 -0700 (PDT)
From: samar yadav <samaryadav5@gmail.com>
X-Google-Original-From: samar yadav <ysamar@vmware.com>
To: stephen@networkplumber.org
Cc: chenbox@nvidia.com, dev@dpdk.org, maxime.coquelin@redhat.com,
 samaryadav5@gmail.com, stable@dpdk.org, tiwei.bie@intel.com
Subject: Re: [PATCH] net/virtio-user: fix eventfd sharing in secondary process
Date: Fri, 26 Jun 2026 08:04:15 +0000
Message-ID: <20260626080415.2370845-1-ysamar@vmware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081036.6c6c82e8@phoenix.local>
References: <20260624081036.6c6c82e8@phoenix.local>
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

On Wed, 24 Jun 2026 08:10:36 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> > +	pp = rte_zmalloc("virtio_user_proc_priv", sizeof(*pp), 0);
> > +	if (pp == NULL)
> > +		return -ENOMEM;
> > +
> > +	pp->kickfds = rte_malloc("virtio_user_proc_priv",
> > +				 total_queues * sizeof(int), 0);
> > +	pp->callfds = rte_malloc("virtio_user_proc_priv",
> > +				 total_queues * sizeof(int), 0);
>
> Better to use rte_calloc.

Agreed Stephen, will switch to rte_calloc in patch v2:

-	pp->kickfds = rte_malloc("virtio_user_proc_priv",
-				 total_queues * sizeof(int), 0);
-	pp->callfds = rte_malloc("virtio_user_proc_priv",
-				 total_queues * sizeof(int), 0);
+	pp->kickfds = rte_calloc("virtio_user_proc_priv",
+				 total_queues, sizeof(int), 0);
+	pp->callfds = rte_calloc("virtio_user_proc_priv",
+				 total_queues, sizeof(int), 0);


Samar Yadav
