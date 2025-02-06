Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6FC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89DFA402BC;
	Thu,  6 Feb 2025 21:14:40 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 86A594026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:14:39 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f9c3ef6849so2416720a91.3
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738872878; x=1739477678; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cJUzJe+fgzKXblwUJuq15/FEwo/8QnBwLhxwL3+Tlzg=;
 b=Li688bt2EwsisBpFCIlT4jVH7NMjQWCXSONzygb9eH3tOP3y5KLTfB1S+GSV2oSbbc
 yxQjAHkaD4hPXGb89jUKYV4yJYyPSJcvsaDdqOSX731RpQSzrCMW4ZjDwXg7C+GkqLqD
 JKetukwi04iOg7CwrJ5abMHrStaHu4fEI4TkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872878; x=1739477678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJUzJe+fgzKXblwUJuq15/FEwo/8QnBwLhxwL3+Tlzg=;
 b=H/h8rJJRPDQkGkAuSNUtE7SpopuYVWXH5fVPUtWYeKoEWGcg0BvaB/OvTamu5R/IPT
 CGtHWVlI4Pk5wH2puAgOiTqb3tG1t9YkN+KqbqXFU6vJzPDXYGeq5N6H0005QLwgmWNs
 ky1jN/NzXKG9DPg23jmbrbNgQQDJYTWrcVALCb/rh2Xk44p0bIhZj7ssaLaChGJePQNi
 yvfjf3e8Yu5Vxa6qRQEPcnZpnXlTiozNhB31XaTQ7HvNrbp0fJl/7YaA2KOpPeKO/Y9R
 cvJ94blFzSKWiEw9U44HcDj9215BHBHTlXz7fH/v9seeF0qMUuWvobPDRMSWk9Q7WnWv
 60zg==
X-Gm-Message-State: AOJu0YwrKKptiKLT2W4tG7alyUeYVP5cqNXxPE3b1s6DrAXplvyo/FCH
 3S8u7UPrhf4CEp+awr6KliqB9O11UKVi7K5IMe0R9k5XeUAnMws3pEvZAd4nHb9H3oimxeY2OG4
 259iNYlGIltb2yzQO8pyUK2taesiM3O217yDOf7WXqtXlcPhzmag=
X-Gm-Gg: ASbGncvsInzgiaHmFlM6oZQO92cr5gjrj8toA2NUrOM3D/NGxQIRpqlzDHB/qG/T509
 owcE6paTKMteOFTUqeM24BTgdNacyCWx/Gae+6dYEjvzOKvKhLLRf0sx0ikZ/K34QV8x+1rIvH0
 SDSW7BinzmYxShzLYIb7o9NGeJaeGGcQ==
X-Google-Smtp-Source: AGHT+IG2CtZW2eP5tkYuDVogWVEc091KhxyZtvja+x6YncmGtj8oYjEsdCpCdDYO0Yy41+O1zccpbkpkzdsEbsda5Kc=
X-Received: by 2002:a17:90b:3e8a:b0:2ee:d797:40a4 with SMTP id
 98e67ed59e1d1-2fa2406925bmr615711a91.8.1738872878684; Thu, 06 Feb 2025
 12:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Feb 2025 15:11:29 -0500
X-Gm-Features: AWEUYZlYR7Lv8CjjmDZ_mUa_0P-dSYbd3yi3agHlulC3VbLH6Vjcfh1VFVIwP3I
Message-ID: <CAJvnSUDv4qBefWqj+ekpVjHD27JUZHQN5UkQJj37Oe_qK0SiWA@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] minor fixes from PVS studio bug list
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000003e7654062d7ee4d5"
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

--0000000000003e7654062d7ee4d5
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Triggering a retest due to testbed instability yesterday.

--0000000000003e7654062d7ee4d5
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: iol-intel-Performance<br><br>Triggering a retest due to testbed instability yesterday.</div>

--0000000000003e7654062d7ee4d5--
