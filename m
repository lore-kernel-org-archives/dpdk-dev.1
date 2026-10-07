Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B3FCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 15:32:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F97640EE5;
	Wed,  7 Oct 2026 17:32:16 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7618540265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 17:32:14 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e608cd460eso5706745ad.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791387133;
 x=1791991933; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cxSddKYOW6OSKpvDO53vTYSlTpyTZbftt5zETkq1fIs=;
 b=mjdoI1y6xx8e+tNx/Xep32T8e5+4sUPgvaOCJfnpxSKEsfbrH1buAd2InFRkm4iQfN
 IYtbcbm1QGSXrn7xPswTIJQSgJ1SSVWfu8Pdg+FXl1QNdxqzUybJlly79XKrsWYkG59v
 ICtf45WJl2t5//hqEHDJ/rHk7fYRXGXUBYAea815XWRbJnS9XX6jN/EgMdLEbCabflbR
 HTfVXvpTey+8HAnKet+b5iMoQIHq+Iqc1Tyt5JV2y118Taizis2/kwDnE/FhEvpP++kh
 lKNs4o23BxW5m6sxczKF08NP95DDdc8nItPxF41qo4PJMbGj3qY3IUkLm74ltCD4Vudy
 AIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791387133; x=1791991933;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cxSddKYOW6OSKpvDO53vTYSlTpyTZbftt5zETkq1fIs=;
 b=hpIkkfrAI4w3Gfh7mFXiNJANMJryyYJp+BsPFN3/FLqDaN0k46rAgv8EIdu9qhdPWF
 69+nF8hHWB6naddLQjV/mcYXFZPVcXpF6zpw71zRJx8I8RLkV9LDz4YBHVEZfRoHV8BG
 +wLO+McSzJ9qcXl6PMWBQE2A3P81VraovM5pfKOaGH9e310ANnRw5LTi5WDiePmdxzUc
 apy5T7j86NJ1lsQ2klXPFT+UO43x4hHRaag/i/x9T6PCcxR8/cnHJcN8DGyAm8sJ85gU
 2+UPOo0B45y/LteCv/xaSEHED4Ql1nyCjsIEmeOnOmztqvyN/tZ0GvXaZUQ45+eNgFXB
 feww==
X-Gm-Message-State: AFq9FYJ2WVRfSmKeuw7vmPjMch7yZ0YNTQXKsRYnSSfpvATcb3Zns00c
 TUq67Oo9xdazWXU8UT+On9Hq0P5LzPAh9B2yHtPeel1g/2s4g7obOS/MTQI/H/zCuKc=
X-Gm-Gg: AYBFou2jHwV2Ok0rAAC4oynSnzFEfvGEa/EuejVkGYVro2XDWnkg6P4ohsCB+9k7xez
 SXYAO7YaEK7sx/3OUzdctQb9R7mLlePmEqOuC/9vKqXBPOK3ZHVaZBwFCm0FdLBf/SITeMwvZ3u
 zup4+wm9/ay+n5CdlD4awTw7xxKlFlG1BdiIw41j6RPHDLR31N7+r53YEIT62YCkpnGFnmfmisA
 yp/a8svcB3Y/etu/nk5rd57xTAzml5xD8RaiEminSts2nFxrprHtETcH9wBSXuBMLazNM1ue7dG
 OFOk7TRRFQsA+LKgiV1urbVG/5V/6PN4NfTgmBGs+3IGt5lR5Q45D2w1iBlk3bs/DZWOOqp9OB/
 wCMbfOC4kWumfTHd8vArhVfMETIX1kJssewZWhBN/2Jj0DXd2HrnTxoVt7tLJu6tENj4o9FPJWk
 zNdqIVbvOkJeptkPNDlzHzI/+P5AWH0oWaEYHwknLa8ricqYAugc7nWIEPN/KY4MutYg4CpkGle
 yP5OT3SUDeeGKz24aqtDPB4M6avNkzJ+FoO90bu
X-Received: by 2002:a17:903:3244:b0:2e3:1ed7:d5d3 with SMTP id
 d9443c01a7336-2e60056f208mr21736345ad.67.1791387133359; 
 Wed, 07 Oct 2026 08:32:13 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60494bb3esm13852155ad.68.2026.10.07.08.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 08:32:12 -0700 (PDT)
Date: Wed, 7 Oct 2026 08:32:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] metrics: remove experimental telemetry helper API
Message-ID: <20261007083210.565e30a5@phoenix.local>
In-Reply-To: <asX8y0Nv8APsp8ct@bricha3-mobl1.ger.corp.intel.com>
References: <20261006233144.644562-2-stephen@networkplumber.org>
 <asX8y0Nv8APsp8ct@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 7 Oct 2026 09:03:23 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Oct 06, 2026 at 04:31:44PM -0700, Stephen Hemminger wrote:
> > While investigating experimental functions leftover in DPDK.
> > 
> > The rte_metrics_tel_* functions are dead code. Nothing in the tree
> > calls them from outside the metrics library itself; they were left
> > exported by the telemetry library rewrite in 20.05.
> > 
> > Stop exporting them. Delete the header, move the types into the C file
> > and make the helpers static. The file now only builds when jansson is
> > present, so the stub branch goes away too.
> > 
> > The legacy commands ports_all_stat_values, global_stat_values and
> > ports_stats_values_by_name are unchanged.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  doc/guides/rel_notes/release_26_11.rst |   9 +++
> >  lib/metrics/meson.build                |   6 +-
> >  lib/metrics/rte_metrics_telemetry.c    | 106 ++++++-------------------
> >  lib/metrics/rte_metrics_telemetry.h    |  71 -----------------
> >  4 files changed, 39 insertions(+), 153 deletions(-)
> >  delete mode 100644 lib/metrics/rte_metrics_telemetry.h
> >   
> 
> In the process, should we post a deprecation notice for the whole
> metrics-based legacy telemetry system? It's been superceded for many years
> now and it has a lot of limitations: supporting ethdev only, having
> globally registered stats (so if you have two different NIC types, you get
> a list of all stats names for both whatever port you query), and probably
> more beside. That would allow us to remove a large enough chunk of code in
> a future release.
> 
> /Bruce


Right that was going as follow on patch, but can add it on to this.
