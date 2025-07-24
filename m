Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC1C83F26
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 17:25:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79B0C40285;
	Thu, 24 Jul 2025 19:25:16 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id CED9340262
 for <dev@dpdk.org>; Thu, 24 Jul 2025 19:25:14 +0200 (CEST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-718409593b9so14839817b3.3
 for <dev@dpdk.org>; Thu, 24 Jul 2025 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753377914; x=1753982714; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D6cyD6XClJ+iDCpsB+540IuqrAgDk/gJzdRelFNy47Y=;
 b=InD25xow2OGh4hHbqEDFaFoYAAFU97QkxTasMXYto62SayyxhnSE04rI/PvKox3GHI
 /f2Jn+u7J2ljlRnGqBxUTBMvZE/I1NNKKiyEllrs/crz4K3b85x1eQvnJAFnGgsnM3W3
 GbcaVk2UOucy12hekRz7dQJtWFt4+9YygT1xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753377914; x=1753982714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6cyD6XClJ+iDCpsB+540IuqrAgDk/gJzdRelFNy47Y=;
 b=TEol56xxOILsrwc91iU44aSHXOGD4AhUz7LWJauyruaIDhp8PyVdmxn0Bau6xe5VJF
 OZgfoYUCTYZhycKG80pKzoqLlzZ5+M1Ez5WKeatIwpgRKfbC+vYzGXMkWjtdgfzkfGI8
 55NnlKc+T2IC0HnOnIWgoIOCN91dKPGuK8K3Jrj6hUjdSaEl5LjEoSgzzc826Z4G3Evb
 6NzZgyQJqCns7hQVUrJ0ydPVyPXtaw0zx7RN4cqdrTP9fIS6fHWlF/bkG72/1MGtclz6
 HYde3/vAu9E0zbzf0Lsl+TjBJwwuHKGHZd72R9Gw/h5zhRawS0jaodddZCFvijBEX2fN
 xaNA==
X-Gm-Message-State: AOJu0YxaCVJpnvQ+imR1svMxUmwh+iGT97QZCYkGfjSNgcK70Og/K0J0
 IN4hvPvab398j9Vv1b+zbIUB4f0QltDlG5v1KTMd6y0tp1k1HGiTXkdzLVlubJGsQQbAJjNv4fF
 0gEpmuI4MAwm2Yv2nMYH4M5tfKJq5xWruetSiSOYOJA==
X-Gm-Gg: ASbGncsPDKkXKadAb9NIXdZyXFSBngk8QxE59P3qQ3c4MR0wAU0zASRTQyi2dNfYmsU
 Qy46FYfLYRtF2v7Q/+mUeVwPegRsNzmrTmIJNwjs64DntcP6kNskAm5I8eQ0enz4S1CjPJ7ee+f
 oMKo9GT8nu1Qm+isiQPRAQ7DRwCmtEobiAnAcZTlI4eVvpenz+ZbtQ6gktfpdCcQxfa1sG3swIr
 zBPJCzYjPpQl6xgTyAn
X-Google-Smtp-Source: AGHT+IFQX06Bgd90VfUlvPFGSs5fuP3T3LY/kAYMFvU3WozMP7f8xmyASqVvCEk4cXNkZGOGdN/oXtChshUjvsQTPog=
X-Received: by 2002:a05:690c:d19:b0:718:37f7:66d6 with SMTP id
 00721157ae682-719b42e0318mr96811407b3.25.1753377914069; Thu, 24 Jul 2025
 10:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <543e940a-6990-4cdb-a5eb-e036485a16e6@arm.com>
In-Reply-To: <543e940a-6990-4cdb-a5eb-e036485a16e6@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Jul 2025 13:25:02 -0400
X-Gm-Features: Ac12FXxG8QJBm8xT-ubGGtq_8U7xs9oqZP6CyePBmmxRm2UyFltVdDuDKQXCJRo
Message-ID: <CABD7UXMFmjCoR_5jw5yeJAPkDR_GJodZzzow9d7pkC=LOEoZ=Q@mail.gmail.com>
Subject: Re: [RFC] Proposal for stable developer-friendly DTS API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, nd@arm.com
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

I second Patrick's comments
