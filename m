Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73969C02192
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 16:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A573C40265;
	Mon,  3 Feb 2025 17:38:56 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 18A0340264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 17:38:55 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-467a56b03c0so2306191cf.3
 for <dev@dpdk.org>; Mon, 03 Feb 2025 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738600734; x=1739205534; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+jvgPhRGBmCjrJaFJRqboNuNPa7gOXvnRVTNfply5U=;
 b=dSVW6nuORsyDKmYjwjGc4ByPw/R8n7h9URfc09lVbJFZ3FZ0CvdA7dZiOqLYEiomJ9
 Ha6y2ecS5OZW/seiWKOq/98wJaIgItQ3eMfZ6jE46+S5DeuFRzhhOxBoytPlX1U0iKFr
 utmsLFOd4OKKViDT2uBVaQAGvUPIbNsqHY2ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600734; x=1739205534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+jvgPhRGBmCjrJaFJRqboNuNPa7gOXvnRVTNfply5U=;
 b=JEYedI1CzNPrb5k7QKAWk3GxHXVwT0vjopy3tY04nsnzuuc6807+Qh7b6lxlT12MQU
 y6zF7kKfutk5wMilHy/rgzbqr6LhFbK4JmP4xnJC+5q9YAFwa2HJL7hOPMAOJc9P+VCJ
 oN0bXLa22dSUAN0JpUISjNWpNBZb7DvLRmXtJH1o0UTttWaHozsasVWOsZxxZTTIFFyL
 iPhumimBJe+N/UOsWcl9UMOYcu7Kg6YXNlAwhLqyOEz+prqjUgaQakhkr1UMlY3QYfRL
 KEAJ8Mh6Igx9ggWXvsnqUhLWKZ35tLjUgDYBYbHv/k5jckx61WRjXCc2iHFHU5e84qzx
 F4Rw==
X-Gm-Message-State: AOJu0YxY0JpoWtXDuI9KPFGtEaOloyXI0FaynzAZIDhI/LTlLP8x99U9
 pwSkNzZhIT6raOAEAX8HkryvZiU2ObKgv187WcFYPij7tArkmX4ZKeUd6AUFAJw=
X-Gm-Gg: ASbGncsUG1/qyydFtbOkmnSXPjTQ5QdJSZ96B2USk308ErygfHhSYPGm4uNAWXCiQzg
 P0+esnFlzQJL12AtiplWWUXvWx0c8qsXYzqZOW+aRVguJVoe/dsEV4Va9bb6DtzgtwMXbnflV/l
 7G14LAJhUeeLJSgtkkaQB11PtO1YCk98nwMgd6MImPrrs8kobJaGn60LPaIZ029d4UIsWL0DJuI
 nTu6IWQgol+uh6BFUfO4eORoWnxqUHgdA8fqTxURneKCs6ooJDD3FGZNyZmjcylESf+HoYh6u7y
 c7fDs9wYLh5MO2/E3RUzNrubmzrO4iba2WnFu/my9xriyfT9YcgInHOy
X-Google-Smtp-Source: AGHT+IF7WycNcDAAYl9n4qUsaesDi4du7uE/LSSy2c2QT61oKEvvP/95O3prQELJHIUEaoXvwL++oQ==
X-Received: by 2002:ac8:7f53:0:b0:464:889f:a41e with SMTP id
 d75a77b69052e-47017e4bf50mr1974961cf.1.1738600734200; 
 Mon, 03 Feb 2025 08:38:54 -0800 (PST)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e0bfdsm51566711cf.41.2025.02.03.08.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:38:53 -0800 (PST)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: Honnappa.Nagarahalli@arm.com, stephen@networkplumber.org,
 thomas.wilks@arm.com, probb@iol.unh.edu, luca.vizzarro@arm.com,
 thomas@monjalon.net, dmarx@iol.unh.edu, yoan.picchi@foss.arm.com,
 paul.szczepanek@arm.com, ian.stokes@intel.com
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [PATCH v2 0/2] remove requires forwarding restart from framework
Date: Mon,  3 Feb 2025 11:38:48 -0500
Message-ID: <20250203163850.249461-1-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131193803.168498-1-npratte@iol.unh.edu>
References: <20250131193803.168498-1-npratte@iol.unh.edu>
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

v(2):
  * Reworked the organzation of testpmd start and stop commands in
    run-time MTU update and forwarding test.

While I initially thought that this would improve the cleanliness of
future test suite writing, because of the various nuances of each
testpmd run-time command, having the framework managing forwarding when
needed introduces far too many additional challenges, such that, it
simply is not worth the time implementing this.

Arguably, it also makes sense to have these mechanics (such as
forwarding restarts) written explicitly within the test suites.

Thank you Luca for pointing out this issue and its potential
side-effects.

Nicholas Pratte (2):
  dts: remove 'requires_forwarding_restart' from framework
  dts: rework run-time MTU adjustment test case

 dts/framework/remote_session/testpmd_shell.py | 26 +------------------
 dts/tests/TestSuite_mtu.py                    | 13 +++++++++-
 2 files changed, 13 insertions(+), 26 deletions(-)

-- 
2.47.1

