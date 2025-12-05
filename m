Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF302D2CE0B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8358740DD5;
	Fri,  5 Dec 2025 03:30:11 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 566A440B99
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:30:07 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4ee158187aaso15804511cf.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901807;
 x=1765506607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=ROR6VMTWBA856IF1AMABfXN8t6zbKqsPUOODpUK0X+wRLFd/MQuLuz75f7y5hc/hq9
 Cx3YLdFt4JKRzaGq1NP6RHdakXv9XZdv31ks6NPk+dWnNWOqE8BAxWvW8dvaBPnAPtVR
 0pC9w+lXnwktsXTJiaBaHyIf3zS5SKiHcS6uQuxTNk7lEmyMohbl4Jh3sdo1yKmriSuY
 Dk54DLMCTS1wq4JcZ6CCUzchM7n5cvW5O46kEd5LtAuKCLSQGkx5qXspz7Awn5b9yUia
 UkQrr/gkMilDZ+FAxSaHqVjS0t0sqieOH8TLgjllBApSQDPxCp9oY/lLR2BEfbbABfiE
 3XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901807; x=1765506607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=r+MCnt9v1OhOuNTGFFKrekHRaoBz38CxZqxB79n/b9mHq2nVkCrIz3edu2smp30RFN
 IzlEv8yJCq+XZaAqPEGvOB8PpqCG+WoQOYV678d4o6S6xj8KOEgLHH+ErTzzppdRPN9d
 JLiiC8HlhipBHEg40dk2J0CqneYwlrO488iEdOCS9iYmDOY4wUEQNcOKGWgz08q2rsd4
 eNpRckKYyLCudfhR9ziCWGrMe8RToS2jZP/8QmGoj+pzevlHcS2LP8tnqdcqw+4KhSSP
 R3bxTQ/UsaH+HcIcvnyb+V4buP2EQKvl3PjKmWhc3rxpyWdNXsmPxAFu73P4snJa0/P5
 wwhw==
X-Gm-Message-State: AOJu0YzUUamPeJDvr42yRfyIYbBjdPNCUg26blfIs9z6r0dGy2zepH7g
 cOr1lkf9SZ6edzROAeVgz+rX29dbrIpBYzlCJUCPQkau2aeKHZ5z05uyfleuyoyfMG9gTvpdCNY
 KDra5
X-Gm-Gg: ASbGnctYZ/ELba51LpMYN1zKJ9bRqw6HMPdNL00MRiS6/UdBYYe/qOqt7zgubN6HAcB
 pnn/gWj9LdyX2cqpFf7QuVZ1mHX2kg+BwXDWc3RxJeSO8CveVPr8pNQSBECH8tKJ5cZpr7Iui/B
 tvar1nN7JjFMrPlbPJ4Bi8VrqiiyzR0zdF3FCyEjqJXvYa5BiqIA6OXv8pIiGCjPbHAItBqa9/3
 SIa5NJLXlR6chJ/CWeOXJuX+7pgTphZIy03DDTm+2rhRWDzswQl2cV5/ruuDT3ogMvPS3YJKZlM
 3g3rMYhhJCDzRQIXa+w5FAMcv8O91cqOjwT6loRPusbqFouY/pWjFv9OcdKunj3GLDbY7ixhNR3
 kBstxWfhBW60j8UES8vM1NepWo+wnh8x4MLdd5OEB6DYxR/FVpr9ufSe4KEuJMgHtK1o77gOble
 nI9JU4Mhx8wt6ZejTqTxpt35RYC5WAQ3nYH1mGYc/qry1xc18KlA==
X-Google-Smtp-Source: AGHT+IEm0WXuWn27km86Ar21XDcyuVOjAnhWDzMNxMN1nafqg4fZFJq5FJh70NKkKSwAV5ZUJgEagg==
X-Received: by 2002:a05:622a:14d4:b0:4ee:739:142 with SMTP id
 d75a77b69052e-4f017654d87mr119332031cf.51.1764901806710; 
 Thu, 04 Dec 2025 18:30:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:30:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 14/14] lib: enable format overflow warnings
Date: Thu,  4 Dec 2025 18:28:23 -0800
Message-ID: <20251205022948.327743-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

