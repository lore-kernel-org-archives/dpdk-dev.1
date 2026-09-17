Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35ACC982CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 00:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93FFF400D5;
	Thu, 17 Sep 2026 02:21:42 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 037434003C
 for <dev@dpdk.org>; Thu, 17 Sep 2026 02:21:41 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so220325a91.2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789604500;
 x=1790209300; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zCLXygMfKxOb9Whk/QKCq9BpGHjJBtmbGDhAdQwOtsQ=;
 b=whnUh5d6pgs/k7OtJgOoBgDp0AkzWD4hg27A3+xcH8yJF5Y8g7PA6v988e6Al3RWyg
 ZAhUVJ/F3r2XFQGKE1jOWLqwhQLmhLmy3+0tRPwepYK8gNhzhHBwChD5U517KFuW1IIS
 xDfwcEe2lUJpnYykqYTgzT+iEi3szaJLEfWzyiprTP/NK+A8TmaVK6YJFDEB/NfSJcJE
 V5GPZLfcZ9m6fqGp8wi76LJjKrqmVtNEXk3iNOpHtZR5Rh5wdXOzkNv9JyNmZlYBKwmy
 AZyfWAbtmt2q/jM5ICxMmn5xzARTSHHkZ2weo/ryCippdAtOknjfFRfhwIhFmUJtcrWu
 IqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789604500; x=1790209300;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCLXygMfKxOb9Whk/QKCq9BpGHjJBtmbGDhAdQwOtsQ=;
 b=zUth/U9unb65lsbKSiDW58ZQ/cbTTS6FHNnkjHsPWjiU5EFMU6P6N1V7ScEZxKxwO6
 P5K7p+drT3QHQgkH2OMtk9JV5AxX/kDokriMVXZ5BRxHCg/ZloDSzzOmcX3/R+ruRXT4
 8en3TZO1bSUF/djo/uWx7wT40z6xSORzBsdAG+hY2k9DxmRPusO1Pg1vakXmQoDzL5SA
 zH4yWzGNhfB0VwTepVnPrnvH7x33smW14hVkOMZjaUKT+ZvnSLzdEvLZo5YU5xa2lvOp
 R+GRuqMc2lsvwj4dwi/1dixKVy/uMzbEx/zjne6YpptdfOf8nahozVh+XW881TMMhtTw
 tprA==
X-Gm-Message-State: AFuF++lITxVMrnHRnvDm9Pd7sdOkeXWk916dwCqYGvO3/9k/oJDaRoaV
 oVcHn5ddvWNRBUg3KSne7p20JTHrJPYSdRtNwbxuYC38X7PBcEWbPVdOH19mwW6ugOY=
X-Gm-Gg: AYBFou0q7gtrgi9tXM6jDvplS+vwgOvdXe2x+X/ZG80LjFnblbROb+llfzCWBtkw2Oc
 jhW4JMSficGRyl2bUlwwGECymeiwKDrZg6IYVdDtUI6CNscN7xOh7QvPlgtnAnKitz3wxCqyHsg
 xbZpzmRell82H2Q7UBV3lQ1gAd7PYIMzmHMEkRVCA00sMM+KhLfu5MT7L4l72dbqGvq8r568QCX
 UxizlwhZLnazX3Ot8nwNPNjfQhHNsFsKuy8m0lBNPq+xtyfP42Xv3SzCNelplXDtyGPBlldVBTh
 w7sB/m4VhNWXLGJ1ybMOLUixuOBRRgqo9Jmrwk8+5h9YZBQM/zea02wedvFxru/GI8eb85V58fh
 cEKapC33OKLanEOmFGe50STddfrlJuCjqFjIJ+j3DC9W26h/cfLmhIWwRjN1ZVcp8NjMCUwPMws
 FJxtrZGhh3ZmlitdvJlhFcU+S/sLC8BLS7lKbKQiutMyTX4DSJ99MIqlfNAOZtP+7T4K2OBKc/G
 THtQxuTL16H2v+jWgovZyWGdSeWDG90MmXaDeWe
X-Received: by 2002:a17:90b:56cc:b0:39d:eac2:7bb1 with SMTP id
 98e67ed59e1d1-39e1e26378amr13349497a91.4.1789604500041; 
 Wed, 16 Sep 2026 17:21:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35d9f81asm1898364a91.3.2026.09.16.17.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 17:21:39 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:21:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 01/19] ethdev: add flow graph API
Message-ID: <20260916172134.4a6e37e3@phoenix.local>
In-Reply-To: <b1982ff795e9db6f7fa34992573f7bad0294f77a.1789560944.git.anatoly.burakov@intel.com>
References: <cover.1789560943.git.anatoly.burakov@intel.com>
 <b1982ff795e9db6f7fa34992573f7bad0294f77a.1789560944.git.anatoly.burakov@intel.com>
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

On Wed, 16 Sep 2026 13:18:07 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> +static inline const char *
> +flow_graph_item_type_to_str(enum rte_flow_item_type type)
> +{

None of this is critical path, it should not need to be static inline
and include. Build it once as part of ethdev.
