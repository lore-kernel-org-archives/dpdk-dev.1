Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBB9C4451C
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 13:36:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4178640A6C;
	Fri, 17 Jul 2026 15:36:32 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id D9BB4406B4
 for <dev@dpdk.org>; Fri, 17 Jul 2026 15:36:30 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 4E290EC0169;
 Fri, 17 Jul 2026 09:36:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 17 Jul 2026 09:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784295390;
 x=1784381790; bh=1tMb0eKUdRyNUGfqgwrJ3qNHkXEW3N2+HkHoOYgbKLU=; b=
 OV1h/E6aZkC814Sv4ktWEfuNQgTe+x/neMo3lrBGDb6aFHmInCNYa3ErFizNXnFJ
 NMXxx2BUJo8kBgzF6IBAk2nzyDkvNf3azf/HhILQuV8332mJ63Qh66L934saa6dt
 TC4HUgp6K+tTKPIFE/WLXMlp81ISXPpcBT/02+zlPviVmxEz3Pc1ggboDLF8PaNx
 1gtomNfaOHqyyUwHTIioM0m5D1akpIpWW0r/WCCfG7nCGwdvrUk9TL8O3UdrzVnT
 vXJXaqVlu+nmFcqk+C62a1bWD9e4Y4q/z5KSnIIwhXQmM7UBAAVGfpVJN6IGHkfm
 GopiBp3X62px0PfG1xdbxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784295390; x=
 1784381790; bh=1tMb0eKUdRyNUGfqgwrJ3qNHkXEW3N2+HkHoOYgbKLU=; b=M
 u/yGX/tW2a2TJFFkCNvC+w0VrfrHFkVSLRRgmLc+TFyR3VLgdqCNUAnSu+EYsvYJ
 46s24EjmHRGICLaDfNhDQU6XdNQj6GVEzieRlFcq5OifFkTeMEr/3UGAO/1WzaGk
 8YeAfpWHBxqeXWco6DnyWpVtbAU+eUwx/dvGQFHK1ggG5oaKOuWxGEED00viAwg6
 gpD3Rg/Kp65Enq66BQB5Yzd1v5PVK6ahzQCSHIHKJczVdoXxs4h1k8o98BXwMJMr
 Qa4u/srjOEQ7SU1e8JIHM99rdJ4MhBrfkzEHiz1JoFYU4QDWauWEAgoQ7p3WTasS
 tHRr97klFI1PNapz6ytyg==
X-ME-Sender: <xms:3S9aaqYeg0yra4ax5g9VvooN5hIzTfskA3QiVRzC89hlLcgFgSkimA>
 <xme:3S9aatix9qDA5_9bc8bAe4lppLIyIKJ-DnM12oKfphkkLFcezl9FIfdEteqElZiGX
 NwHrW8E01gPOWnqAhWtruIqZ50UcTiMS-i1ZDkD-H-qAC99T7YA4Q>
X-ME-Received: <xmr:3S9aas7SxN2UcOD2_CYiTwTcXXiBke6_q6GsxEjpYVTZfGnqQc2INKuwH5WndObZyE7-z31fCmlQuQQWcA>
X-ME-Proxy-Cause: dmFkZTEgwglvb1O22yCA5vtyx7+Rml1oVbBpfyxNb/xxI+slpxNMlWAeHbaJYbj0bAh1AZ
 HrIT8hSBe/TjAKfyRa00FbWtY2wXJDhlGDz30oll6uxwMtHQUSQXw1mxphHNeHL7NvVWDY
 U3bVH6VNCZChhL0iy/6nJq/kL/Ew2qNPLgxTOIWnDeAUs+d0xJt7kW6k2oMYf8FtkDfdzz
 tC/eQIh8oaCWwvRfuuFiXwbUp79v6tlRpJOI77lUKOEgX89IWfpTUKyk0ct9XLWX2jWdVY
 IqE5sWyx+t+9duzL4yzpswhNl3QxS0HtRoEodWeozxmxlrT+cxns3aPCLIKhexeOE37KO0
 NUQv+RVhczy6jcfBo/BZYV/iVGxqSCVNFTIvLirVEMjdaJrJykEr6mz6vnPqBbWa1PhzTs
 4FvI04ZXZ9IJd+Y2N1cYzVm28JoFN7un4qTDZBmTyGNRBYuPtTSJE4+5WSCZp4CLQ6qzDa
 NO+Z8s2IgIJ5S3jViI3aCGUqx9unlDTZm1EPKUiebhb16MjiudKshIxJvaPBwwtsKbsp3i
 x4lCEXhC3Tj88eAg4y1tYPYLm7/J7OHzEdygLBW6QhEsZVBkgTBMUlYuRyrvFppIR2GDE6
 +djej6Iex7W/23SDEKLtWTavC7p20rJgNvyA1C2VslbHSeJV+S/lTZp3O+hQ
X-ME-Proxy: <xmx:3S9aak6WSZ879clJH7TBsNRRNAuXJ0KvwBT0CTP62WXZ50updVHC5g>
 <xmx:3S9aagchMZFlu25yhXzxSxFs-rhp67gsDHA25jvCBN9JJsMl_JlkPA>
 <xmx:3S9aagBoK1MC-E6xuPyKW8spQ1T-jNw4tbnThU5ga7LlV-HPddRjzg>
 <xmx:3S9aar99LPbNy6J7qVNibuffOerYo7PKetcBJQKn0vVrExNJjg9p3A>
 <xmx:3i9aasGPP2hqLEvqudIIMTKg4gJYwpoPJOhdIUy_E4T7uPyl0DkZc96m>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 09:36:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Robin Jarry <rjarry@redhat.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH] usertools/telemetry: load aliases from config directory
Date: Fri, 17 Jul 2026 15:36:26 +0200
Message-ID: <nVqd4pYGTXa6_1pd3y2nwQ@monjalon.net>
In-Reply-To: <aln3w5hRyGXhJas1@bricha3-mobl1.ger.corp.intel.com>
References: <20260717091603.1492650-1-thomas@monjalon.net>
 <aln3w5hRyGXhJas1@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

17/07/2026 11:37, Bruce Richardson:
> On Fri, Jul 17, 2026 at 11:16:03AM +0200, Thomas Monjalon wrote:
> > The default path of the telemetry alias file
> > was at the top level of the home directory.
> > 
> > Load aliases from the DPDK configuration directory instead,
> > using $XDG_CONFIG_HOME/dpdk/telemetry_aliases
> > or $HOME/.config/dpdk/telemetry_aliases.
> > 
> > Keep --alias-file for users who want to provide an explicit path.
> > 
> > Fixes: 410d498412e4 ("usertools/telemetry: support aliases for long commands")
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> Tested without moving my existing alias file - no aliases loaded. Then
> tested after moving to .config/dpdk/ and it worked fine.
> 
> Doc changes LGTM too.
> 
> Tested-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Robin Jarry <rjarry@redhat.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks for testing.


