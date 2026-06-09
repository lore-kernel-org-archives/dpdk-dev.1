Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACCCD8CAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F06F6402BE;
	Tue,  9 Jun 2026 10:42:42 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 92D704025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 10:42:41 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0F50014000E2;
 Tue,  9 Jun 2026 04:42:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 04:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780994561;
 x=1781080961; bh=4UBuFzUFC/XPxxEXHDx2qo8AJyXfbTRjjnRUym7xvWc=; b=
 bkQ1yeXxHgqWdublB4JkM15fFsoLNnTeKyfVuLpadW0YQI6xmsEO4kJjKfTt49zn
 nbpQQT6Cq6z81Muy9KKIV/elFXSHEBmX3Q4zbZz0JCTHLc8cypwLLelpsyDlevjc
 3nWdHIeZYimbGus+xAyFft8CpDKWeOQI2RBLmRIptwKG00t/oWwOWpI9eKxchWhQ
 ehq6h8jJHApijY0XjKW2ZccxUfiLr1w/JCOb6WvdDbeIwyw0lMcNVQBt6S4/pKEJ
 etSLfTfFk6I9n8lrJeZm1SIonqdoEuUoZtnlLWGQVTZDMdZdU2JcdBqm7Cw9J4g2
 q4F+wH0tsU/BR/IUXFwn4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780994561; x=
 1781080961; bh=4UBuFzUFC/XPxxEXHDx2qo8AJyXfbTRjjnRUym7xvWc=; b=G
 PFspBsgNQq+0ABJNsnmLWTnT9gjLOagmqcdH6Rfd89LIaJqWePAJqwQJtX/bUO9a
 5GyoY9JCQWFbOXRW4sJRQHY05Y0stcBJGTC7XOFiKgwSIELYqFJf3Cl0N17R6G67
 eqB47BEEOUMKkfcUr36g7izKXPukkVz7tju5U8Um1rk4fezzPzyY/4aOm/o4mRQp
 3fFjgB8HVeEGPCjNLGLGEkX8Rk7ZN4fG+e47d9MG2F3viY68DLOvV7seD21zNyjl
 XDaaDWYKKF+dnACXVaammO9vyABTqW8KDz1K9uinb1/3liYA+gwZsdY98ziYH0OA
 gIZx3x9Uc7qiwDu8iWSZw==
X-ME-Sender: <xms:ANInal9Uy-La73t_bYa_MkqYpICfn3WvHLq1Zbrg_ibobePV1BzGMA>
 <xme:ANInauAxjAVzmpQ1NxE2324KxjygxVM4kbTxs7LJ8j58GwmH4upVmEjcPy6UBgoFr
 YChdENqXRcDL5exmdwHKECWmWra6jyzmDZP0eRafk-KsZHaPzjGAg>
X-ME-Received: <xmr:ANInaiIvlWdHkXZPYgGmDUG8w4ei9uVkfk2rZgB6YVodkNEW--seTqPdrqQanhaUTq1q_4eW_P1Slbwn2w2HWgAz1Q>
X-ME-Proxy-Cause: dmFkZTFOuY8dMEt0kTxkxRmFpFbvQ1eLPi9xSU4oX4nF9N6bIplnlK9T5ijfWthpQmdweP
 DtQJQrBcMIX5AhrzI7MmHXpqSp/E5XBwzz30bYw9hNvuVVc71GCxaWhEyNnudY0W3QuiKq
 202jDlCk4t1h/WB6EX1MY5oGXm41HQdDAZJC8iHf/U1ea41PFQL0kJGBfP5+4eOhHd8oZD
 +Z6zfqt4c5PzoYhZgUk6TxPj1JUSCUbTVa+L2y178H5u7cbQMcr2WVQoHs7go56d7mPTpm
 4TZ6SJi26F4NIRazMtg8g17w7MPTEr+PQkrLyFqvTa2igMBp1VCHQ+9APeLmqDltprPLad
 Bp7vjCaaVY1b3VZsPYgg/s02XBPPAK5nApU86bi2NwLlX2YJIHcwCFzhGsWA1ifUwaLuk7
 S45H4CGnAYQDLqwpml+wGqkYO7GZ7X5oKv3yxFlC6OXp3pE1g+pQ6J4fh5pJbBaNgSMQuH
 cvly5PyRHz0A6YL1jWusFZLs/bHzoBQS7qbKAuP07BbH9vzCX3m5lb5uPKdT861fGGP3rD
 CKnyVkEvCBDKGJ8RozFx6gsLvFuswJyGGcR2185RLrOMrcabyhhwLYKlMDZWmIUXS6o3vK
 dx9WXfVfqHrCPIXfd+Tmi+iq6jni7ufdZ6denC6BlyzTAKzeqrrZNlsX0GUg
X-ME-Proxy: <xmx:ANInahmVB8TZxjBf_GfxS89jm6RzBMuWWz6fPqf7DsS66xU2V2Zpcg>
 <xmx:ANInagH6uJyUCpli9dp6hTBO0mFjKeNcP5o3yV6JEBQq6IjlXGGmlw>
 <xmx:ANInahHcFSvim5DbJVBeeKKwA9eOE9vOEaSF1fIoOg0xWakRa8Jdfw>
 <xmx:ANInatN0EwR9XXFndATXE-cQtYfUrK2m2Fx1ywbL-fJ8NdeNx_NXyA>
 <xmx:AdInahbCHWPzX7svkvXk4H95yyqRJNAhY0QNzE6_BpALQKmg9Mmcvwtq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:42:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v14 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Date: Tue, 09 Jun 2026 10:42:37 +0200
Message-ID: <T4eYjXumTvWFDg9HUrMwEA@monjalon.net>
In-Reply-To: <20260609013951.3359199-1-liujie5@linkdatatechnology.com>
References: <20260608074257.3043531-21-liujie5@linkdatatechnology.com>
 <20260609013951.3359199-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

09/06/2026 03:39, liujie5@linkdatatechnology.com:
> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> V14:
>  - Addressed AI comments

Please could you send your new series as a reply of the v1 cover letter?
It would avoid having a large indent in mail clients.

Also I'm still waiting for a reply to my question about the need
for drivers/common/sxe2/.
I'm not going to pull any sxe2 patch into main until you explain.


