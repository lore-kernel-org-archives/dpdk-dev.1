Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FA60A2626
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WkvsFI0n
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 781CC40263;
	Fri, 20 Nov 2026 19:44:48 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTPS id 82520400D7
 for <dev@dpdk.org>; Fri, 20 Nov 2026 19:44:46 +0100 (CET)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfSRa048804; Fri, 20 Nov 2026 18:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1e3IIM7VmEtX0mPHrRnbsKCl2/+ofgb+kbyapOLGBN8=; b=WkvsFI0noaf93rc1
 lSQHvtRWHqwcrbSi0V3Uc8+eNXTeOvYejderSq1fzQC/1262nMX1vMZsruHfOmBj
 +AtQIXwB9P632hR/lgPBE3DQngtAphZEi19a6jDxAJ0Nn5sbkG7aEn1aev1EvY7n
 HI17TYB8bpIQ9BFvFr4KP9SPW9d3rz3yKisLheysjLru95n7fHveyitmmaOONwOx
 zV+XyzNEiPBQmQdVBhaNYHVS66uss21xtL/HxXqFgsvX60tbPg40RoQuEUWPDwSg
 pSX7AkqBT4P5QvdDbdWmqIBwIj+20d3djDk+IWulajyvxOoF0IKqDbTcrVTPcTwk
 x1h5Xw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4j0j5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 18:44:45 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIgd7W1532618; Fri, 20 Nov 2026 18:44:44 GMT
Received: from hy-srizor-lv.localdomain (hy-srizor-lv.qualcomm.com
 [10.47.206.128])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AKIihFa1535410
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 18:44:43 +0000 (GMT)
Received: by hy-srizor-lv.localdomain (Postfix, from userid 78680)
 id 6A7821DD; Fri, 20 Nov 2026 10:44:43 -0800 (PST)
From: Steve Rizor <srizor@qti.qualcomm.com>
To: dev@dpdk.org
Cc: Steve Rizor <srizor@qti.qualcomm.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: Re: [PATCH v6 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Date: Fri, 20 Nov 2026 10:44:01 -0800
Message-ID: <20261120184401.2954868-1-srizor@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261110120015.2937289-2-radu.nicolau@intel.com>
References: <20261110120015.2937289-2-radu.nicolau@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: ksNM4edLe8tDsm-yaub_i5Rey-0rPskH
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b00951d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EXvF8qN53TorAv7q1MYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NCBTYWx0ZWRfX/Fl89dLserWK
 bfxpDl5XjdVZ0quXZ28gaD5wqE7Mmq0tf1zTRrceLwnDfCn8/nYHLWZYTALC2q6BFSUqd8D2xJI
 r7yGoFIF641N7I7UElcnxoKX4mNmz1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NCBTYWx0ZWRfX07Z9meOk2CAW
 lEswLeRdlwtumqiNGUpw9rR1yrw5mKxOft2HuYl6bCHDWq1O1ac4HxIAVUyVmZRVrC/ILrBjJrY
 wGwMkqDrFEUZYGxUpt/89N4s20G0E8Uikq6dpnWWa4+lfHN2ANxuyP0s97vBGcmXk7uel42glZ4
 SdHTCnD7hvrhLpc3BwYYeHvykjrgaK9jws7k0Tl/7pBf2CjTfYYSt3xxfdlVPxAzjUpBpbIv1nr
 edEZKkuPfPGX/5Cs+XDgEjPb+evJatF++Tarzu72CF5GoDBuO8pVKMKf3s2Oq1N9FLZ98d6pdtw
 a1gPz785nMC6/HtTJRfwoGia+eYM19r6Az+lb0SnzuaJZXfkd1BFinKf8gidjUsIVfOlIRgVfD0
 CHfWBrT4mgowkllVQiDrj0tKgcheF5tkloOu2gD9L9w9sDYAE9SyKhSHxxvY+1z9TzMDEwKn5ON
 5AtE9hJGDocCp29pfeQ==
X-Proofpoint-GUID: ksNM4edLe8tDsm-yaub_i5Rey-0rPskH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200074
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Radu, Kai,

I found what looks like a digest placement issue in the AESNI MB PMD when
chaining NIA4/5/6 authentication with NEA4/5/6 ciphering and encrypting an
appended MAC-I. The same omission is still present in DPDK main at
c36aa2ffce75d4f91a4fe7f082db748e1f8854d1 (26.11-rc4).

Although IPsec MB 3 removed support for non-byte-aligned input, the DPDK
cipher/auth operation offsets and lengths for these algorithms remain in
bits. The job setup correctly converts them to bytes for IPsec MB.
However, aesni_mb_digest_appended_in_src() and the corresponding
post_process_mb_job() path omit NEA4/5/6 and NIA4/5/6 from their bit-to-byte
conversions.

Thanks,
Steve
