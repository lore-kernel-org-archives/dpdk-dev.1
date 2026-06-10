Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B3CD98C5
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 23:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3E7642E81;
	Thu, 11 Jun 2026 01:14:34 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 3F66D40298
 for <dev@dpdk.org>; Thu, 11 Jun 2026 01:14:33 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 819E5EC0375;
 Wed, 10 Jun 2026 19:14:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 19:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781133272;
 x=1781219672; bh=U9u+LlFKa76kM2wViADU5131MpEDuooZU4mLTgi8CBw=; b=
 RWy1pefix+LeQncMzufGi3ZZ7mhUA0EIIV2e9OPSM8npkIQzRhBKEiGdWEkS2MUt
 oV52BhfSvA5SN0DzVoNxjKnpIY1hQXjjFkAxIa9ai7JNltCFDcGcXfu6YxLCdJrS
 E62EP7jILUIZFN9wEwcn3geMEqkkBuG484AhAJMQyNo7hc5JJk8EFGmq1JsvS4fb
 +wmy6l1Olb2WAsJmuVQFg2TyeV+zc3/yKGWwmyUY9CMYs6sZzapEa4TnjND2cv+t
 v6wGuH1PPDZ1Je/yZV/p6hEfhyQMdPsSa9c3VXw2ftbMT1xRACX4oLxim67ATJ67
 XpXlMeC2uWH0B801H87zaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781133272; x=
 1781219672; bh=U9u+LlFKa76kM2wViADU5131MpEDuooZU4mLTgi8CBw=; b=I
 +HkNWRgfIfSFvYKq+3BtHThRjpVt56KxB33fLaHA6TYcbBcx/qhMf/IZ3QE7QEdB
 iPVNH1mpe2K6kPveymNN1fGy26FaIJNX1TWymblTU95BYWmOoO2sa0wKGqHLa3R4
 B2FxFY6Q8Csb/KVo3j0BHQ7gqAwToBWXUwublY1bge6qpmhD7L+QB9qBQ59/iPS/
 qcCyk+yROBLOGVSIT5Ms2fCkxtL2TpeRDEjuXMfbNFe2ayShFbxHD8l0Qihnm/Ia
 dRJ2OWnMkqsmbAgODEwWplQjoZ461kznOYakohpyj4UbhL40DwkSX4NkT04w4F6m
 1AqQmD6sGRFXm2zA5l+ng==
X-ME-Sender: <xms:1-8parXtllBQgss1jFKuikC3i1ROrKfv6uCvu6F4YQnrcBRd3KsSWA>
 <xme:1-8patoz_VQcC3kaDBsNDSU7GklVM4Z911ToCDZA3u07EuVNloR89x80su0Qk3jan
 J9tUifSSqPytXtzvjH2ewKW8Xw4mxY_KSxDhwA3zhAQ9C9hMdM_A9Q>
X-ME-Received: <xmr:1-8panRLN_k5TAnOmUgVbLuTwsjbf1Sd0KHeMAQnhA1MFl_7xdikLYvxOIAJl1SiIjnoQ7wKUzZ0zcbPDpTsCh5grA>
X-ME-Proxy-Cause: dmFkZTF+8BrhsGIXImlT8fW0n1bYYW+WKOr1S1qF3rgXZLYehvwH0NL1xNagSw3HagsK1Q
 smtpR6vemEenBBIKbCMfCc3l+uzTmYAMVmIlt1r9jI9O9gQ3enPk8jl5ncakGeQHecGk3A
 gNyhXeaCXwjg4PV/PCsxm7pKg1G0j21cUJq9qewZFO1Z65BJ40Ry0envKNGYiiB8Axksfs
 YFHNwEkt7/c8aLpSzpP1ITcQhGTgWhwDsJmoX3g1kA9XqFovkTER7sbuR76Zwu+I3UyG5/
 +eMELFLwWc1GCgxaxRDbcT3dSjYINA2hySdTM2j/PqzqOyBhuCtaYL+hWrrVkc896KTrFO
 xB38chTNHCzDoRMhOl7xb8ywZ2Dhabp6Jeb+sZidIId7K7Gx2v6NORJf9+z+Eit02nHemy
 mYas2OUlmiyt/6rPfnN79oQL/lDjW4STTtBsvyjun23p8YqxFG/99MtrBQaPWjmxL0twc7
 MRdSE1D/5XT6DVphY7yI3Vl63Kyjh/LSRGY+uJ5j/i6ToYD4UlhemntA/yvyvICf8YJFbj
 5sIIcVcTgLsCJ/Pavw6VpPrLUamowW1J3iIblkrWE636per6rUEatSvzDNzBSyNEsiaTVr
 ubiC21pLf7serUJdoOlNnXOcH/pY47QEu7DazFfC9kQ9jKFmoHzVmBI4iCOA
X-ME-Proxy: <xmx:1-8pan1Trn9x0fZ62IJsVg84Ghbwqv3EO7EEmWzt1bBRa8f3SoE_bQ>
 <xmx:1-8pajCYBO2MKY-fb-xW23fOlndw6c7enA9xM3_3TqnQd-7eetz4jg>
 <xmx:1-8pajgK2WxF3RNgcx_COTPQisXns2rhgc2Yp2FQWOIuku0i2KoZBw>
 <xmx:1-8palM4dnufDYRZvg9B0xly1u-LsXO4u2FzlcfZs1F-LfhHoHbThA>
 <xmx:2O8pau2S4F-gyTmisMbdvrRTve4lA5fRqUbE0HEE0H7m36IZTzdBNpbR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 19:14:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, dev@dpdk.org,
 stephen@networkplumber.org, yangxingui@huawei.com, zhanjie9@hisilicon.com,
 fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH 0/3] power: some cleancode for cpufreq library
Date: Thu, 11 Jun 2026 01:14:28 +0200
Message-ID: <VaVADm5kSu6Idr67_AZUrw@monjalon.net>
In-Reply-To: <5a7c0fff-515c-425d-bd25-538cccabfb09@huawei.com>
References: <20260509084503.2917038-1-lihuisong@huawei.com>
 <5a7c0fff-515c-425d-bd25-538cccabfb09@huawei.com>
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

11/05/2026 03:10, fengchengwen:
> Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 5/9/2026 4:45 PM, Huisong Li wrote:
> > Move some common definition to common header file.
> > 
> > Huisong Li (3):
> >   power: move power state structure to power cpufreq header
> >   power: unify decimal format macro for strtoul
> >   power: use common decimal macro definition

Applied, thanks.


