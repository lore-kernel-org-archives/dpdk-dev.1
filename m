Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85841EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 15:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1658402D9;
	Sun, 19 Apr 2026 17:42:25 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id B33F940291
 for <dev@dpdk.org>; Sun, 19 Apr 2026 17:42:24 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso2384013eec.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776613344;
 x=1777218144; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hz7GLAgfNr2KJFo3MBBiXkWQQVklo4xOywNErN5/wwo=;
 b=cqzMtSAmJ5CJsRZKtJRWW16w5JskRgkISzQpq0WGd5aHI0bO8yBU5+9BWqVtzLQlcM
 zZDKSU7tllrbDXfTGaGgYV9Wfj6qckTRutoiOy1BBgi53cELoUC5+mLbjbID7yj4Hf1v
 Cv+SGinZ6P9+38LwQ874ySWDSqDr6tXraqqUmagoc2mkleGHBNOEUcEPduAf7m0Vbgrn
 6Hge5c6ObIqiQFTc8I2vgwv9wPtf5Uz5/ai32OkFk31V+1/6peIKQYP0VE2iLf997Ggd
 yJFhi5SbadlABg/gk9twUb7M0MlvONQKqw02+Te5XZdRylnZiP3WFiWFwxk7zQ0hph06
 zP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776613344; x=1777218144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hz7GLAgfNr2KJFo3MBBiXkWQQVklo4xOywNErN5/wwo=;
 b=Okzcxw3OSB4Xcxnrpk8weMLS0XHgOyLrI1OxMnw85BMgw8vuPNSZJLRXn4m6YRGdjo
 Uj0BEmpxcNjDIX94dDdkslezzP7SiKx/HljG2A3FgQqRIIPPWdVHc6sl51DclEm/4BkT
 eYulmaLrMARSsEq1aCNaRLQRj6bFVr/gKUSCDDWqpSqnpNP9LUv6sGZSio5kOSYOdLxI
 Qt2nkfLFwKVZn5VZ3kHEH0b2lA5E6AnnfoIxjTvSODA3yNOnEoWfk5caVEHIPAtXcyEk
 hJtMaBUPY0Q1nP5QxlE9vR6HgaihCOHd9IeZef7VALqyDVxrfh8f+RoHZImw7X2/sveQ
 X91Q==
X-Gm-Message-State: AOJu0YzuxnrMO+ErZZiLXVG2y5//RTnZC6wQ5asZ8dvgbUSMouZVJHCa
 q/QkWFRFKmV6FkMST0r9zVq0eDS/ds/y6X8FEVt4ZKuexV6ImI6qzwNQxx3Y9hNkTE4=
X-Gm-Gg: AeBDieutI3URZpGPh9T6avYY1psB8PL6CBPYoFdMrxA4uztXB8VKsbSsEtjBnZL5yev
 MKBf/7X55HOUoDUYM1vjWINyClu4RT/oUKfaWNTtk487tx8CmSX2EjR4THCOC35P393Y79alJpP
 woZGobd1LQ0YUjXypbX13jCefCJw8iNlNvBKiRSZwLaHaEqYn1UFbYssHzlbyk9w54CbT3v0RSN
 MH5rJRC+Hdr6on3e79cdnNn2f1YLCUqYf5tOKVtqlBikD+D56I50KLYWQ4ETzLGN5EHEywCJaAW
 WjNFOlZeN2IMyloBjRqL3HfWoLeTtBsy+8gSe7xB6/VmPAeIRQRmizf5S1+G6dyX9QNmoDknmQr
 wE/zzvDofAAGCV/+Gb8RSDt8VByYpwzLJvYhzXns7LPuAa2ivxNwqG4EqDZyeoOURRz0rk9F1aq
 tQimiQIbNUkpPLIP8toF3BF1POe41MUvmjg1vXuYy0IYVOiw==
X-Received: by 2002:a05:7301:1693:b0:2d4:7656:4ec1 with SMTP id
 5a478bee46e88-2e47873a687mr5605806eec.17.1776613343739; 
 Sun, 19 Apr 2026 08:42:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ac84c38sm10524799eec.13.2026.04.19.08.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 08:42:23 -0700 (PDT)
Date: Sun, 19 Apr 2026 08:42:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 12/29] net/ixgbe: use common checks in FDIR filters
Message-ID: <20260419084221.64f25ce1@phoenix.local>
In-Reply-To: <f7545b6d624d42ff490c4e37b73dd5008dd695d8.1775826526.git.anatoly.burakov@intel.com>
References: <cover.1775826526.git.anatoly.burakov@intel.com>
 <f7545b6d624d42ff490c4e37b73dd5008dd695d8.1775826526.git.anatoly.burakov@intel.com>
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

On Fri, 10 Apr 2026 14:13:06 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Use the common attr and action parsing infrastructure in flow director
> filters (both tunnel and normal). As a result, some checks have become
> more stringent, in particular group attribute is now explicitly rejected
> instead of being ignored.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_flow.c | 292 ++++++++++++---------------
>  1 file changed, 129 insertions(+), 163 deletions(-)
---------------------------------------------------------------------
Patch 12/29: net/ixgbe: use common checks in FDIR filters
----------------------------------------------------------------------

Warning: ixgbe_fdir_actions_check() rejects DROP+MARK via the check:

  if (drop_action != NULL && action != NULL) {
      return rte_flow_error_set(..., "Conflicting actions");
  }

The old ixgbe_parse_fdir_act_attr() allowed DROP+MARK (set fdirflags
and soft_id together). The new parse functions still contain code to
handle DROP+MARK (setting rule->soft_id from aux_action), but it is
now dead code because the check function rejects the combination
before parsing.

If DROP+MARK was intentionally disallowed, the dead aux_action
handling should be removed from ixgbe_parse_fdir_filter_normal() and
ixgbe_parse_fdir_filter_tunnel(). If it should still be allowed, the
check needs to permit a MARK alongside DROP.

Also, this block in ixgbe_fdir_actions_check() is dead code:

  if (drop_action == NULL && action != NULL &&
      action->type == RTE_FLOW_ACTION_TYPE_DROP) {
      drop_action = action;
  }

DROP is in fwd_actions[], so a DROP as the second action is already
rejected by the preceding "must not be a forwarding action" check.
