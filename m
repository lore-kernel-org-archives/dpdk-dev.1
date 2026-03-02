Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC06EA4E22
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 15:48:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1453940DD1;
	Mon,  2 Mar 2026 16:48:11 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 6428B4025F
 for <dev@dpdk.org>; Mon,  2 Mar 2026 16:48:09 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-899fb2b94c1so18813206d6.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772466489;
 x=1773071289; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZb7SSY+LvWV/haUOAntaOkKbmu0KnoRxykdgrlw7/8=;
 b=Uq5QmW8iaQqSwebOoEmg6+rV19HOdPu6cavwS6QSo/kga29a96Qm8sZBoeB5XsvIT+
 3mAiUcBm+dqpmoljWbhxqxF4iQPKTwYsQP4wTxLFDx9M4LV/iYRrH70PR/M5jByvKKNb
 UPJ1V/7JsRFM2xzzFnOUMpU+wDaEpRTgb0YIay5XC7XTrIXV9uCUvribtlT6oKc77+2J
 wLqKGKQ7fGhfSG/4AomzUfYdaUe2753k3Tgjxi/X7ozHcdIOyg//Tf5Oylh/Se8Elgjw
 FPm3P/jzpvcFdOJ+H1QOz0yVJCCsGJgx9h9K6yEZ+BOuIk2pVI/dUkCuUjtUnY/xGWAf
 wJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772466489; x=1773071289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oZb7SSY+LvWV/haUOAntaOkKbmu0KnoRxykdgrlw7/8=;
 b=B26kuDpOS/RK5CIxd3AW/1pV32XhdzVMsARkeubsJgCoOF0dD3LoJUy9Lt9b315dnj
 lSWncX8pVJ7TvjSvC+mG5iRmEQYj2Hg/raFqepRRhn+lGF7katFW+pKcHW3s2vMXrgoH
 P262GiTGairMAwyGaYAsilhZHwx4O9LJpI2epdWmcx53MFopJEX8fetXTMSppioAsgd1
 qALA/pvyqWC9UGNiDVupxAHRfPWrANU3QYhjnJo5MdDE9VU1uZbX17LcN8Rkjfbr/LuT
 XbK0xej/g0vO1geXghqFq58N3SP6acqAqOLg5RM3QQv1WjGTACSoCDLYwG78mPY3VHsk
 jkjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaj2pNkWXEVnICS3fMcuZrE/G8HILsFdIuSj2f/V49IDhkdM0/ow/sZ2HOFQWLjxwcu4A=@dpdk.org
X-Gm-Message-State: AOJu0YxQFElgKRJXlvQVL8Yb4++YDx5Fywgd8pojaggnvaIcdParvQsa
 jTbTVVSo1GGqTBVkIfehZcritMn7ftCiZ5VYFUPKOWSighmEsqd4ZqMcm9FG6p7AqLc=
X-Gm-Gg: ATEYQzyXeTe63E/UCTjC+G1XmlKnOEWvGCqc6BSLevHmiCAoVEOKVljunHKBoMvtq7A
 6kdzffzZCzCvFlZxcf7iIyQ4wwEkQcpJ3IDKxGkVlJpkKphiOHigD41J2zGUprZOC+K0852mnqB
 zYz/KTlqSFmByFavgMriRay89DE1cyEe518CBryF1rOFiopcZSnxO5HSMxSnlx59VSHBHlGsMnJ
 Cx6D6X8Byfronto6E8BFLkKLQnkPO8NjJ+6tkwliB1NunCIPvsnYIX8bMJL3EMKjeZF6zx6hQ4G
 YYtIGBExXsvl4AbWxWm2J3VYXjsDCVR2EeyyKVfP0QpEjwHK08EXo9fZDvw5EIRAlGBnbfYcUJU
 6Qyjpn6n8kCiWga51XG+BWyD2qiq6MWPENkQ/4IwQ9hJrPTafUQ7EZNOJAIWgW7Z5a9b+smU9u0
 MDb+/JIveg71SLxfGIFLZPmYVMAIle/FEKFeIpsfmXqMF9n6N4AvybJxFb6ygTca5YTI15UG+H0
 PA=
X-Received: by 2002:a05:6214:d6f:b0:894:81ba:50bc with SMTP id
 6a1803df08f44-899d1df36abmr173964736d6.30.1772466488598; 
 Mon, 02 Mar 2026 07:48:08 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf7175c6sm1193171585a.37.2026.03.02.07.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 07:48:08 -0800 (PST)
Date: Mon, 2 Mar 2026 07:48:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: rkudurumalla <rkudurumalla@marvell.com>
Cc: Pawel Wodkowski <pawelwod@gmail.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH v6 1/1] examples/l2fwd-jobstats: fix timer stats display
 with lock contention
Message-ID: <20260302074804.40042d55@phoenix.local>
In-Reply-To: <20260302061805.1666176-1-rkudurumalla@marvell.com>
References: <20240811155957.576645-1-rkudurumalla@marvell.com>
 <20260302061805.1666176-1-rkudurumalla@marvell.com>
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

On Mon, 2 Mar 2026 11:48:05 +0530
rkudurumalla <rkudurumalla@marvell.com> wrote:

> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> 
> Race condition between jobstats and time metrics
> for forwarding and flushing is maintained using spinlock.
> Timer metrics are not displayed properly due to the
> frequent unavailability of the lock.
> 
> This patch fixes the issue by introducing a delay before
> acquiring the lock in the loop. This delay allows for better
> availability of the lock, ensuring that show_lcore_stats() can
> periodically update the statistics even when forwarding
> jobs are running.
> 
> Fixes: 204896f8d66c ("examples/l2fwd-jobstats: add new example")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

This does fix the problem, but this whole application seems like
it is using an unusual architecture. The main loop per thread
spends most of its time updating job stats and only periodically
calls the actual rx/tx burst forwarding. That is upside down??
