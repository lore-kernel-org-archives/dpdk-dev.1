Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399E5C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 16:41:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CD9E40297;
	Fri,  4 Sep 2026 18:41:26 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8C6054021F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 18:41:25 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so1022667b3a.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788540084;
 x=1789144884; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DmQwl/DL10YucSoxfuj7jJncpR1KnPha+mWbg0iY+8Y=;
 b=WxganeBkAmx/pcH3Fomymc7eAe8xfeDMIfjVSjnmZmYtABYLjBeF1tTyMq/e7z/tJt
 8cH+wD8tTKxtgEUdEEzeU7RfLPQZdLRrk6WtkHcoxmZjWLgYyNJr6gpzlPw0efaF5Qhj
 eJvgMUsFSbbmUCOHTWB/gtNDcwgMqUyXY083bo8wHWVuEnW+mEC91BxVA165QfOcvxjF
 RZCnqCXtExvWB6R4kJcN9MTeDdehI7uCzgWpP++C4ReNeEoc9jeaSVX9M/3XLLq6BsYK
 rbkQhEd8UY82ly5PO7EZHXAec1WymgWbC6n860zxaGIX60PO28ekRbzk6prT4ZeCd4Pn
 oYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788540084; x=1789144884;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DmQwl/DL10YucSoxfuj7jJncpR1KnPha+mWbg0iY+8Y=;
 b=TUsDL7IMmfjsBWFZhyXm0yB2TPBAkTGyNnv61bdCuX3pyYstFnohJc8Z6wNZVF9ZrS
 AKbpWZXSnMOJHrqrLEy+nDrdMIbOBVwGf64upUTpg+F+Z5YVstK+BX/TnRxXcAdMj9q2
 CuxZlCXwVYJH4r6h6MqQksNbPOnPF4csMH+Kn600nLEy+tEQXpMF99HuEyGMjOLHSg/M
 Ho1+68toFi9RbCq7DDseYuusgvdVzCJLOhbp7RQScqy1dbsHp42coEE+8mgKUcTniLit
 gIbBnZAQf+0X+1ApbznhaXGhpBR/1SKhAJTuesAPCHEmbuAN3TenwbE8k5+oZQ0en4ay
 xvaA==
X-Gm-Message-State: AFuF++mHKZnMOinwXI3UhurG8REqclyysS+cl0Qtoa+TFGB2lCJf9haW
 LggevuUOIIrVK2IE1QpOBsfeZ1QwzVm4C0h1M1QhNWC1uF5hQKJSKt5H9Lsm+ZtnLcs=
X-Gm-Gg: AYBFou2FTb+ttsRkdfYvijZMAuX6a+Uk/4bJEXjHT9z4HHpjQ0MSgIpj5NZQWTcQKw7
 +17EOAAJNfOoywCkOmYh8pvtKAatINAo7CxURYP8/b0eX5NlftpkvIww0zceaqB9oyRcrQK3k1T
 h8T7y8TH82bbnBrdno0Q+q1I+qgb88kL29HGp9L7VZgnoTgwxx0P4TIODy6I5h2dbDZzcI9T3KL
 k43NvzNyeMyUB7GKdTWgmUChEjtBkQnXslm9MH9hsUyD/Do+krkkUlNvxwLvfv1vsnmXzOf+0jG
 UM2RQZuF0TfFLGmUSlgid7QUO3dsZxj9vNNjvBPPf80J/3BsgaOAvjyM9DzFeqiISSNygUtBbMo
 PkE/u1YStuB/fS0vKvvdEfA93Ui1g1VKCum/a82TWnDpxkK42No3zi6TYPdeWfo5oXnh3kToDOo
 DuV/ABW8h4aXNCmdbIWfXzy2lbb5CGF3IlR7iDoDQ4l42Fzgye/8DDR8ZnVyeHlESk7abcMw4dh
 3TicUUsySGsLLD/9GbbiKI8zgYH7w==
X-Received: by 2002:a05:6a00:1d14:b0:857:72ba:ff10 with SMTP id
 d2e1a72fcca58-8616b865a38mr11529630b3a.24.1788540084453; 
 Fri, 04 Sep 2026 09:41:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86265451951sm474267b3a.50.2026.09.04.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:41:24 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:41:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] app/testpmd: fix stale queue-count check order
Message-ID: <20260904094114.532d4d96@phoenix.local>
In-Reply-To: <20260904133842.3155785-1-ciara.loftus@intel.com>
References: <20260904133842.3155785-1-ciara.loftus@intel.com>
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

On Fri,  4 Sep 2026 13:38:42 +0000
Ciara Loftus <ciara.loftus@intel.com> wrote:

> Currently, when setting the number of queues via `port config all txq/rxq`,
> testpmd validates the requested queue count against a device's current
> queue-count limits, then rebuilds the forwarding stream configuration
> before refreshing each port's cached device information. The forwarding
> stream setup step re-checks the requested queue count against that cache,
> so it can still reject a value that was just accepted if the cached
> limits are older than the freshly queried ones.
> 
> This is not observable while a port's queue-count limits stay fixed
> for its lifetime. It becomes visible whenever a PMD's reported
> `max_rx_queues`/`max_tx_queues` change after the port was first probed,
> for example when a driver recomputes queue capacity in response to a
> traffic management (`rte_tm`) hierarchy commit. The stale cached values
> then no longer match what the device currently reports, so a queue count
> that is actually valid can be wrongly rejected.
> 
> Fix it by refreshing the cached device information before rebuilding
> the forwarding stream configuration, so both checks operate on the same,
> current queue-count limits.
> 
> Fixes: 0c0db76f42ed ("app/testpmd: separate forward config setup from display")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Applied to next-net, but rewrote the overly wordy commit message.
I chopped it down to two sentences.

You need to ask AI to generate concise commit messages or you
get three paragraphs for one line change like this.

Also, I don't think this needs to go to stable. It is a theoretical problem
not something actually reproducible.
