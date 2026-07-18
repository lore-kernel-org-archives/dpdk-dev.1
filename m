Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E3C4450A
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Jul 2026 20:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AFA84027A;
	Sat, 18 Jul 2026 22:45:16 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 1F27B40276
 for <dev@dpdk.org>; Sat, 18 Jul 2026 22:45:14 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 8A65FEC0198;
 Sat, 18 Jul 2026 16:45:13 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Sat, 18 Jul 2026 16:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784407513;
 x=1784493913; bh=2ZnAbWY6wTHWSObMNukDcLcxWCLMGjvprS66HuNT7FQ=; b=
 lUWNlM0B3QM52a6/Q8M3cLH5u1Ehzffoebjoc6dJa5ncFbmQwuaUGbEqIE9/MuMJ
 pHvydvERwq0S2YnBnJvkDtXf52HCAg8cqY55ORSKetqq7KsLQQz9PHoHtIkb+9Qu
 7qTyp/2dxV8ox4IKm8Y54Mkk7s1DmKPaLxw8BRLgZgVI7Ov1sgj74Kk28kXvgU+v
 b11lA/uh2KpPDUPW6JPCid9UV1odFOfldljTgl7THpmQ8NMua7R39rLr2ladLpJ1
 Rx4FXrKGkYq3Xx4heSoaqFCYSwvXC9OyzJVdPs32dYURraEovYVTUBfniK6RCg8p
 9mp8pKi635t6qKdiHWcSDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784407513; x=
 1784493913; bh=2ZnAbWY6wTHWSObMNukDcLcxWCLMGjvprS66HuNT7FQ=; b=E
 l6/LJ31Q1EjAUTXPzikv3NqooKhQfDjiosW1YcAAP6Cdrd9/x5BMVjQaNmtyRc8o
 Yk9hH9b/rkyj2yNKtljBPfJesJED+Oy93EluvMMF91V0J+RRTQM1WwjO4ibDy0Y3
 +WEZq4wmhs6QqoMnm6/yJGJCNwcDoJg0ZtMqA1cZM6kYy6w5ZHqchbrGPOpWglU8
 CxNSAiQ57Dn+vwEiGv6C59WiJTEQ9sjXDsLcq5Ifyo9SR3qoJqKyMn0WCMSyja9I
 OoyeM0g3vRynP0m1jED2n41nS1OsyzN4NyaGGrnhcFE1Vg9X7rvd/1/v0IIrkACv
 fI09D8kv96L1knO4yLMNw==
X-ME-Sender: <xms:2eVbakCWxeIVhJFtdF0MbOoCBR-JSWfssIZDLmytNV8ufI5rLmzHYw>
 <xme:2eVbahVNrfG_FkZrsFBeg9j3eaFyg1yOfMWcX-Eg7WiJvl_EXnfUQlTyLcUP1VkwB
 UtpSUuS0KlkvpQ67D5iAGkUPgZK30aUXJRvLHwvfphIEr_vO1155w>
X-ME-Proxy-Cause: dmFkZTF6tbsQESItkVedIqH1D3hQ9O1WJWeSUfFsVMYpGQ+nlxhRdnpbPGfXO8oB+q4p+z
 NWazgmkmcsQXofvOoj0vDCVbPyJhYqHdJwwoxcBc3332eBj7Q5IFgFXHLo3rMPejfMCnyh
 kXWhQb77Oa4msDpNHavmOCMnwQ+Jz/JK3MFDuY79mTob1oByCakuC/wNMSeFhHbv3WkM6p
 mknqZNf2+POiAAyEs/fzSc+ytG+JAO4mYxBnts3nQy9guNKgw5+GzUnARs0RLlPw0UoWf+
 iFYl3yuiu6Fy9pMVH9Y4GcXEnFDaknzIkRXmGYqV6/DPO1HefgCg9HJK3dxoB/LofGl5hl
 DkIAqHuQRap339bTBKOf1n83ebHzfCEY8wSor/ztb5WqgD4t8TalCFkBmc8kpTaiGGCebB
 yKcnozAkIit5xI0ldp3+4n4XbfCeErHiGVFNC4w+SyY0hpHxjTX0w1Qbu0Z9NRmFTsQGu4
 8BScq6V9xnkq9+21A2gNlxiswDpQJAcghdKIjLJwA1v7w4/BZ5MhsHXf+irVMvMArdO9jF
 5LCYvqPyjSnGhHp+2hV6yiWFC4VymxNhFQRB6Q/7F6PRhl0f8szVvMlF7ZMSrHgAvmF+4p
 iiY7LZfqAStg+STs4px6Bx3Abn19R/Jk4yuNEs6Vs1L2ZOk+zOPj9CpqwUfA
X-ME-Proxy: <xmx:2eVbapjscwLSPWIwSjUSyqkOX6dCeXvsNCmdRYuh5eLNHxwmOfKpOg>
 <xmx:2eVbakDsn_byBWdjjs-bZvWEY2KjeY8XItHzwqxe6VM2UtNC1W1cBA>
 <xmx:2eVbamsNoi9WDfh6Q56eBctOTuJ6vSCITnDdJWGYL4RaxXiKnk3mqA>
 <xmx:2eVbapYhjDCh2M9Ev0hir_nYrB3LeJFH9x_dn5BZY0gUsP5Bp1nq6w>
 <xmx:2eVbapyWnEf-zorfBhJO6VD7LpBer9AySy0HYjR6QxWrNDGZb743fM2F>
Feedback-ID: i47234305:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 5BAFF2400098; Sat, 18 Jul 2026 16:45:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sat, 18 Jul 2026 22:44:52 +0200
From: "Thomas Monjalon" <thomas@monjalon.net>
To: "Andrea Panattoni" <apanatto@redhat.com>
Cc: dev@dpdk.org
Message-Id: <ad4d60f6-575a-4e30-bb37-861f02ee1915@app.fastmail.com>
In-Reply-To: <20260603140421.3023794-1-apanatto@redhat.com>
References: <20260603140421.3023794-1-apanatto@redhat.com>
Subject: Re: [PATCH] doc: using container to build and run applications
Content-Type: text/plain
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

> +DPDK can be built inside a container to provide a reproducible build environment.

Changed "reproducible" to "isolated" as it is not always a reproducible build,
especially with "FROM fedora:latest".


> +Once the build completes, verify that the helloworld example runs:
> +
> +.. code-block:: console
> +
> +   podman run --rm dpdk-builder /dpdk/build/examples/dpdk-helloworld

Hugepages are not installed at this stage, so adding --no-huge is required.


They are small changes, done while merging after a quick test.
