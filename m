Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D0C2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 16:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16C22402AC;
	Fri,  7 Aug 2026 18:24:04 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 707EE40265
 for <dev@dpdk.org>; Fri,  7 Aug 2026 18:24:03 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so5929542a12.0
 for <dev@dpdk.org>; Fri, 07 Aug 2026 09:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786119843; cv=none;
 d=google.com; s=arc-20260327;
 b=JnyVQAjQ9/+RsqvDAUD49QhGWbzX86+s3AvkYedSP9QW4ExJEir5GRPB7JQbx7BksQ
 TIeaLpEEf0/Zbeo6Jv0J5j/kg1KlaM+6L0pLmXIsvjmUdsvZZ+cEt3L+ujdg7KT5q14b
 1ds1I3I0s2TfUSChbwaTQlhn/TH+Sj16YgtD/jO/iW2xEk0Z/+Sfq/WukrqrAlZdEyA+
 p5Yv/Tcyx2dmIDPD2riWqv6Bx0Jqcv9sTZb2Sd8d75x0sAEawOF34sPYk+LhY+THsJuN
 Dh9HvGFuvqmXUq9t2tQSG5nW9sseyJSwfEJ+KoHOImB5AqxC3hFH9VbRtUAEBl7ERD5O
 bMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZadJrJ6d4rBxBWS2MiMORkqtjV1TRvDdmcaPlHOH3tk=;
 fh=qyuuzndXukfeez3OyMxQvZAFJoasiBgnDAdKPalV9JE=;
 b=CIMFJaRC/3QNULvnNiOSJIW301yaPHRRtE2xyFpzF+iwRMjNpPPmUAUYsnSyNWJWcQ
 1jxzZzteSiP8rM+RTvTxROevmcabhEbh1RlWujm7ETdQjsU/ZVpYSY8KxfJQu5DT/mKt
 SFt/TRTerKBFQEtaCplANSexJmWBuHBRzj2W9NEwTG6tXR0GZIhJZohRgDSWaWFVeUHP
 reXVl0P4683mm8s7+I4Wle3Rn286i9RHh3wsOlzmDu+IuZnKUNqH3RvPnoj8ogPf6j4v
 6krVI1oWHNk0NY49rWaYDjtNc49065LLBz5xrogA8t36o6ez87ik+H34roeDEEwC8zlx
 JOfA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786119843; x=1786724643; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZadJrJ6d4rBxBWS2MiMORkqtjV1TRvDdmcaPlHOH3tk=;
 b=OlQmrYInz+7GUuAfeQVNkLR4FxVTwaYK/03hx5vPsAXggIxpD9kzgdVuHaBkkRrnwM
 uM+0gnFmWBqJqlGTXCGRHf0wK6MyQp/bbs7g1Hmp666lS/Rd9ToTXdTGd0klYHKdER9g
 kLRDRCrA7JPsMXy83igO3tB+hKRTqtfXZqwno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119843; x=1786724643;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZadJrJ6d4rBxBWS2MiMORkqtjV1TRvDdmcaPlHOH3tk=;
 b=COj2lSiGfTZRCloADhEAKKFnVU0kkI4QdbDMMkqjp8Zw57wNGeE+ayCHIavN6flKjj
 POoFYn5SU4ZXONe/yq1zHAq5JWMge7ZF0+NQJS4wQOf4gtI+kfvkX4v/r+qVLtfN852l
 +EI7z7e+FUc57nCwjLn053oWA9nn31EdfNbTrGYuEFwXZasHGE0Y1V5qPrc+theTwY7E
 JocIbQTSNRhRUlYwd1wYmbklZUTDnA2DHrk/gN6crOD49gkUUqbubPRXyFlIXqltEMw+
 qpwuDeGUIeVAjz4ddFEkCPXf1k0Xr6OE3vyI0/BJyyXUziapBFGTEzapllXj9uIarafR
 fFkQ==
X-Gm-Message-State: AOJu0YyEwyYrM+/W0qMeQgGEuWoMbT4IP/Il2yqJkGabZsd3y1OJYL+U
 S0FQcx0JkqSsXbUQeVc5klRR0SnGKXvmXKLkKGw/hud7U6F81FWRbKvqmWbIZR1sfNriXP2yNI4
 1RElWUtTBeFVQbqFwunyabvJtRC5swkv9B9kcHPpwGFeQIbLZhjOg0m0=
X-Gm-Gg: AR+sD10Ga0PX0zyPZhszE1bvIOu43c8FDWhiiP7eKLcMLc/N7YHNPDIMX0OZf9F2eD4
 ETRnVYXWP/kRHynA0SfK1fqPdlqxAAjsnXM48j4xBxyUK168NgAUtE3cO3SBynAxJaryw2XJ8lj
 L4bUS7wSe0RiEiugcEybMownoonUHV8c4wfZxxZFcF4rdZir8LDdTOfLc1/YRbTHH9aftMetnNs
 kxH4/0OwIC9H+DiroB0AmBpurS4gVm0o36P6LB/HDXucIGIcMw8hR26iyykYEmPJHeVzcBNyqlU
 v2GoB72N2bkiTa12aCIcbdgfJaSIEa/3Wm+FfUGMg1iet4Oixry6xInf7uE=
X-Received: by 2002:a05:6402:20cd:b0:6a1:d363:1b45 with SMTP id
 4fb4d7f45d1cf-6a1d3631e06mr3804896a12.20.1786119843043; Fri, 07 Aug 2026
 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260806164505.642928-1-abailey@iol.unh.edu>
In-Reply-To: <20260806164505.642928-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 7 Aug 2026 12:23:51 -0400
X-Gm-Features: AUfX_mwImZLfvTNg9qH82Wesy65IMlENVI37IS4clrBZMC7KdDOn_730wKkLBDM
Message-ID: <CABJ3N2WEj5bzHMPWFhdYPDWkWLSGRCidHdnxPATfpxs4yWD-qw@mail.gmail.com>
Subject: Re: [PATCH v1] dts: remove crypto test type
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000c569e90658776e49"
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

--000000000000c569e90658776e49
Content-Type: text/plain; charset="UTF-8"

Recheck-request: github-robot

--000000000000c569e90658776e49
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><span class="gmail-il">Recheck</span>-<span class="gmail-il">request</span>: github-robot</div>

--000000000000c569e90658776e49--
