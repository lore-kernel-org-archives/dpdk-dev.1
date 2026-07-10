Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B05C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 00:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB1604026A;
	Fri, 10 Jul 2026 02:56:27 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 6C27240268
 for <dev@dpdk.org>; Fri, 10 Jul 2026 02:56:26 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso376886f8f.0
 for <dev@dpdk.org>; Thu, 09 Jul 2026 17:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783644986; cv=none;
 d=google.com; s=arc-20260327;
 b=PGBpKX+4CGlmsH2tZXc8EkQD1XXmylHBA3qQX2OnI222ea7oKe45B6rVAT6A1wGzCR
 lPyiNP69nGFr1iXDcRxpHInT9NDmMFzK1mdqbEGYN32wkYGtk6u5ZmFwE6oq3cwGi9Ry
 +G4Ej5c2CW16ZK4LHiilIWct+1E7tkotviyKq3GGKHN4mlaf7JbMITQOrPJVa9du8zLM
 ZrW6dH9STMLk+aUvmwjPooI57W6aTTrpBRdHDVaTd46MTZ0KlKx1lYFc+umSgBWRfTcZ
 Faiqi4iKaOHnzN3gKkm5qbwddujSZQzdYMCfjfZ6YpMwEUvi2K3on9MKLe5n36O5YNTw
 UFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xhM0oAfuDX0IgqSDoJ1lCFIgVGoV1cZB8KPa0AwTsng=;
 fh=xQR6NzXEjC8c2CtntiDeDr+6cgua7Qwiy+w39KLz8pU=;
 b=G6IMaMw9fbTcTEHl7ScfWRWL9aPLyDD+3fHOquI7fP4Zx0HtVuXNdqM35J+MfGR9qO
 DNGuD+hcLWJRfOUSp8vztyfv5BJQJ6oisn27yO0Dp2odmdL9mIffCM3v6qjlMVmm41mm
 eTfFSGCZIJpGVrDdd6OOQNV+viqiBhNZar2eKwDqPre8X+ZwQUJ8gHa8LLZ0JXEN5T9M
 X1x9JfcG7eDRrWXOsnlIpP/dYRrN8EU9KxIBN0NX2kRuFib+ffTN7TECfgkq7IuRtLqv
 Bd0ZWDuUgUN5ySGm/qVmZCUSsJttsumvoD/gypZ7zmFCyTooVayMQKGrE9YMCR64kaRM
 +NNA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783644986; x=1784249786; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xhM0oAfuDX0IgqSDoJ1lCFIgVGoV1cZB8KPa0AwTsng=;
 b=CDNI6kVmEBUCHY0ZIEMYMNM2xb5NIljjIfPFLyHRJQv3knLNdv8hVYp/AD1RQy4pRQ
 CbDZp4lWEu2tn3rBvTx3sPGw8ZRo7ewLxW6l+YIBrejgDSmmuzfh/kJsKM0WmjhjCNe0
 rUnXdcTtfiQYxors8aW4SiBAJ+rIb2Z4bmE5aLokR1X9YecmG2qLjcn+Jv0h74mgCT0Z
 +fHhb3CtVtaNZatLW1xBwMw4iynU/QMBoWA9TYc0aKnw/FIFw7oxiqSHXnwVo+IQbWSD
 kuwCbS/HCcAZNVoXXwLhLQhm1ZOAnun6zIFAP1B6YaOUQw7MXUqW0DyabJ6QRGhePuO3
 RC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783644986; x=1784249786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xhM0oAfuDX0IgqSDoJ1lCFIgVGoV1cZB8KPa0AwTsng=;
 b=oLYiS0T3OnPIeuplZZFYLRos1pX3bZVeRTsqhNGWBJQdEkNRhJJO21frMrrpI/gjDM
 F3R+pZxiWFVYubh2wbfr01eBsPu9YTtsuDtbunAY6ASpf0Ms0PFUZg3CRbzcDHny52yZ
 gLxvyXskV+pR5STqLzdHqLIBeTQW17dDfb7739pVjN+8KmmtHjJhZpm8oaG4KJpSvO3E
 q1BED6DN3lCRBSsiVOxT8v2CGl0LKqrClzCAATb3UOjQJxoj8fb9t86aYtDB9KbIJH71
 FVy2eYxPFtQgOyskXEb+Pf4YhDAsZCSeTIZrHMsa69FOYXfNpxqtRVBZc9u+ZFb69pG8
 8DNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK4tklG+VEzamZfbTEJtmp/lZVvjPFHbQkrlH2rVeEdZZC5dS+oYRNb1NxLhn7OJRfjkg=@dpdk.org
X-Gm-Message-State: AOJu0YwENsM+OO1/Kq/5sDJW1cJ7qgZ0r+7JbZdGBDo36zK16V/59sZd
 BWK6jaH6aMMQ9VLu4AvSDNMYkvxv4t06cvzwFGS9KMtV0KOhaBM+X+tS5Ay8SHyRkwKNjikWTXE
 Q+Rsnqh264M7PhDTAElg3t9Iz2yAbZek=
X-Gm-Gg: AfdE7ckYVFdzkXg2j8gJaZdIN/Pzp32HyESrkC4uej9wWk85ACc1auCN4fBVkoparth
 xN/gS7r79XRdHfaKtf+TQxMo3l0nZVq2SU2oFUgN0j9w41kwhzA75RBdbFpjvYWzsKlFLX/Pa9l
 x/XziL1DXic+k2NaoNKsWKCzbtYiaaHGbW0kjeGtG8rqgxwhowKfSXEbgzfNRm8kJTuemnsBnmG
 k+BfWG1mnryPFQdcvrZFgldHomrp/RfDAuI/XR4cLt7LMWdnO7KeDpo/oinluEYt/5Hv3IQ5Hyt
 dPgWqrsSUv8I3c2lCqFcVJFR7pLRMJubhkGqmca+bX7LP1xH9P557rFjtXgNNow+jbs=
X-Received: by 2002:a05:6000:1a8f:b0:47d:ed38:4ddf with SMTP id
 ffacd0b85a97d-47df0797715mr12290529f8f.43.1783644985859; Thu, 09 Jul 2026
 17:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260709134814.805721-1-knimoji@iol.unh.edu>
In-Reply-To: <20260709134814.805721-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Thu, 9 Jul 2026 20:56:13 -0400
X-Gm-Features: AUfX_mw7t8iAFPHwolg1GsEBQHsRjKey3oGsz_IzojvHCr0IvhfqZMyxeU8OfhU
Message-ID: <CAK6DuxsFbmdSA+dhpOAvEBO1rB0NZYCABWmYUX33eHLE_fm0qQ@mail.gmail.com>
Subject: Re: [PATCH v6] dts: report dut/NIC info during DTS run
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000c9a0f406563735a7"
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

--000000000000c9a0f406563735a7
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts with a commit reword. Thanks for the patch Koushik.

--000000000000c9a0f406563735a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts with=C2=A0a commit reword. Thanks for =
the patch Koushik.</div>

--000000000000c9a0f406563735a7--
