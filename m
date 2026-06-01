Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E1CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2AA74042C;
	Mon,  1 Jun 2026 17:26:20 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 6F1994025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 17:26:19 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304fb780deaso2339827eec.1
 for <dev@dpdk.org>; Mon, 01 Jun 2026 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780327578;
 x=1780932378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVLhUcA53xcTUaUh79Hb7Sqc2vt3ANkJpgyuKRgNUiA=;
 b=HrjK4bV9eHBu17ZDckEZR1iUs2k8kNKfmfqyBU/vC9uCAvdpJTf7dGv9rnzHqZB75h
 42d/fru1lJkqcIsdscUGXjEFYowjbViMKw117X7hCGBaRfCKNV2mp/Lrtb6K/8e5mMjE
 CKkVs8IEdHwpP93R5PJ4GkdtcB2lW9CtMgbz1upSgSpfRlvHIonyP+weoIbCIlN98wax
 Jao4t+GWetaU8EG9NMNzuI8ywohGZvy1m7x8SrkcoI09G2r8WR8aAu3p6PjtJazgzrEo
 +yJaeiUrfPSwgno3l6fiWYPe81RZn/q5+KLl8Fn8wT21XnKx4YsAJUI2n5T4uuGmqc7F
 KEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327578; x=1780932378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QVLhUcA53xcTUaUh79Hb7Sqc2vt3ANkJpgyuKRgNUiA=;
 b=BL073yUdt/hbL8UmY7Z7ofFkWiMiyBO6FS6hxaYCK6qCNyOtL7Uku4Rz0sXmZotXSB
 HO6Zy2TsfR+UbER1TFJ1+o1ckqiKYovWgSrbiBe86gG5AMnAeSHc0qI2pt74A3zyyt9U
 3K4DIA2KQVIWUglSTjbhkEvSTm9DV012wkUZhsIAMo+MagrcFAB9Av4tvQiKOTWkF66X
 DpicAF0n/6Wd3o+zGAtt3nMOMoDL+yvSakjBLXnAx9O7cq63zUhMtccLk9Djj4BDD7SQ
 QqGfFAs5bGHB7c6LTN7U/47i+oq9oucYtAn5049TGo2LKePldxHwytqteDXoY5RVpNbo
 IRGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/B6/zKom91tdjggNR+4dYmiRIoxkyG7eVEKo/H6+YGox2KMnSpa48D2TCf4kqGjHzMSZQ=@dpdk.org
X-Gm-Message-State: AOJu0YzMBGZsV0gVjuDvGL7yf4Xg1h9adZM54II98lvqXbm+wMQ6oemq
 xsCGnhgmZiSKTYYnbNQXn0F1YA4mWy8VK7x6XKAuhOQ/Zdiuql6+w4SPzV4HexntJ/o=
X-Gm-Gg: Acq92OHghw2aF2iCm31UghEwHmcWWeqNSX0NxROAyFuf4QoEF/nJaCdjVI67U736Deg
 K9XqG1uBIKhDZhWvmlCuPYg3vrrHtUms4OlwNpRkOGfuqZcbAZkKuYmT+QaQq9jpkP4DqFCn3JC
 ax3M4qWqhW4iYjbzVzNX/sYsPifyvwavi1V8CUTDPaIIaPZ8PCo3XwBHLsJRjF8isB7x+WM9Bym
 AMhGD1iWBV83T043YcqPkK3bLyPJsFw4EgMZO1W2ObkVEJdSozR8/h5O/WdbsHL8ot1DEgKW+3r
 XlDPu8iDKG3dEFIFxmT4+MtjerCvTxPxVb4RDNksAPQ6WQzX3iOPX0T4TMXfanwLzNIp5F0AQ8+
 k6qH6BUtiASu7xvsPlxDvkqUHeLtH58aqTYa3t0wTLi42Jt8CkJRi4esk3akYbNLtxO3lEJZhkz
 gJuxVTRW1fn/NHz/S1kIEVodsnxM3puxmiOzX9th+/HLCUrk/4TGYuIYFR+PShK+auROUfVCpId
 CI=
X-Received: by 2002:a05:7301:100b:b0:304:db3a:3919 with SMTP id
 5a478bee46e88-304fa4c9111mr4603860eec.6.1780327578183; 
 Mon, 01 Jun 2026 08:26:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed563d09sm8830347eec.15.2026.06.01.08.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:26:17 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:26:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, Thomas
 Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] ethdev: promote experimental API's to stable
Message-ID: <20260601082615.29246af2@phoenix.local>
In-Reply-To: <CAJFAV8ztviupv0rcjvL9MkBQSzY+yfak0RK8GzNbe-8s5JiyEw@mail.gmail.com>
References: <20260527144407.160830-1-stephen@networkplumber.org>
 <CAJFAV8ztviupv0rcjvL9MkBQSzY+yfak0RK8GzNbe-8s5JiyEw@mail.gmail.com>
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

On Mon, 1 Jun 2026 13:55:13 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Wed, 27 May 2026 at 16:44, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> > +  * ``rte_eth_macaddrs_get``  
> 
> I am not enthousiastic on marking this stable.
> It more or less sets in stone that the mac addresses are stored in an array.

So either we kill it or make it stable, having experimental API for so long
seems like a todo list that never gets done.
