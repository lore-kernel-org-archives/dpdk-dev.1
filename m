Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A3C53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 23:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C86540272;
	Thu, 30 Jul 2026 01:28:17 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id F37E940144
 for <dev@dpdk.org>; Thu, 30 Jul 2026 01:28:15 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso896892a12.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785367695;
 x=1785972495; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=91ZnM9IaVWT25q/LwusnSPZiLd2fxDOAq4GnxQm9i/s=;
 b=RXlMFO4nIU6RuCdcQWdT9Qn4stfINWoPwiKImfYLW98pBMNraMTU1lL5HZMeg22Q9i
 aQTpc04mFgodY0O+iy176ztLg1q7v54CFVrrr6/RJMOkQBqmdeUwfhuZeNq1CcV2N1fJ
 9Vx2C9XI2ePWka6CmTX2zZkHlo2OJqlj7/TvcZ4SwmYzftitjpNmwu9+4JnW3uhOruuh
 DsrAa1urRTG2CE4imyCZUiqHcbMNkIrPBmSml4fH8fdp9eKuUZvne9AEqJur0KJ7IHe8
 DBtFTPK9XdOdvERzukh+V+RKZMFcWwVvlNa202Mn/+2UVrtd9bpq62ZuXxNVeNsEVl0Q
 3FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785367695; x=1785972495;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=91ZnM9IaVWT25q/LwusnSPZiLd2fxDOAq4GnxQm9i/s=;
 b=L3FFB3PqPc9blQAdrGDfacnqPmHbG3DjJ5cZvoXoA/4EzIqI/zCIOCSYpda2HP3ZUJ
 UJvBp9dku/VdKREgFIqc32lHGHNtqoRhl6NJnBk0dtfwRJu89hu8fZJiq8nGj5LL9N+t
 qu4FeaI0yq6aech7XsZHN+s3EVd2mW/a7F8WyfSRzuPxA0nIRlm3TRP+KVshwTIoOOPB
 QnXI9EQ2jFvWLI2YHME+FBDhv8xgdU9zsGtI+gd5jWtZBqB657uYQejrgFjYvBnjYOBN
 oad8mcmJewdnGMjSVAQnK65ai/ncPv3ErR7J0i7FOnq36SszRelnYMcYp8AQ1bZ41k2N
 vCng==
X-Gm-Message-State: AOJu0Yw+0jwuD73+Cz1DSIHMnt/fyHpj68l+Lm92PYZrBHb3G6wmQsS/
 9fnr0u9c9cquez/k/VwXpxqRw0FzUvTS8UNLhbAAoAlpaMGM5rS6rrcEIIImapXjyRvn12myHJM
 +qEST
X-Gm-Gg: AR+sD11fzbOhNrZeBJGesHgv2T5yjyZN7O6vB1JWrErMdCsZ5i03mpVFk64sGINs1sY
 iH7Jj1eKaTPmtHHYZFhNLtj3JO11L9mtoA7zoprtS5Mrjzu9vLDYzLvPpic8MztfNVUPRj39JFd
 TI0QVrC2f+LVn2HUxL8yDIotlPrxrafQBiiHfGQikE2Jx/S/J7DQqIJEs0koLDLr6sbxmnIumG5
 wAuLZDv42M2zbv5ZSlYr9l763M6cyB9CSzGg1DZ/KVwCDLuQ9Yiy3CIYG4NZgJez8hjmB8WoE++
 Y/9mhkMPR/T889HIft36l901+kpenDSHhHNxyPUGaPnFO6WPSzokrWuua1lp52GKuWlsZs9uabE
 MgZaw8DEhXWfeKMsL7IiZfrWtSU2xqS4Iu4V2sRqjaQJ/Hb6iIwpqu7RABNK7qn18Lxneq9PFWp
 COEffhktTO6j5uldCrrPTYgXiu8NQ31+dfnDm3PS10/qfLD1M2dlN5x0sDWuPoseZHeXV59//1L
 RwNL+6gO7lwuvb42G9dFUooLoz7T40=
X-Received: by 2002:a05:6a20:729d:b0:3c3:9aff:7a5f with SMTP id
 adf61e73a8af0-3c9008d24f0mr84420637.43.1785367694735; 
 Wed, 29 Jul 2026 16:28:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b1246dsm12886411eec.2.2026.07.29.16.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 16:28:14 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:28:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH v2 4/4] usertools: add script for wireshark capture
Message-ID: <20260729162811.1d6340d6@phoenix.local>
In-Reply-To: <20260727224417.1419663-5-stephen@networkplumber.org>
References: <20260724212238.864798-1-stephen@networkplumber.org>
 <20260727224417.1419663-1-stephen@networkplumber.org>
 <20260727224417.1419663-5-stephen@networkplumber.org>
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

On Mon, 27 Jul 2026 15:42:47 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Provide glue script that wireshark can use to access
> telemetry based packet capture. It is dual licensed because
> it maybe desirable to put this in wireshark repository.
> 
> See https://www.wireshark.org/docs/man-pages/extcap.html
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Recheck-request: iol-unit-arm64-testing
