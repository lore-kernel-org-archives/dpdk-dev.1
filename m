Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7EBFD88CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 23:32:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EB6D40E1C;
	Wed, 11 Mar 2026 00:32:04 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id B1E1D40E1C
 for <dev@dpdk.org>; Wed, 11 Mar 2026 00:32:02 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso1492099a34.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773185522;
 x=1773790322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq77T9a76vAIV9SViVR8B3Msif+0ftqkNilkeZyBe9c=;
 b=JXQS7Tae+KZe+knAkF6CsBxH92rvZEVA6uBf9561QYtfKcoddykivajqdMEDckxUsr
 aImOLAgzLJz/3DOTCMYrhcMEjPdvb5ZA79MpTsSxJwEmJqkmKDzSWPNSY9o5cjNB/rP6
 0QtoiNd+GVZnerYdap6kK5B2MnyroxsCV3VcGaV5YQ562+viBkvXejlUG28nhoKZe2N8
 yf5R7LQsukSTtyJlqua+c2ehSP2iCMnLC23nZi0n4GeUHbHvMFer8PPhZqyxLKQ18N9m
 zv52NzKFAs1ym5JwqMPwVvz8tsm7VR1v1WjqnDWlddNwzYgtA1/gDAGpcmwcCn7LgXde
 NioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773185522; x=1773790322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hq77T9a76vAIV9SViVR8B3Msif+0ftqkNilkeZyBe9c=;
 b=OerTlgVuS4II1QvsGVCxLbbq9GsVdO4gyOM2/mkpxWkrgGNV64UI/BOlaIAflO5u4J
 8Yjt4gTYc6gZw3qWXtwht0fZR2P7gLHTp3JN8jO7Xv5iK0hmGX3KREx+drPfU6ksP81u
 I4fPl8VNgVFW/FG5eWjvkiLu3I7yYEWxtWFKrENXmQTSJpwF86dabUSxYDclfn89e99P
 ZgJDDFmHBj6bS4lEz9eP79hNIrRz48NBgV0mZZulmqAtEJD9GtnCmH/0DOUBMHL70CVm
 T3qWFwfL/8LiX1jLGihFfQLIr4Yv4KDbf4It9DlvpJajwdZoLddxoxnejfsJ2ukbZsvv
 uiDg==
X-Gm-Message-State: AOJu0YxLQi0e/0TzjT8U1MR21wDNDg2yDQAwddYI/T9yLqDhjnrLwDSi
 YwGOzIYBemnZ0u1TXGc8s2IGHyw9fV26AEq3KMfDUOqOgw3k36FtV3lZwZwt2UPtaLs=
X-Gm-Gg: ATEYQzxxcRMwMOrymsC/aUpgqan/o58cBUXBmj69UGicw0EtRzE49336FQkISCUBsR1
 Tuc+j2U9RsM3zOMkO68Nyi6YjttQ7cQUGdY1YTCxccdo2UoKLhGzDqWADDi6YEuv5uIKmdfsrD/
 1ONUxrIU7N3NF7pU8PG7r2Haf8hDxtZv0XIjBtviMiYWGctEJskNbwaWeBS+Fe6sDLT1NItTMci
 IdM5PF6/mXSJqRf4mwOU5SSWurSCTqPwsP7Sf1IhBEveGh+UjyAib7rduHGxMsWuswBNRtjjchx
 ogU/EyjnGi7xMal+fMcC99KTC0oHEBIdbPYlWxIVgDkKaQ3Yp5NYbSjILFBeEI5dmTfeo05Lfst
 ytpi2nzjeJRMhn3OiJz/kAaPCvtFJqHY2tSFy2Dx9Q/QpdCiGJMl285GkZbrkp03yvIsH7s5QaC
 r5kapAqdji39aQtrTwlhRb2zBxtD8ORiYInLw=
X-Received: by 2002:a05:6830:828f:b0:7d7:54d5:c6f8 with SMTP id
 46e09a7af769-7d76a75a7fbmr514183a34.17.1773185521827; 
 Tue, 10 Mar 2026 16:32:01 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac32913sm445907a34.5.2026.03.10.16.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 16:32:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:31:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 3/3] net/af_packet: support jumbo frames
Message-ID: <20260310163158.4832e4b1@phoenix.local>
In-Reply-To: <20260309161021.2790684-4-xavier.guillaume@ovhcloud.com>
References: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
 <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
 <20260309161021.2790684-4-xavier.guillaume@ovhcloud.com>
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

On Mon, 9 Mar 2026 17:10:21 +0100
Xavier Guillaume <xavier.guillaume@ovhcloud.com> wrote:

> Derive max_rx_pktlen and max_mtu from the actual TPACKET ring
> frame size rather than the static RTE_ETHER_MAX_LEN (1518).
> This allows jumbo frame support when the user specifies a
> larger framesz devarg at vdev creation time, for example:
> 
>   --vdev=net_af_packet0,iface=eth0,framesz=9216
> 
> The advertised capabilities now accurately reflect what the
> configured ring can handle, avoiding both false limitations
> with large frames and false promises with small ones.
> 
> Signed-off-by: Xavier Guillaume <xavier.guillaume@ovhcloud.com>

I wonder if TPACKET header could go in mbuf headroom.
And also, could the copy on receive be avoided?
