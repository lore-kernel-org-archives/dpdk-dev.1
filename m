Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6BC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 19:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A89184026D;
	Fri, 27 Jun 2025 21:33:25 +0200 (CEST)
Received: from ns2.wilbury.net (ns2.wilbury.net [92.60.51.55])
 by mails.dpdk.org (Postfix) with ESMTP id 2C0FA400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 21:33:24 +0200 (CEST)
Received: from webmail.wilbury.net (localhost [IPv6:::1])
 (Authenticated sender: priikone@silc.fi)
 by svc.wilbury.net (Postfix) with ESMTPA id 6A4F762266;
 Fri, 27 Jun 2025 21:33:22 +0200 (CEST)
MIME-Version: 1.0
Date: Fri, 27 Jun 2025 22:33:22 +0300
From: Pekka Riikonen <priikone@iki.fi>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH] bus/pci: fix automatic interrupt type selection
In-Reply-To: <7218036.9CP3fYhb5E@thomas>
References: <8f5b22d3bedef793bf489c230b52b145@iki.fi>
 <7218036.9CP3fYhb5E@thomas>
User-Agent: Roundcube Webmail/1.6.10
Message-ID: <cdbd9d284dd174f99601f032ca6ee8fa@iki.fi>
X-Sender: priikone@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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

On 2025-06-27 19:00, Thomas Monjalon wrote:
> 20/06/2025 13:47, priikone@iki.fi:
>> Check if kernel returns 0 interrupt vectors and try another interrupt
>> type in that case.  Failing to check the vector count can select an
>> interrupt type that's unusable.
>> 
>> Signed-off-by: Pekka Riikonen <priikone@iki.fi>
> 
> Please could you be explicit about the use case you are trying to fix?

This particular case was with e1000em that only supported INTx, but the 
function selected MSI-X simply because it's the first one attempted, 
even though it got 0 vectors.  Enabling interrupts then failed.  If the 
function had checked the vector count it would have correctly selected 
INTx.  Now, my setup might have been quite old but it doesn't change 
that it selected wrong interrupt type.

Pekka
