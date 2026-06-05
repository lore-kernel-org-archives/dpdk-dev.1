Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F6CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 18:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F22FD402E0;
	Fri,  5 Jun 2026 20:15:48 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 8EB654021F
 for <dev@dpdk.org>; Fri,  5 Jun 2026 20:15:47 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30749947917so4534083eec.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780683347;
 x=1781288147; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugztFNk8vI6uDddSDDdYkaToFP4YB5r/AV28IcwkGLk=;
 b=LtMjJswX8f6bIIr2a7pG3+97B4WPYC/I47W+eu5ZnU6lGFC0Tsiprf7nlnt6ANKWlI
 Yf2Lekzm0oOLGjtrbX77w1upq5FcReRTebDi7hBP6maw6+G9QQs0OEIagemdnYQ76fl4
 Y9zSuBvns0J0PZEcKeYhxG6WZ06UOl3PM+q+PATRS8WQkXgiM0RsXwYuUDiRhzsGxCWY
 vNogRXJx4ZAfj1qx7PdGrYXbihOTfh5frevOUsJK4U/wn7YZjZXQXi8rTahSTmEKLSvA
 4rHHRbb2IMXID5rjb/B5JPEfLBslbe47DIHb3JWIdfvkmhnT2uDOpOhVicqHZXlo+fZj
 bKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780683347; x=1781288147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ugztFNk8vI6uDddSDDdYkaToFP4YB5r/AV28IcwkGLk=;
 b=Ci5cVbK2cvd70SzCIqWh1z0KIysq9tY/Oh0hLd5A4ijLI2IPpoktdR1AlgGVYtaJGY
 ARC+HYOWshA8zQ9qWh8kUQ+4zJCM9e5hLQ7QE6zJVcG3BhSFR6lpJMSZLhCigBenqKyR
 5vZK4gbo8UH2umNhnZtANaNGft1VGfGzU5Rgm06HKKb6eu8N6zZjaKS9i80E2fKBtu1V
 g5Wrb8jv0iX/8zG4gssZRgqSkICMiQCLo7vEGUubWfjnNjXxTseg0+ZlahHSYhHxF5Y6
 VjIOsWBvceLIO35nuY5SvfrZDMEMNbMuuDQf/zmCvL4CP5hY1qG3Q+R/JCC2Ea2LgUHw
 +gUQ==
X-Gm-Message-State: AOJu0YxmKrVXW5cIVfqzKuGjZMWDC9cROs4CYmBqTSA4PQJJNxIO6LHZ
 4/C3nxZX5689ThGIoLG01Lnx4d0st51F/Em67RVRL4UhufiVAQ0u14HTH1XGhdM9M/I=
X-Gm-Gg: Acq92OHCB5Y8ddEsask1LGW1iuj+lGegHpKO+lJFRE61BUtJcsMYphRkc8QvMNbaSfB
 7NEXaZ1koT/OFyyrb5Eya7tLn8RevZnif13iPJA9Xs+szJTHtsI5qKNMKuszKqlAJoQv63xhoyA
 LVN3Vh267a+PB0m0amPfWjyiwb6fWWbXkFOeBBEBWq44lDp+Wul6YM/mZz83xQWIefCvlH1aDZw
 5BW1lXGR14hR0l11b1nEyfy7fbDWKT7ZkEbmbZOFPc+LCDMp8rzGiSUKDQLaf3ywYqMkGqMsjMd
 jeW1wbp4Vn2dwm/4z1h0B0lCTTlpZmnwFyeqH21PnHgkkRy7iE9LI7G2kGLlYYVl48yzQQoPs1f
 yhuEPPCGJdHW8op2Hp9y+FWEN8mezjmvnYX6BCO3HnlIHGCtSRrgXEwyvVovy9jRLjwdmcHZuVv
 qCV1ORSYWvjVL0gj0VCBljFGfBJIH3D6TTLcak2ehN4ILrJqXJetvDThCODtTUGb4akKVW7jxl8
 sY=
X-Received: by 2002:a05:7300:80c7:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-3077b8b5007mr2700154eec.34.1780683346539; 
 Fri, 05 Jun 2026 11:15:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm11815211eec.11.2026.06.05.11.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 11:15:46 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:15:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Jianfeng Tan <jianfeng.tan@intel.com>
Subject: Re: [PATCH v3 2/5] eal: fix async IPC callback not fired when no peers
Message-ID: <20260605111543.6bbafe27@phoenix.local>
In-Reply-To: <843e56829da93b5d7c917e61118acd525196dc7d.1780590727.git.anatoly.burakov@intel.com>
References: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780590727.git.anatoly.burakov@intel.com>
 <843e56829da93b5d7c917e61118acd525196dc7d.1780590727.git.anatoly.burakov@intel.com>
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

On Thu,  4 Jun 2026 17:32:16 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Currently, when rte_mp_request_async() is called and no peer processes
> are connected (nb_sent == 0), the user callback is never invoked.
> 
> The original implementation used a dedicated background thread and
> pthread_cond_signal() to wake it after queuing the dummy request. When
> that thread was replaced with per-message alarms, no alarm was set for
> the dummy request, silently breaking the nb_sent == 0 path.
> 
> This was not noticed because async requests are used while handling
> secondary process requests, where peers are typically already present.
> 
> Fix it by setting a 1us alarm on the dummy request, so the callback path
> immediately triggers and processes it.
> 
> Fixes: daf9bfca717e ("ipc: remove thread for async requests")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  lib/eal/common/eal_common_proc.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
> index 799c6e81b0..5cc15a0f78 100644
> --- a/lib/eal/common/eal_common_proc.c
> +++ b/lib/eal/common/eal_common_proc.c
> @@ -1187,11 +1187,21 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
>  	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
>  		ret = mp_request_async(eal_mp_socket_path(), copy, param, ts);
>  
> -		/* if we didn't send anything, put dummy request on the queue */
> +		/* if we didn't send anything, put dummy request on the queue
> +		 * and set a minimum-delay alarm so the callback fires immediately.
> +		 */
>  		if (ret == 0 && reply->nb_sent == 0) {
>  			TAILQ_INSERT_TAIL(&pending_requests.requests, dummy,
>  					next);
>  			dummy_used = true;
> +
> +			if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0) {
> +				EAL_LOG(ERR, "Fail to set alarm for dummy request");
> +				/* roll back the changes */
> +				TAILQ_REMOVE(&pending_requests.requests, dummy, next);
> +				dummy_used = false;
> +				ret = -1;
> +			}
>  		}
>  
>  		pthread_mutex_unlock(&pending_requests.lock);
> @@ -1232,10 +1242,14 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
>  		} else if (mp_request_async(path, copy, param, ts))
>  			ret = -1;
>  	}
> -	/* if we didn't send anything, put dummy request on the queue */
> +	/* if we didn't send anything, put dummy request on the queue
> +	 * and set a minimum-delay alarm so the callback fires immediately.
> +	 */
>  	if (ret == 0 && reply->nb_sent == 0) {
>  		TAILQ_INSERT_HEAD(&pending_requests.requests, dummy, next);
>  		dummy_used = true;
> +		if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0)
> +			EAL_LOG(ERR, "Fail to set alarm for dummy request");
>  	}
>  
>  	/* finally, unlock the queue */


AI spotted potential issue:

The bug in 2/5: in the primary-process path, if rte_eal_alarm_set() fails for the dummy request, the code only logs it.
The dummy stays on the queue with no alarm, the function returns 0 (success),
the callback never fires, and dummy/copy/param leak.

The secondary path right above it handles this correctly (rolls back, returns -1).
Fix is to make the primary path do the same. This corner is never fixed by the later patches.
