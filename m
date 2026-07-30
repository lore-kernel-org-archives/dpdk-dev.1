Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB48C5516D
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 18:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85583402E4;
	Thu, 30 Jul 2026 20:37:09 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 7DC5F40276
 for <dev@dpdk.org>; Thu, 30 Jul 2026 20:37:08 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3811f512167so191418a91.3
 for <dev@dpdk.org>; Thu, 30 Jul 2026 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785436627;
 x=1786041427; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iy76rndFrs7sMBQv1or0ACMPIIrtsp4QXZj0EVfQ7nY=;
 b=y01aLO8H9TDgU1Mu6KtcbzLrI7liftvl/d2m40f6Q+IX9oQM2cYI4ueSs/6YhoFU29
 rBzQ0hT+1fDLoHxIlfyj2bRk1wWsw4FAnNcVgvxY0wuAiTmZTyooq4lkOmr3R22+Va6C
 9xq2daRFI6LqpminNK4VsQpZn+yEEhc7gYhx2AynMZUQJyk1yMqprzAgyj27uSTk5uQK
 MKau2B4C90JaChqV/pW3RszVKuYrBJ/NTgR2l+H7NWid0WO63cHcop3LY7Q4EPqdl5Mf
 k0Y0AslEcpDrDlQVBSIOT7g/C0WYYFEyNQu9IvT3kvpIssg6cqhU0eh3LSfZf/8UM1fV
 dohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436627; x=1786041427;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Iy76rndFrs7sMBQv1or0ACMPIIrtsp4QXZj0EVfQ7nY=;
 b=gavD+T/SEzmZuCqqTsPnaDStbk2j4aQgE4fing0sR68k5x5l8h1ubyzAwBoKK3ehse
 nS4FQ9RSA/GH7UeaNmcic61z2a0EP9y7IANbrP0SfxOmSFVJEpLu3pIsV5ETO6b9CXgX
 DXQi0hhBmlNvn3VyirQY0fQMU5/InpBxhpyRm//LtXD72Ia4TYdn/sKJrWsxDXdB6jQL
 YVOYTH7BSLG8CvfY/7cTZgj1GUsyeOONIC/hjfFrmvEjIc6VPWlqjkBVIavOqMk/LLHE
 RmfuQoHWqGt0VjcBVqKpTm55bIEOFc/IV6phFLONe4WRrmP4T1RujsAt+Te1/29dN/xq
 wSBQ==
X-Gm-Message-State: AOJu0YwL/DRu7vziGU8twmb7R70RI6Rfh0hqNqpUTwVuc7lEMvKQzszk
 b2afrfaiLxKrmul3XxFjEWs7kI2sQfQRR1sPCoBMifsqlAc8CEVcYK4jtSQv2phnwfpe6KLY9+V
 R03If
X-Gm-Gg: AR+sD11jhbiDRt4tSxeTNv7jaXOSusJhX+kr/5DoDSict74n7huLf6pMZVI8p8x/dgT
 237laS5kgC/if4xF2fWtycS6+B9HjRktsjTOb593ltJaaud2zThOWDdNEAbQsMQdgOIkJ5XE8SY
 T0dumMDYZNs9+h8pJjwkeVDj/7YEs49B7l7DE5Ktg0EO7DinpOSMXJlnRXJu+ov/2chJjsHPX8a
 IQsTGR98cW0fHLokDI/VtMCcFeeVQQT4DM4jpfdm6N/4lxwuKbot7YpPnScCy1fKbbjl5Srbl4w
 290S0ynWImMy+sH79zelJ4D3P8EIFE3RZy4QZyC56rXYKnk9h3ynTAtMRpATLUYwsXdfE/gRSuX
 g5xw9ezBVnMKnhtql6RQppTPvbEPpHPen8LyLBcfCQeVZ0g4Sg1P/3cWxs+EKSD9Z5/kVLBCMVE
 TYDeIhgPspS3ay40t0Dd7JmYxUeXR0666oc6puw1lWsTdg2aJqDqj4/NDg4EIHWs6pCfBUi3Ia/
 ha5biBWkokoW+Q0mGGW2nRqVAoOC3Xx/Xcd7sT1
X-Received: by 2002:a17:90b:388a:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-38f9bd5eac7mr3294013a91.5.1785436627510; 
 Thu, 30 Jul 2026 11:37:07 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm21347887eec.27.2026.07.30.11.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:37:07 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:37:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>, ci@dpdk.org
Subject: Re: [PATCH v6 6/6] port: remove legacy API
Message-ID: <20260730113704.1e11ee4f@phoenix.local>
In-Reply-To: <20260730162311.313350-7-stephen@networkplumber.org>
References: <20260724164520.192203-1-stephen@networkplumber.org>
 <20260730162311.313350-7-stephen@networkplumber.org>
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

On Thu, 30 Jul 2026 09:22:34 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Remove the legacy port library API (rte_port_*) as announced for
> removal in the 24.11 release. The SWX port API remains.
> 
> The sched, ip_frag, cryptodev and eventdev dependencies were only
> used by the legacy port types, so drop them. The pcap dependency
> is kept for the SWX source/sink port.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

The CI build infrastructure reports a failure when building docs
but this report is bogus. The docs build, the way it is doing it
is all wrong. It is applying single patch without others before it;
then complaining.

Wordier AI analysis:

Subject: Intel PER_PATCH_BUILD applies patches in isolation, produces
false compilation failures

Report: pw167045, sid 38829, job PER_PATCH_BUILD19605, series "packet
framework removal" v6 6/6 ("port: remove legacy API"), baseline
dpdk-next-net 9231dc7c.

Reported failure: doc build on UB2604-64 (x86_64-native-linuxapp-doc).
Doxygen aborts with doc/api/doxy-api-index.md:185: error: unable to
resolve reference to 'rte_port.h'.

The series is correct. Patch 6/6 removes that reference in the same
commit that deletes lib/port/rte_port.h, so every commit in the series
is self-consistent and the tree bisects clean.

Root cause is in the CI, two defects:

    The job applied 6/6 alone on top of the baseline rather than
applying 1/6 through 6/6 in order. The resulting tree exists nowhere in
history. Patch 6/6's index hunk has trailing context * SWX pipeline:
immediately after the port list, which only holds once 4/6 and 5/6 have
removed the pipeline and table entries, so the hunk cannot apply to the
bare baseline. The apply was reject-tolerant and the job continued. The
lib/port/* deletions landed while doxy-api-index.md stayed untouched,
and the build proceeded on that mixed tree.

Proof: line 185 in the log is * [port](@ref rte_port.h):, which is line
185 of the unmodified file at baseline blob 9296042 (byte-identical to
main). Had 1/6 through 6/6 been applied in order, 4/6's hunk alone
would have shifted that line. Doxygen aborts on the first unresolved
reference, which is why rte_table.h and rte_pipeline.h are not also
listed. Reproduced locally:

$ git apply --check <6/6 doxy hunk>    # on baseline
error: patch failed: doc/api/doxy-api-index.md:182
$ patch -p1 --dry-run < <same>
Hunk #1 FAILED at 182.

Requested fixes:

    Apply the full series with git am onto the baseline, then build
each commit, e.g. git rebase --exec '<build>' <base>. That tests
bisectability, which testing patches in isolation does not. Treat any
rejected hunk as a job abort, reported as an apply error, not as a
compilation FAILURE attributed to the submitter.

Note for anyone hitting this: a bare Recheck-request: retests the patch
as-is without re-applying, so it reproduces the same bad tree.
rebase={branch} is needed.
