Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F7CD46BF3
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC2774014F;
	Wed, 28 Jan 2026 20:08:19 +0100 (CET)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52]) by mails.dpdk.org (Postfix) with ESMTP id 1A7CA4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:08:19 +0100 (CET)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-944168e8c5fso146882241.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769627298; cv=none;
 d=google.com; s=arc-20240605;
 b=Qwd6wrcjUODRq4xGUOcqZSwrhdzNLUTX10IO02yIgWsTGR/UviH3EngDqoSTFpppO7
 P5durfg5LGkGw4NQ9Z0wgkp16cm0r1Dbx0Ce/FsXkspvpW0qmJH0K7fKp7ItUe9y5ZDB
 oQwjT8t70FLRklIFBRpdPmoaUD/Ar35PQiyDOoufudD5CvO2QB2RZ4HMfsMubAJHSK34
 Ip5KAqNb3CpBs5iAgiKzxHXJsJRsTwOth5AnOtMMi4ORB4taQIfCAe3TiC9/vjD+I92B
 m+6MBwII+i7v5xV/9BC9JJYqSoMrkU0OB1V16VC13TGNVtxTkzQ4a0CYlS/Q8Tz3Taiv
 BJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tv6h9WpYEwKsyTw/vMyF9nFRLUUbdI0LoeNkkCWq/vI=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=HBVqvM3nBnMcVDMbJjOy2JKYwVsBHpRYSwWevWlzgIAs81Rjfjfi/tY0KvFG1zLUKg
 emsDKfLfZiPqQHz2IiRCwXeTcR8s9qtJDkLRqDGn3RUAZAcrg1JDp2WO9a7v4GAMfPZB
 GCUP7NZAB5wMsZ7iQWNiNQSp1UjlxzNtz8ZQbcMKuAHaWG2qacjEgplt2BTZy4k04u6u
 TEfoDs/SiDurcjUqCoW5+ruhcwpxF9EPlYqW90HuTK4bSCjv6sJ5V8Zmt6F4bLYVymGm
 XNVSq0tLm29JcCtWsivVJH5zvCr1llFXaFKmssSKzFIXbQAwnyMBod5xb6mt9QY/U4fk
 kFzA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769627298; x=1770232098; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tv6h9WpYEwKsyTw/vMyF9nFRLUUbdI0LoeNkkCWq/vI=;
 b=Zd+PtOzgpLEQHdMD+aGmDGiM2Jq1wq+Nay+ItZFrbx7lIm3Lb6UqnDwhskqYb7NneL
 oH9QwBd94C6OdVgA/cH5OYt5Qr2VYWJrBhpZhI84sDZ38g+df15W7hGphOa4CHnVQ1kE
 d3bAjjwCjh0Q9rrAES3pOad2sd4yX2LTEUy+4H5RXuIxfMVa41vX9g4gotH5E2oE0+Wo
 P911thKcXYQfJ6hFFGwdhNTXGwEPQT0VLsEyIPluhrISiaoUUM8vGkdKx3fQxK3sL7xS
 uVx/g8IkdYx93bB9YvIzC/1n+RYkqdMUziX0jTu/ejJ1mdJxaD1PWUvYelS/IRAG/ZJg
 gZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769627298; x=1770232098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tv6h9WpYEwKsyTw/vMyF9nFRLUUbdI0LoeNkkCWq/vI=;
 b=M3MDrHpcyyG4sPfdvlieBTkqXTR9tvX6400vppxwPpQVYoodHXbdhXbUmXf5vIsw0/
 0u2/WI2ivTYR3WpGp+VOMTEV1KRWFGuRhSjVKtwkT3paD+VIf3+XpTs3eIIdhWnjtGUc
 cFJBNPa00nOKaCtX9CqhyG3cmcOFZBoVKnMnRqnmD0nLXqQsO6Mu6gT5RcL0LtUEjpi0
 ixhaC8WCqn2kUCFs0ad5Q9NpZdfmLrgcFko6vOeSaIbyscoKsUYxamCTsTQJjt2+yIwL
 GYOymVp/knBIVmCViJQpUVFttspZSoOM1rz1QNbuqtTJt+Wl3q9cCoIsQV+mgGwweGyu
 d0kQ==
X-Gm-Message-State: AOJu0YzIDplcWJ5eqHz6jzcz/lyL6jcQhtvXeRAEwUc0Fgqn2PeHVTAu
 RPY1fOr3Yo8e5qWGKgkYcdb3ZZR4c7zyl5lq9y2/uQb3j5C+TTp/F/FSKmZwZ0aKAAFxYDM3DrH
 Fvg6iF+gZpmayzSoQdRHoUx48PIMuP9g=
X-Gm-Gg: AZuq6aLkyKdZXy50EuZ0sXkzcSKMuDT5cRj7HE39Ir/2wTQAdP6m6vJuhDoU+AGEWVR
 D0ZysrK0LwVUJSUz9jiOy1NOv4yX2kLZTHoDuaflaHPemTmzKkGe2k5OzcoBcOgCtblNPdFLyZb
 L/EodI6AmUTkIxNYmtkNqCNullRj9HY0WBsZXMMUromBljI9iJ2ypIer4A1f1LELPgDtZExR52l
 AWFh5pXLxrS5pdyAOC0BOSJZh2cESYwv5CZBp2h3W1NGHqEH+Vu0+9X90ZzK7COr38tJyz+QAyf
 ye8zfq3ErGG6grQ+CFZ4W3M=
X-Received: by 2002:a05:6102:5090:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-5f7237a6a9bmr2497591137.31.1769627298322; Wed, 28 Jan 2026
 11:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-5-scott.k.mitch1@gmail.com>
 <20260128102710.0b205120@phoenix.local>
In-Reply-To: <20260128102710.0b205120@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 28 Jan 2026 11:08:06 -0800
X-Gm-Features: AZwV_Qgoou3l6ALfRnblS0tyhdTQixNF014RKvbCG-P_Nf9OtLn9epUlARAgeHw
Message-ID: <CAFn2buBQ+9mYXXQnFHA6bse5b8dROvpEPN3mr0F1W_cspvamhw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] net/af_packet: software checksum
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

> This is failing CI build, fix and resubmit

v3 coming soon.
