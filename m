Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DF8CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:13:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EDB740272;
	Wed, 14 Oct 2026 00:13:41 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8B98840269
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:13:39 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e7e742a2c7so23357005ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791929618;
 x=1792534418; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ClUeSmJMmoS35x7te4qKKVudZNRSKEDvPGCPH6qtdLc=;
 b=gUlBS8PZE7jm+hi+6rpV2CFgAwhHvM8KRELB8epw/oH/ProdkLEvV+K10dcIbk8qGT
 vd5zBhy79ZpeqGpNkfo4HQAHzTFnnOsPHdmLVliN5DtCNdrk/gPJ9DVTMNUzvvJO+QqT
 cZuKo1EVmLz+nCpTN8zgjkzsj+9pCXWlUMMBuzAg1EZwKaDVCsiT1DhDvssT9AeG6iYP
 cxjYza/iQbvfjgfFVYaJ+975mfKfRYdwIjySi12xrn8X8lNOP7fBRKO7xjNWqQKPQ7tz
 id5WSl4Rjg3Fe1lSUbw+HiwjicnQkJyPC11S7bj6uSkBiPjCyypv6vYYo5rYrzBiA6d3
 zpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791929618; x=1792534418;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ClUeSmJMmoS35x7te4qKKVudZNRSKEDvPGCPH6qtdLc=;
 b=LKfKfNzLwk/Q8aMaPPEWK4m6yd/uGKnOuuc/qXrcSbBor4RHV2V1cR56INHNQUmkAk
 puACI7avatkdnEgmMs2Ca/EhT4CHLBR0JdxhJB0L2axGUsNjLJrz9/+K2p2ef/xpDH+r
 IIdBwZVlYCEctzl6/zYtNB5lEYtjoh1a/czwxBXcj4g4g47p/tEvkV5zLovhn9WjUWFR
 NoNZK6yocT4fGw1c6R/wlWnVv/0H4jBjHJaMtqu0Ryj0l4FrJP1a0hRTkb9tJiefj0er
 6fMQghGrKeW3w6gSe3fd/gj3ed/+DXaYY6p5FjTzvzxznWquWRvqv3IpFU86YbXpC3b2
 6Few==
X-Gm-Message-State: AFq9FYISWn758SMwf6KvFiTNYfktxMW25AqMtOSuxyB8K4DLDU1liCnW
 yQedN3cWQrMaBlV6qx36bfRB3KGiVi5AwLU0peSEcjUp0+hi40/ujCQblEIKc1tYWhA=
X-Gm-Gg: AYBFou0eBeNPUFw0EjUr6MMln/ANmBQwdLFq3b+kWHLnAOB348bK2yUY9XQHcrsldaY
 GBGuLtdrCcWOy8CI9FGnPnqaHjcw32KbG+Ht3IjRntUhj87BkLWJ11uwPbuXTZFNrP5X1AwEJXy
 7FCuWdHCno5MIypOqGLXDuwz0JaPz7MFg2ESHERnZUVwjPgZGpMCkrQkys945BeOIPWyMtCmRag
 P/cJu98uQVKFyG3lYAzfkz6LpzLjvBItSdfGADmxXxOFiObk/yZhN/YGaEJR6wXucVPkOk5cWFf
 qcHeIGbPdCI8bjTOVgtCb6tF6m4k9nY78l0wjDq6CRyImhkGDV3pTPs2rN+QGBK4fvKutlCrwGp
 LSLwijzaK2lKYfn9BgxVGkrvCEtGytWKmko+Z399j4GmlK4FeVl+EKjs7ZWD0k8Txdyvcvwu+f+
 jFpmvPQsQXUpweAH8/FpovRCwLz7TYzTN4h9d2cYFLC1fPk0sxd0ot9pRdyxvwMOOoD2gr+a23R
 je5APZjb+6NCBVn+KxzUn+I36QSki84UuGNx6e4
X-Received: by 2002:a17:902:e74d:b0:2e4:c733:6917 with SMTP id
 d9443c01a7336-2e8404b9ba5mr84309695ad.11.1791929618375; 
 Tue, 13 Oct 2026 15:13:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e841a04012sm62805575ad.1.2026.10.13.15.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:13:38 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:13:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Subject: Re: [PATCH v2] examples/ptpclient: compensate for clock frequency
 drift
Message-ID: <20261013151335.40429bc2@phoenix.local>
In-Reply-To: <20261013220145.880388-1-soumyadeep.hore@intel.com>
References: <20261013214649.878454-1-soumyadeep.hore@intel.com>
 <20261013220145.880388-1-soumyadeep.hore@intel.com>
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

On Wed, 14 Oct 2026 03:31:45 +0530
Soumyadeep Hore <soumyadeep.hore@intel.com> wrote:

> The ptpclient example corrected only the instantaneous phase offset by
> calling rte_eth_timesync_adjust_time() once per DELAY_RESP. It never
> compensated for oscillator frequency drift, so the transmitter/receiver
> offset settled at a non-zero steady-state value (proportional to the
> drift rate times the sync interval) instead of converging towards zero.
> 
> Replace the one-shot phase step with a PI clock servo, using the same
> model as linuxptp. The servo output is a frequency correction that is
> applied through the best mechanism the PMD provides:
> 
> - When the driver supports hardware frequency adjustment, the correction
>   is applied with rte_eth_timesync_adjust_freq() (for example the E810
>   INCVAL register).
> - Otherwise the same correction is realized in software as an
>   incremental phase step over the elapsed interval using
>   rte_eth_timesync_adjust_time(), which every timesync-capable PMD
>   provides.
> 
> Hardware support is probed once at runtime, so any PMD that implements
> the adjust_freq operation in the future uses the hardware path without
> further changes. The servo state is kept per port and the selected path
> is logged once per port.
> 
> Bugzilla ID: 1474
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
> v2:
>  - Use transmitter/receiver instead of master/slave terminology

More detail AI review.

Review: [PATCH] examples/ptpclient: compensate for clock frequency drift

Builds clean with -Werror. Sign convention checked: delta_eval()
returns master - slave, so feeding it to the servo with a positive
output applied as +ppb is correct (linuxptp negates because its
offset is slave - master).

Warnings
--------

1. Integral term has no limit.

   drift_ppb accumulates KI * offset forever. linuxptp clamps the
   drift and the output to max_frequency (900000 ppb) because the
   hardware range is finite; ice turns an unbounded ppm into an
   incval that can run off the end. Clamp after the update:

	#define PTP_SERVO_MAX_PPB	900000.0
	...
	if (servo->drift_ppb > PTP_SERVO_MAX_PPB)
		servo->drift_ppb = PTP_SERVO_MAX_PPB;
	else if (servo->drift_ppb < -PTP_SERVO_MAX_PPB)
		servo->drift_ppb = -PTP_SERVO_MAX_PPB;

   and the same for ppb before applying it.

2. Gains assume a 1 s sync interval.

   KP = 0.7 and KI = 0.3 are linuxptp's values for sync interval
   1 s; linuxptp scales them as kp * interval^-0.3 and
   ki * interval^0.4 for other rates. Here both the integral update
   and the slope seed run once per DELAY_RESP with no time scaling,
   so at -3 or -4 log sync interval the integral runs 8-16x too
   fast and the loop is under-damped. The SYNC header carries
   logMessageInterval; use it:

	int8_t lmi = ptp_msg->sync.hdr.log_message_interval;
	double interval = ldexp(1.0, lmi);
	servo->kp = PTP_SERVO_KP_SCALE * pow(interval, -0.3);
	servo->ki = PTP_SERVO_KI_SCALE * pow(interval, 0.4);

   Or at minimum document that the constants are only correct for
   1 s sync.

3. Step branch leaves last_local pointing before the step.

   local is read before rte_eth_timesync_adjust_time(), so the next
   interval is measured as elapsed + step. On the first sync the
   NIC clock is usually at 0, so the step is ~56 years and the
   slope seed in case 1 comes out as 0. For a negative step larger
   than the elapsed time, local <= last_local and the software
   correction is silently skipped that sample. Account for the
   step:

	rte_eth_timesync_adjust_time(ptp->portid, offset);
	servo->last_offset = 0;
	servo->last_local = local + offset;

4. Software path does not remove the drift.

   In software mode the correction is a phase step applied at the
   end of each interval, so the clock free-runs for the whole
   interval and is pulled back afterwards. This moves the sawtooth
   so that the offset measured at sample time converges to 0, but
   the peak error is still drift * interval, same as before the
   patch. The commit message claims the frequency correction is
   "realized" in software; say what it actually does, otherwise
   users on PMDs without adjust_freq will expect a flat offset and
   not get one.

5. Documentation not updated.

   doc/guides/sample_app_ug/ptpclient.rst still describes the
   adjustment as a one-shot adj = -[(T2-T1)-(T4-T3)]/2 and "we
   adjust the PTP time receiver clock". Add a short paragraph on
   the PI servo, the step threshold and the hardware/software
   selection.

Info
----

6. The "\n" added to the print_clock_info() header line is an
   unrelated change; either mention it in the commit message or
   drop it.

7. Probing adjust_freq inside the servo and initialising
   freq_adj_supported = -1 over all RTE_MAX_ETHPORTS in lcore_main()
   is roundabout. Probe in port_init() where timesync is enabled,
   which also removes the tri-state int:

	ret = rte_eth_timesync_adjust_freq(port, 0);
	ptp_servo[port].freq_adj_hw = (ret == 0);

8. Double blank line after the ptp_servo[] definition.
