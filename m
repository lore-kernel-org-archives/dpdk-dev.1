Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B0FCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D16E40609;
	Thu, 15 Oct 2026 13:55:11 +0200 (CEST)
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
 by mails.dpdk.org (Postfix) with ESMTP id 47C8E402E4
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:55:10 +0200 (CEST)
Received: from [192.168.0.40] (unknown [37.228.233.98])
 by smtp02-ext3.udag.de (Postfix) with ESMTPA id EA374E0340;
 Thu, 15 Oct 2026 13:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792065309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyc1RSlZiNA5fSMM+qEXiwvcJ6rJjAJEJ9ba0up2MUo=;
 b=cap+KnTeCLc3q8vKrIjMXhnQx/xEWw551/4xDkpwWeSbO/S07JuTIDgQiwQrKfaEYnYhL0
 2ap4nEHQluAdfVKUC83JdmrnjVjgH0ATyc9vKmWcFQtp0rQH/+czhvVDx8ZUstJsh4OEX7
 IwuNJ4T8qpJRYpAJ/al4zXsOC3QA6pzBZoeeIrh0eE8HtZ2hkG/x5CLoTG44rYy95a6N+k
 K/061pi33SAtHcKtl7dblMyYILfehooeq2b2/uBKrFO8mPzAs0ek/+DOOoQ8xFn+vGIACh
 LKwkKcguiYh2WL8L90bo0M68BVmbEXZNMGBmc8RSO7QDXKK6rtJ/EC/Fs+uuyg==
Authentication-Results: smtp02-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <c246d8b4-5bf9-424c-bb10-803f17a9a61e@dressler.pro>
Date: Thu, 15 Oct 2026 12:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] net/af_packet: do not return outgoing packets from
 rte_eth_rx_burst
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
References: <20261005002809.1676723-1-frank@dressler.pro>
 <20261009151015.742011-1-frank@dressler.pro>
 <20261009130359.0dc2eec4@phoenix.local>
Content-Language: en-US
From: Frank Dressler <frank@dressler.pro>
In-Reply-To: <20261009130359.0dc2eec4@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/9/26 21:03, Stephen Hemminger wrote:

 >
 > A separate, older bug turned up while checking fanout_add() in the 
kernel. get_fanout_mode() always ORs in PACKET_FANOUT_FLAG_ROLLOVER, and 
the kernel returns -EINVAL for PACKET_FANOUT_ROLLOVER combined with that 
flag. So fanout_mode=rollover with qpairs > 1 always fails setsockopt. 
It’s not part of this series, but it deserves its own Fixes patch
 >

I agree, this is an issue that needs to be fixed. Another issue with 
unconditionally setting PACKET_FANOUT_FLAG_ROLLOVER is that packets 
might spill over to another queue and then be received by a worker that 
does not track the flow the packet belongs to in case of per-worker flow 
tables. So I think that it should be configurable.

A related issue is with the PACKET_FANOUT_FLAG_DEFRAG flag that is also 
always set. Setting it can be harmful to IDS/IPS and similar 
applications that want to see the IP fragments as the come in to detect 
excessive IP fragmentation and overlapping fragments as is used to 
bypass detection.

