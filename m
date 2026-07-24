Return-Path: <dev-bounces@dpdk.org>
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC36C531FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 16:46:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65DDA406BB;
	Fri, 24 Jul 2026 18:45:40 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5173840A89
 for <dev@dpdk.org>; Fri, 24 Jul 2026 18:45:38 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso442294a12.0
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784911537;
 x=1785516337; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IXDWYxVM/CjYxVK+ohxBg6YCt4PH9q0RyMErNf7DQqs=;
 b=Q90DyNxL1eoumG75PIQweMqhDxq/kerA2GzaDGpye10HYgogFydV/N0/Wp59TOGvjD
 CfdE0UkNCmYivHJYz4z4PapRDsH2T/g8kPUlEBE/2LHGQCtEytRM3cjgDfSzrSzj5fUz
 /wYxF+XysSRrjDwlFHWAzRKui6VepD8TBREs90ZY3kGkLyq7F19aqxBI5THNPU7b/jFr
 P7Ai8MNSXznaNjr21v5i7/OWUTu97Vn7wmRM7WXx3dekR8HjJPXXkyYRo3WFp5kcrKyx
 pV/KxR6VUPe2zu22yW31nEwY1mQ2XMN+CLbkGHgm4Bd+yVZ+v06y8Z+ERGYfRD8hXq92
 IMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911537; x=1785516337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IXDWYxVM/CjYxVK+ohxBg6YCt4PH9q0RyMErNf7DQqs=;
 b=oMFAA7OeZYEA+gn49Ehg/0iQ5YtOpSw756dbWZ7j86NCyeQTf9lQ80BjF8RBcSlAPK
 o2KpRjZi5aI//34E/5/9xMvQF5Rsx+NNrBSYnxvZiqoaVfHg7nCCKYRTPIEVvz+khDES
 dYky88YB3t7j/clqepXCWzZsVRSuwLN48tN/h6SdbeN1DQdoByEbBqoYp9oUVC4uwrgF
 4zkMoRz1ca4ukDSJT1TXu43vow+LoFb4OBav4k4gKUBo4iqrHhpcErY6g1G4T2yp7Yfp
 j0rwiE53Ww60e0fA52Iblh7qkGjOykO66ZyVjj6p6gmEdvTvVuDQs64VazD1I8ETT57P
 sxTg==
X-Gm-Message-State: AOJu0YzPluToul7ZaknWjox6dRvjbi2Ui9xMCbGTWjCkbq97mizDYTat
 7SWCb96pZXi8x5n7Zn7Sey16hmk/8EDNakDFdXpiDtPBCOc5mjz0/B5yqn0Copg6UP+VwIYgejo
 +Tpr4
X-Gm-Gg: AR+sD1389zCfzsLHGa66pBS2eo/Z2AZtdTre/9Q8R91EQGBpR1OOwInQtevAxss5KbL
 JpG50X+qgfKtmv1n0PGt+V1W80rQEID6UFKVIDs7oIFipLJg2rPflzJ1fBMk2jiXOlA8gNA1PKJ
 l5VKBEE2VRQA6zWc6LI5WdzcxvZkPMstU/BAzRSJYEpHnxNlWQLHW5h79nMEpaQDvjwDgVqEyf/
 vKf0v1ik3TZCBoCRx0NHD8l0wGMTxVKGIDjGQGGar/oJBHF7XE545ACm5pKMm12JS+q4ROHqPXS
 QFg2YJ1A0bp2Kbig1FhZEi/v/PmVGRVoNyxhOFesFtusrjtCQ0CGexyYI10ium8eU7TbDAeAExR
 tcfCVsdIWbyvtDUDhDp8o2dRv78FJI9VP+AL5qKUkaAvgFmRNek4iHJS14mkuGkdzzqBMC9PcgX
 W52iE5Ur9V2cUghmHs+ONObBm4sHbqZtn6JYYLIMVS
X-Received: by 2002:a05:6a21:6e03:b0:3c3:a804:8ee5 with SMTP id
 adf61e73a8af0-3c44b25cd50mr8995395637.65.1784911534918; 
 Fri, 24 Jul 2026 09:45:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc549cacsm972872eec.16.2026.07.24.09.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:45:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC 5/6] table: remove legacy API
Date: Fri, 24 Jul 2026 09:44:01 -0700
Message-ID: <20260724164520.192203-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724164520.192203-1-stephen@networkplumber.org>
References: <20260724164520.192203-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Remove the legacy table library API (rte_table_*) as announced
for removal in the 24.11 release. The SWX table API remains.

The lpm and port dependencies were only used by the legacy API,
so drop them. The hash and acl dependencies are still needed by
the SWX exact match and wildcard match tables.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/api/doxy-api-index.md                  |    7 -
 doc/guides/prog_guide/img/figure33.png     |  Bin 65216 -> 0 bytes
 doc/guides/prog_guide/img/figure34.png     |  Bin 11581 -> 0 bytes
 doc/guides/prog_guide/img/figure35.png     |  Bin 75012 -> 0 bytes
 doc/guides/prog_guide/img/figure37.png     |  Bin 6934 -> 0 bytes
 doc/guides/prog_guide/img/figure38.png     |  Bin 7372 -> 0 bytes
 doc/guides/prog_guide/img/figure39.png     |  Bin 55986 -> 0 bytes
 doc/guides/prog_guide/packet_framework.rst |  811 -------------
 doc/guides/rel_notes/deprecation.rst       |    5 -
 doc/guides/rel_notes/release_26_11.rst     |    3 +
 lib/table/meson.build                      |   30 +-
 lib/table/rte_lru.h                        |   85 --
 lib/table/rte_lru_arm64.h                  |   61 -
 lib/table/rte_lru_x86.h                    |   96 --
 lib/table/rte_table.h                      |  263 -----
 lib/table/rte_table_acl.c                  |  795 -------------
 lib/table/rte_table_acl.h                  |   65 --
 lib/table/rte_table_array.c                |  210 ----
 lib/table/rte_table_array.h                |   46 -
 lib/table/rte_table_hash.h                 |  106 --
 lib/table/rte_table_hash_cuckoo.c          |  327 ------
 lib/table/rte_table_hash_cuckoo.h          |   57 -
 lib/table/rte_table_hash_ext.c             | 1011 ----------------
 lib/table/rte_table_hash_func.h            |  263 -----
 lib/table/rte_table_hash_func_arm64.h      |   21 -
 lib/table/rte_table_hash_key16.c           | 1190 -------------------
 lib/table/rte_table_hash_key32.c           | 1223 --------------------
 lib/table/rte_table_hash_key8.c            | 1157 ------------------
 lib/table/rte_table_hash_lru.c             |  959 ---------------
 lib/table/rte_table_lpm.c                  |  369 ------
 lib/table/rte_table_lpm.h                  |   94 --
 lib/table/rte_table_lpm_ipv6.c             |  370 ------
 lib/table/rte_table_lpm_ipv6.h             |   95 --
 lib/table/rte_table_stub.c                 |   95 --
 lib/table/rte_table_stub.h                 |   30 -
 lib/table/table_log.c                      |    7 -
 lib/table/table_log.h                      |   11 -
 37 files changed, 4 insertions(+), 9858 deletions(-)
 delete mode 100644 doc/guides/prog_guide/img/figure33.png
 delete mode 100644 doc/guides/prog_guide/img/figure34.png
 delete mode 100644 doc/guides/prog_guide/img/figure35.png
 delete mode 100644 doc/guides/prog_guide/img/figure37.png
 delete mode 100644 doc/guides/prog_guide/img/figure38.png
 delete mode 100644 doc/guides/prog_guide/img/figure39.png
 delete mode 100644 lib/table/rte_lru.h
 delete mode 100644 lib/table/rte_lru_arm64.h
 delete mode 100644 lib/table/rte_lru_x86.h
 delete mode 100644 lib/table/rte_table.h
 delete mode 100644 lib/table/rte_table_acl.c
 delete mode 100644 lib/table/rte_table_acl.h
 delete mode 100644 lib/table/rte_table_array.c
 delete mode 100644 lib/table/rte_table_array.h
 delete mode 100644 lib/table/rte_table_hash.h
 delete mode 100644 lib/table/rte_table_hash_cuckoo.c
 delete mode 100644 lib/table/rte_table_hash_cuckoo.h
 delete mode 100644 lib/table/rte_table_hash_ext.c
 delete mode 100644 lib/table/rte_table_hash_func.h
 delete mode 100644 lib/table/rte_table_hash_func_arm64.h
 delete mode 100644 lib/table/rte_table_hash_key16.c
 delete mode 100644 lib/table/rte_table_hash_key32.c
 delete mode 100644 lib/table/rte_table_hash_key8.c
 delete mode 100644 lib/table/rte_table_hash_lru.c
 delete mode 100644 lib/table/rte_table_lpm.c
 delete mode 100644 lib/table/rte_table_lpm.h
 delete mode 100644 lib/table/rte_table_lpm_ipv6.c
 delete mode 100644 lib/table/rte_table_lpm_ipv6.h
 delete mode 100644 lib/table/rte_table_stub.c
 delete mode 100644 lib/table/rte_table_stub.h
 delete mode 100644 lib/table/table_log.c
 delete mode 100644 lib/table/table_log.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 17c15027b8..760b770d6f 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -189,13 +189,6 @@ The public API headers are grouped by topics:
     [reass](@ref rte_port_ras.h),
     [sched](@ref rte_port_sched.h),
     [src/sink](@ref rte_port_source_sink.h)
-  * [table](@ref rte_table.h):
-    [lpm IPv4](@ref rte_table_lpm.h),
-    [lpm IPv6](@ref rte_table_lpm_ipv6.h),
-    [ACL](@ref rte_table_acl.h),
-    [hash](@ref rte_table_hash.h),
-    [array](@ref rte_table_array.h),
-    [stub](@ref rte_table_stub.h)
   * SWX pipeline:
     [control](@ref rte_swx_ctl.h),
     [extern](@ref rte_swx_extern.h),
diff --git a/doc/guides/prog_guide/img/figure33.png b/doc/guides/prog_guide/img/figure33.png
deleted file mode 100644
index f0670eb0053da643e1ee932ee3f30fdd0aa973e6..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 65216
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

diff --git a/doc/guides/prog_guide/img/figure34.png b/doc/guides/prog_guide/img/figure34.png
deleted file mode 100644
index caa2517a4013acbfc7c405866abfa180dbcacb63..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 11581
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
L_p;=<QNaHKqHAy!

diff --git a/doc/guides/prog_guide/img/figure35.png b/doc/guides/prog_guide/img/figure35.png
deleted file mode 100644
index 42053f006745dbe7e02869817995e2b38dc56932..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 75012
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
E07_eVrT_o{

diff --git a/doc/guides/prog_guide/img/figure37.png b/doc/guides/prog_guide/img/figure37.png
deleted file mode 100644
index 20be4aaa6de8040339e0db4200a5e800816f14b7..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 6934
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%0A!SKi^b(OG6h#
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
DWubF~

diff --git a/doc/guides/prog_guide/img/figure38.png b/doc/guides/prog_guide/img/figure38.png
deleted file mode 100644
index 261c561f98a98d572c9247b7187b33f7e03002ce..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 7372
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
Is!zlI3v^8)F8}}l

diff --git a/doc/guides/prog_guide/img/figure39.png b/doc/guides/prog_guide/img/figure39.png
deleted file mode 100644
index d2db6a499a0f764b9e661b905b0f136ea871b457..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 55986
zcmeFZXIPWj+dUd}Y*ZbjNRd%SQ9@IibOZsVGjwUvd+!7Y7C=BiMS2(MB@}6)DMgwP
zAoMD|_Yzu?|9)`h_s;vCbFS-rIN#38HI61EPoBN^z3+S7YptDN6(w165_%FC3`YL+
z$>YCZFj7ev?99TY3*Z?pESWU;>x|1^vXZdEF2*JB;5Um$ijQEh;t0|cqx0bLWydEv
zE-)BH6ZGdy6r6$q1{;xm`uLH$r@`v@WuGw%Usi%_wA<mkx#RG)gOC|Lch17suhV~P
zzj`U{V>HdkntjFYWX7=j3mTGZ&ql`iGcJl&aIBS^jb8bE{Wbh@(G}-mL7yh4>EpUt
z-Dnh1L|nW<^Ye8p@Slu#{Z4$0ABLwybO-zP6Gm%t0oRw<c^TZ*KR+6#kB=_>^8f}@
z;p3G&_g@b+WLbFs>ye7v|5v}vnzvOFx{!L2kB@KZ63m}8I9h`59hf{cEA~v3jNdt!
zw^a0*TUxK7IsW@6H(bW@pMS$(smqrC?|-S(Ih^Q9CP8U!ZQZMCQ88J?#&iZoX6G?p
z%**6<=h@kQiOh4bK;bxwY?^HbnBz^I3wN8S)6V?o)BJPOuhReL5iDDX{(pb@zmot0
z;(sUM|F@HndbX^*JTMBbm3fsb^WWKlO~v-LLAkAt=ZfxR?oBkqzjH<E%W=d;E&ZqJ
zw12-N*FSKv>))AGg1YC5?|(~o*^-U5H=q4G7poUfja(`C_hkb8rw0DVGw-H)|Hm__
zX%qkBnWD6RUnej&!J$sjXTLOs+|JI<3gqACi+qo5{>ioeH_d0hhfURP_&UT2I2au4
zW{DTv1gUY+G@JL|ud-g~N}3u(;s;9u7bAREP14HB_{Kq9QNfe<{F;!(vWv_<+#nCb
zR1}S+c3Z>=Tg(EFTkgYP5<%8>Zw4-rgV2&dHQPm*TxF+egyKxkWuZ$^HmMmd>B0NB
z1ukv#2HYN}y4^pQyer4<-8>x=2+D;2a{s^pjTnAO*@C>ssb}ST7z0)mT%#ZR_vrn_
zdai&^P{D)Gwh%ua2A_@6ujW6!$HRXvxJXOh1KuPhW&6gU#Pn&i;TCucooCcP6XyS+
z8@dQLuPg7v8p0lml2Yv8c|553*)@TdVcp=Zu#X>4ZzpZ4?s%P4VA99MJ+uWp&BT^*
z6aB9mm|Z%$p%)bng9VmXuWQGL3sG?x9Y8ZYROw_wzt^RqrB5w()Dsb?>rl(rNk$Pz
z0i#<t6{0gR-f_-B&5NiUDuJTO`H`zbB{4cWdUZiCS6NqA*YjX12%GKPoOorYL82at
zv1^Zd&V#p}^fE5Wv$zIn9~|{%iBa2E%|-L_6qyRao>xXLJ@>pP3w|fhS@oyS&vVR|
zHoP#1UInW*2iVsDUP&pp>x+SlSC?2$ho><{v$lsq`syIBQ^H_h1-C+wb0zL;BbyVr
zIsskw<6(>+f3+kNSW4H8T3n!6M|40%-Cn`)Mqs<*uW&xc#{a0r-12m$=hV7n7Ac%s
zQo{omm61nS`cG$I{>%*7|I8*C$*%=z>`D@DL=lfrV0D>~hgu|UY;4dM!P=|~(SMqm
zZgcKF4WF;6y}#C{2}B|CWJcWnO}Gh&XwT}U%!Gz>lp<Fqhy+|#TyO8MXp{bXIh+0+
zVg6HD>1Tu{rk$#OA&%5fmQdW$(T|Lbl&qmlq;?UL#}h?PGv8go3~;NHtDkcXiZ2yh
zqVvDe*Vp$sz01DdMMLN;jBaEdZDJ*~tnlUa6boV7I~D1~6l%(hUz9!8XOCQh`A;cj
zzM8tte*+12pJICZRx+-J^>hJZ^qil@FUkGA!cBKNz7;vowcB1KTiooHqRdF&enU#e
z>~}E5o2!>`<f~Nt-`1J#Etpa~M{1iZ?5iUy_S@!PIbq#Q_O*Kh>@)gq{Tf#DB8TL#
z%6IIIj<iTFDx|nt&V{@)=*Bm@SD$|!8lVH4sqT%}_I!dvmwm}?Fv76{uu(c>4()|K
z))i88;?`?%6GgVeC7VZs^<sz`u+(nBVVJG<)h&K)#qRfT$#ds83ze*_tlBhRG(}DH
zH!Zt>Fe{zDLH7eLS+8BJMF)@{G<cKjH{^B2mn+4m%X^&=OLZe(tkmjD-_K8W8J8b_
zy(o4CgeeWU*Tu)tMwNMA;F7e*$8pZsOXOsgq)4k973kc|Kuc*_aB(%uvurt6(NYei
z_79lA9k;pmbMdc#zc4{~L*9h1`fKystBZ~8QE+Uw!*q&+ot+}fB0GV=J!zxhcg}z6
zDRlXdGK+FH{_Ck%>FFHD@x3+A=s)3m89{_yi}#naeZAhTc18(8jn&o|SG-*^N3+Ij
zX79x`*FJ$QizPX{7k%!FlMArM$Vuh<W905Et{MCi9v~{oDkbZAQM-Yb^}H9sn|%WA
z$mJCm->;dy&GnQen;kzc=KaSky!CXkVz{u)DM{YjtEHIz6}E=r7ghCIS1-Jq1OeQ8
zsnbzFJFGiu0yh4Lg_rxMx659UoZXv!d1!9Il&DA2(k}kJpZ%>_>(6}M{CqWj%087L
zEidEO>ZX2b%9E_wD{vt1h~^;0O&}bg)a5^c*!*^}u~T3&aeNwNV^|ai|FeAU;#*<h
zcQ39XZy<lZxLBfF#`{Q?KJ7(FCY1gC3CpK@BK3j(kmFU4aB!ImN@c$WtR6th@M)uZ
zqmGvpN*FMhdfw3P2}l{W)(o5g$H!|R{@E|jC4M9baM_Mk-VZyv<2M5~hPcqrNq?LF
z8`OS=j0sv;y;j$Elec5^e$P})h?Z%#v9h|XW#DB-zt<^mu>GNXXed^uIW$6CEP^5h
zziQD4ZB*V|_AMvBWwjKNiV1I<_@y5kv!MT&>v-^t`8uaDN`JKq9`$Xx7ET-1{nZ~X
z4f5a%LT3KrSs0mzpB06Ax@SOfEYpmV)cAWSXeBe#g}LmL*Fv@GwxgD^9p<}|62_0%
z_$gcN7z^b!$t)hYg&(epZg?rjFC|a5oq^FpE2ot!vzRvU_sYo)Um7<`t$PYb!(fd`
zhVke6Kc}BT&ybk>9l1$SpS<`9KLqW^DtXxqYC;@OgpbleAeb-aewJAra%A2a<|1x$
zWyLkj3c!9!(x+WtKN`KngjC*sLFx0nmGh5&DC(SfB|YwXNPYQ43bw->oL6-7>$#<D
zXVHV7ua++5c7XY7k4`(9o(f{7fa<<_oWU5lztaHsi7Vvd+w;^I6m*&YtU9?{5zUM;
zW=w#;Sl5tbarKG#9vC_V(^qJ$1M#l+goU?J-;g0~X5;DfhWt@AtfJTI^@R(1f(&WG
zAM<WLJFPxo3%zJ{^^HQELBCSC2xj&H6B*a5;Y&;?cfurL6iK>)Bp#Q}7@t-g)9ZoN
z#tdme@*qq=)%p7FchtVePN#r{fEEED3c3;Fn;Xf9^~-S0{MOOmKslB;Y|axyZoXnB
zW8k;F1eJ%QKIr*f#S^BdC;CrMlG+@tUWS7tDHZ>#ILn^{O|FF58}jb0WlZszBej&H
zj~4)npp$4U1Ggw+`CR)~WpK6h2dO`s5vqtK7Z$}2BgHRcGZp1a!P~3IaTgXTz@9LY
zmVz#~*9!w5+Krg2W7`p)JnYIpbHq&CV&;=L2m1=^g^kBSmp!ddDx$pLN!T@%9!SiJ
zv?<493k_pcE?9PePweSatFu538sL2lUZT!P4xx&unal+HURQvfUj4!8yj$w&2QZcM
zuUAm~dIbx=gg98@VMQ$1jAS)Km)0z{POQ7;KhNCg{AZKV-E|VasY`PIqsYl-V_HE0
zM;MzL`=ZZoI&-I(L3U>59VR#T<D|UatFW)#?t@J7SXB$@$MUJ|QKe$nLOt(?M&%vq
z{M|SQ#)Ole+0&@vd3N)k4*D?*uf!QH`!|~4J_CgV?xZsArM)<sL;q*NeeGV?&3=$?
z$P(Mjc{H9T3zfG&J758CpD>?Ul#zXLcj7evWKc1rZd5HK7a2E)Ji?zB2IF6FXCt&A
zPg;u1JL#{3NzSGR<M&Rh*9`(w;+PCAoqzj%yOA%OtjKLvqsBn;snab8rXm}x5Y*Vy
zU7=3}e_v2CF)<NZo(LfChGGtyatXJdUuZzb3R-MB&*GjcVGa(CsdQ$%rFN;gBG|ZU
zjnE3;26?udl&Ss;Kpv^M(=}8NAKE<mM(M|0eRj7+Y`-`kN{^`{U<=&+%C!bQFoabe
z{2#mw#)LXyWJnd?%TYf4oWPF|W~h{<6hCpaw6T#-UoHVPzI$XOUWR*D^l&zk`ZyjH
zxN&<cX5UG^h?dw;_y4>=|5;(7j+hL#fd9<+{c7Kn8D>m;N)||$=6SD9H*EA7l6$#V
z=~J(f;Cp?F_IBkF|CCU4hwEv5`M;1O5M{)jKU{ttjLoy;8kkP-^Qw(H?Zp|br&_N$
z_jAoOQ?N<cHM_L6)(OYlHSLGP?hn7%>oO=Y+9=|Z1<a>cyC3X)u$7)}J<3!W<mK<<
zdrQG0GmwRW1qO`a{HbIqUq`l32F(QRzkW5EvbHOlZlo?xCt#v#X`TGRH^q`pRE$7*
zcbxPUCIs<^IT}FT+{&}Np>3|NvYF?eKYYLBZ+){~gI|zjF$|lf1g=FfSEtN)*+MCa
ztYCC7kmb1iGXis+&)%9&VCKUZF6e$*U5;R11U;>_OkXBqN(3-KAbz=jvZY-`qel7R
z=qpJ=PP~jGhdx8qQ^9&Fqx4D@%%pa*`$1}UvZYr%99z)4aY_Ar;cWqx%~dH)nAaoP
zt5%E&oz1#x9bdTp20n0mH{^E@iQIdeT_BGnp<|=in7HCzfOv?*o8TiD(ncvZ+I%sd
zoW9?^W-__R!c15#q*DTWs3dp3oHuH3SdrT43&mP|{i$ks_J+^qH%F|ZK!&Q@`=vLg
zLa86S60IqP2Ydv+*dzHn69vo&ZbsWLZLpWvKz3CpJuE0`Rh4jP3b@*`zj5i9Uz|F8
zee`#w**fJf#LBB^(PM+F5nR`3Wxo8-c3nS~8n`r`$nhzbml)suz}IOVA!~A^5Gef5
zgj^^E6GGn2bWK07VyLOoWewN(q9Cu-81tea1CMTzY3ZRd5By#n*)Vj^rLn0>E1)=X
zAu#YhRj&oC|E?cqsCfBX(Lz8=!vt;eB@3k#1>CLyJ4`vgf?XjQX%}0!n+fJBW9bH+
zCyAm2U*uAtKpe&0pmHfh0}F9q*Ju#U{5fuiX7Xghu{ptyB`ozptE)uWyGgcJjOTYh
z;}6n`R)(2PCt1Up$Ed^CCU5LJ_@R~SDXUdZ^tEdoyFZ7bE|(U1+PO=61q%FUMCn)2
z^}j}x^=fo5z)l&NXQ=qrx95S06CID2J)NkL44pW_D%QP?e3;~rFjPwDDLOus?ahX3
zvAygKZcgr0_TjTdEbAIgX0l>!iHeCXX0cv}d5zK?lXUUVGBb7P9{xQVRxp|@d_pow
z#N=MFJ?fJ0(u&`0cHi;i-hbB0&aq8Z;-&>AvFm|~-d!il1()IQY*3Zvt}vu#aaG;?
zQFFp)G!TW7FC~*LAyat+ipW=TQx?}8`c&b&Xfm$*`F1*9hC?OOE5n+GuX2ob54hJp
zXuXcskuUKV$TfS0&U&cqdl=DJN_iqh?=~kVtwJB<UPy@%I~XoH+~Nx2$x_Z3?!B%m
z{J;ie=YHb7w@DAUIvc*KSf0&|QxK?Wb^R)#eVkNJnYVGQ@X&YpalD{13vbku%yYQ`
zC;Sg*@1_crqrAEE@dK05yOI*3R`ddVI6q(ISj3vHK9hIs2Qz<3na>e0DLGsJx`kv!
zLkKloZs51hO=rgz7o&b(<ke(Cd(ta|#b6~y(JTC-gt>g}QkPB-tnHS}fIvq2djGzo
zcy}pN9y5vZ7{0A&sfQ~%<FZf)a^rhTUF@-k*j4vJJkp8==1=i}iTld*t)Vq#WcBDB
zOPIeki|m=&GA^8`@gE7P>6KI~Si@uNs^nwV2xg^Hm?Pj@o<He<Dc)<k^PL)ZV&F*#
zB3@N0V^%JWx@phjy81Po_bglI)Hp*!yaPdTXy+t-YIT^$s$8KfnY=pXSXCPzR{w*b
z4}*1q?DOJ^%h0kOLAc0HG5!oJ+rasn%G(k2cURsbrHYDxg}P&8iTUEb$wg3bUaPna
z>`lEm!|yOr19g$SY+*w%d{2bmm(@;8`4s(;d*Pvhw$}#p>qdk(j=sRbnj(@`k9JwM
zV)m?|RC#Vq^-qr@Q{8p<TZw}GH<ZemE@vq*c4%U8w^R2lbo={pL^EwSq6G+7-Ezsv
zGG;q+W#k&xXodwB2o^hYcs(qomX}w#>S14)HH90wNyD4>ZcEAUj>ViFB#JownJD6Z
zmvICy`LHNslV~E-7f$Aas^!xoMAj$!a=mme-J?_KG)1Q=XGSiijv4Qd)*Yo4EfsSG
zims4yz1&Ow{CnH!4!sc0IA_6sS5tW-kD~U_?`pkrqKMyJobR;bP}%yF<8&**RoRb)
zK_)1p;>23pvk~(;{%V<3bea+<PoN%?RsO{<NeMdZi_$S^b~qQxAXYJA@C{PY;w8uS
zPcebf*FzgCmqJ~p*5bRlb8o+;(@7CysXyo_2I;x6jY_tZ<JC03iCqvbApN-fbuEMD
z?vTj!d;1b|!CId^2}Jy)?daG2nV?=<t@Q7hOFM>yE^f1LZbqvgtI`UcY|&YH+M9wk
z2$P{&!u!nzN`ffkcs<8BRzn{<<T$*7<Y4z~uI?rK7$He@IvI-4WH3%sw@jC>%HkY4
zX>!*mPZWj@S8<3k>QdaF|7;iT*}LMUj|{JQ8=BFci%0*#8<sG(vO&9rvvvCRc<eGC
z!N7JDJ4s>}wEr1VO^aM8UoBuJ;o(GR#2aNtf{g?q?76~gVcqA(0aouZTMT)${2qhX
z9NJr@>{Y<s!PN8rKu?z$9c7@%(pkIYO7Sj7eZh{dlLJM#fEJLqZ6sIr%Z!MbS-rLT
zr;`ydD(f;SMPaL-WG<AKbNy;2yU$Z?N3a;z<sIZoYiTQP`>Z2~AN1|m4OKl)@-wE;
zDTnHo$wK0t5?*(C&-5!~GN4V-E~Y|@)v*=s;>0KJjHo9xsOO&hyGvs&GgD1H1GY}f
zX-O-k$A}KZ2f077XZj`m;NpVIj9?<R3{L7owEV(DZyQtXejLNSowwR4&Ev;CU0>)e
zP)5RQHXDhTss}|AIWk)<y7(L}57x|>)IR(8Xb+kUD644P<d>Lq!H60)hftrJ_^q>>
zS}WGx`=sMMDf|6wj+(7;qeDC9F8b^88jHc!vizoDp|th8Ov97R4q7!^;oNp@<VKI}
z^pDt6|7za2Ihu0lK0r2}r0o;u*3U7FsOD1aR%PerLXHMOl`SK#kYZh%wp{EmY;_A@
zY}N-%DkM-9J~s2K5rtCZN<9uWb;x`&S+v!|Wge;)YWMO2EZfxiS~s&r@5ZO;@C;gg
z{CCHGUGdo32rjRFuE5JKg^LI(S9P^Wj=DGXv<bDV(JvLd5CS5}9nO>TEU-YHux<&B
zZkVEAGyKRFIsd}8I%&NLR<RhhK@n3+Ad+@sX+95cXJ1!M(C>G1;{5Y_k>{K)K{mGJ
zC)$-uC75E(Tg(<QFYJZt6R|&PD4OLX3cigKVeJIH(T=>qv7sacGZZYgCMS~-j2H3F
zH(+$;0AXB%axV+aKTSFO>`}VWZsn@=me%;uw|pZ(gSaZAAFo{<tP+oFhq!{acw#=s
z6;4OZd5Gg0J)i#MJ@?fy<0^f&C4K7kOIso07d_mOw+Ab4;XlnekcHZND-$&f_rEP(
zE^T<JRRd?QUTf4z%gHfYt`a7(C7vUz@iZ#}ML9#&LUAV3T<go5&h89uw;uV%lbBkb
zKE7~8o}}iyzc#*XGo9Wj!2Qzz>mU_$olVLejn>O5%t=|>ZyN~u?UxMFo(L#03SJo*
zrO3JpYmAbyOuc30Z=RZH??8GiAbMTt#)cSUSVHmLAJqgquLO#Vl4PDvWh)vLes@RZ
zvb*=izkU@0D3);ueW#k<#p8~it4^$MKZlh%Jr5_+Z6D{(Di%IqXVZ{F)zV7_I;J~V
z0Q9fPf(f%(ovkvff94YuH@wlzshnOo62U~WCQI@8@7wrf32r0l;Q&2I-iqmk-xUqj
zOW;-egZXfSgo6B}y4fhJ3v{;C1EP!+wqAF_ghKPMS?rZ!VE9jYGVX(-9*aIO8`cm+
zmpWk8j25101zdmyUIb7hN^PwL3w3XIWY6@Qs(0*iyKg7*E-xQ^)1Nv>6Sey7tD}Ys
zKP%HYvNv8k^8sND0+~I6p#OzBon`^?!T(|}KaJSxY?W=!#t`o^I*dn|3spnd;Is<J
z^luDbB-|H?Lew4VZDkT~0C+}f#k<*+C`R3tD0EecF-*FWWy;o`5oM2Hr+sdi51_nd
zoYzx#>6h=r(j|TEMM{j+*L|PGt<;P-pQ*tQeRF)ivg~L&8O@7W_j;R9{E+u;+&fW1
z=6qY4`C~hD#mhOr*CI~467J1!wDlfV;)nA+N2bPho_$1!sg(r&JU9vb6on%^@?5Vb
zvW5vIh!Eo)_tuz6O|pK-^JKU@@5tRe&}Z&2P#)KTQk$6rzJT{-FM1_BV=0@b=lARj
z55~J$ux@v-Q4tCPygcIp`yxck^?hwX!zb@WydJO86^p4`*J|h;tmXO-0&SNKUsecb
zV-~btT*!X0y{je8G~jo<(VJcBIhA@K7GBR_V);+XUT=_Dw6+4=;^KqdYb1(2y}EvU
zdPh`5zOdX5@CkwA7!QJ(-oAY8n2%WGf+52lu1fx}5FP;QrSZd{W(QKq?pst0^?8|Y
z%sWnl>6)Jn&cEwivgY{EW!}|tyqq5(fn<WZ#a8ZbTh`Sq46+u@0V7A5w$htTUL6gU
zR-_HBfjvt+7hB$oCNy+eAg@rY=`oK`Y;-1Tu^Ti?4g^f^Skn0xYWEL`2!gJF5h?>&
z7e>@r!vmOXZjc1I*S<3sg72T;nuo^*XExW#hgTMVhVO}U?tfvLh-46t5nHM8Y<>gU
z04aTJ>{v_iFpZ8HZ5{91dqvjO@l9*zn29GFfr=5n_d8wraU&J4=NyPhD!PNQ=5nkC
zIjg}K<fpIozBZLd`w`Ku)nC`^vRp0xFbE~%1S~>)o2yiW!eE?&)-$k9U9K73YHEtN
z`6N4BUEiH{eNhpN{c(&M&zwIpYEb0WZ)riO^1X~chgT=^a!l>iU~jhTY<BxCz%&3t
z|AL<FYkMoJoLs=&gm6k>mXC=K^3g;dt3C}rT14{EHgk{#^Fa_VTYa-Yy#R>s$tUS2
z#?Qw<EpH5FxmaTSNON@<E#&Yhi|ae)8GU?~0pl}seR^~Kt$1$hleeyzuWv9G3nLqI
z$txyC%AAZX{U^<I09`Af50<&z+nbH#IC(MXZ8x3!t3fHgNXv18?NNT0H-d0H4bY|0
zsM;h+^#Gn5zP~zJ`2apZ4HrYT>D>Go4^TaWvtgDzR<wUfd!=i$X#pv)s*P8PU$UJF
z+n|7wGcQ{$YyE+EBRYt14{U?t-T9)EHRj78k!HpbR@QJIo$F|F$o}q3Zp0P3nxc11
z(d*=83R)zhzLbDnw2TV}C|ZSMwqpBzx}0pdkaGBPGNT6ltEk$)XHb2fK=<|CegyF#
z0;;(hgP`X2sXZ4R_Y+~#NO`}fxMcafiF%>7*rd~=am0bRQ8Xp%5wwQ!S<stGeI1az
z_;o<T2s>lg6@V2#1@x=ARn0VdN4M;^s2ev!#_A7$3=-H^pW$AK;j6bWtA6XUQ-?%c
zRnatQJ+tP-@x@`b1(S>JpD~NM6$?O1XcG`ip*B3I1t5*cqPsN_BdL5XMN5QrYpkh$
zr)q=X;(puTy3AoFq#NyPNAE_1GT=7aH?vZ|F=N5iNdUF<<xKJdvvPXxA~Zj>G-qIF
z7Hm|w0xNdUG}{b4B?Gt+p;pxl7TGpcQ7|WeVy0s$GW^8d-lfBGgP>+?+!d?1bm_w6
zP!8>a-JfqkN)MC2gnjcDUF$9Nu|hT)xaN2Gg4jXCu%^b`@1b<XMY~{xysM+Trtxd_
zm3BielX!8X9V$cewHC^Z;qA~-Q~{AtZ-!X{KmxJ<Q0`uGy7q4H0^B}QGi<uttwq-Z
z6vuSdA7q_a+DuiiFF$Jje48X95GEw-=cu*5B^oIM1k4x(flX8NbgL_%p6CUwf3~SM
zzfbop#<Gs~sshBTjPbL$@O2Z&*#1TZW=GTcM)y-#5CQ?|7t1rQ_UGa)ZM1hf>n}r1
zV#zfHs2|b1HoU)EalzEhx2pNhNZI63^=6+I;US}Nk!WZ1M9%(<&dsGb6jA44jfF{k
z!41&QK9$w)2mH!%!gp|&eFA(IL?yBE7iVFC=i=-=-z|l(fO4twhLKOC6}mUJq2bc0
zzTkAL?*7=PE)559F`2)LB`mNEoq1n}$4Km0K%A;vd`E&_BZltt#lJEfqG&L(dZGjf
zp5wH4Q1qOd?7K~CRe|m8YuaPM@Sc?8_4;cf%3I6ld7>v6=j%_h8gHWr8AZF%hWM?u
z-jsv6qJw$EOFIVJ`={W)sr6_#3tchScH9U$KD#!pffzMCFTWCro{T~#SGwVccf#6D
z9_veGcaCohx=la%M!gND`h|j)(1RoefkZ&xe|5Yg8x_uY8wAT7Es{A#KSwNL)x()Q
zz4wy;RPKDfeDj&zXNro7Ld&cB!de+Dxt(!X)<&un;^U#s^lGev7ARSyS~W`o&foSk
zdDWQyDMU%77I+pTkM(HG?D@g@hQmE8^~AOvRNHu=V)}{ZBr(RQAD{9xy~|kj`ANRK
z)XY$DnxDFSc7el>5Rx*tuqB?ZQ1av~<>Xeea%SOc`*oYzmclh$;|Yc*)hM4G;w1={
z@?t%zQxFdk_+9g6cXl=<o!t-J+}=Lf9ZdC=FZje_BJE@$sM8S4a@;UM4kszJ_bZk+
z#KDc0RwiO(e5p{EijL|quNUfYTvnNR=*(iHc{5a3t!5#q8jS(7OjrVay<jFnSlA_3
zlySJ?_NoESaj1A7Q8hT3?#19TGkEYp3vaCXXNVzAj<(_hVwyCCEP<IQ2l5+0b%Apg
zzMu0kbGtcIMsu`&;x(I_3jns#av-I&qY-2QBqPmtcPDC9?iqxt|3^@NVf_b|T=apy
z#RGjOQ}k5Al3YesqWaUrCz<Jg^JG4=*<G{Q06{wUNeCC2X?UI#Mg*MG)yj(NGTu4t
zhl&)>C;rZl;fxwOrq@%i0Eu5(#r1l;aoWNX%1?;42x!TL-xZRnIFXIVjrnlotxokU
zP(E5V`v7nXL!+k^iK3*Vb6=M0#3?~(8nn9Ba4;+{wevAl3cncLE#l@E>)11wX0-ZR
zMci61n<<WHUBNW%t_vs%5`=-L2vh{B*CtO~A0p;mkKPuV8xWQq*MyN=aJ^j(y)=Al
zz3<&s@BNEbnTW8?NEhOSO~Yrej?(ETjj>x*8@Ijq=UVaF?zy5g2nth7mfL8&qbH8k
z2<IZ+o@{XwPd>D@VMwe+Ue2pO9Mp;22yLEz<U`?7=%p50yGpKewU7=pv*Zjn>V)&5
zlq6lS&KsU|t<Y!3A^P(bE&Huym{UguU}ofak~ly^+)z@1cc+iSL>itn7OkftmD0O1
zxvK6%82^05L-s&pN+uu#S>M5uD?S+adZ542=GrKXjS7*m%zgihx2&1X-kHswh)kc&
z{<gX5K@h{;I8tzbkxCniTIiVEoGi(6jd}HJE#8TUTfx3=-pBW9nZpZ6gLQ?QIg$rv
zUvAbZD!Vg$$$g}(>q_1fZB(|GUIM@TqiUW*$LXE{pU1FWJyRii@72_F%*2gn<_5pV
z$7k*4c2k9AGhL_uu5byW3pMX*`+=TsHP61Sb1(z5Xbn2%#(j;+r|Hv4qKG@T-n*ey
z^$R(?SPk}Y1)YNrt6m()Q3ngHg)sQ~4vqJx_;~ITBUd_6CryY2D-o|=1x;w-vanGX
z^-^TJ325=jR_cy1<22sWRf%qMD<v+%8%LudoV$-fUMC4P+zT}VHN6WFFs&^ydekS-
z&{kd;k=FZVp-YYZ!F*KK6GQ7?3AQ<p&K0-!8;s8Sw3JW0Ujhm+P}WZiH<O@TI6Ya*
zGmk+16~9>AF$VA@4YOhfJxu;-(k#5NMgu)72CdSTmyd3?P_C0;eDIjYkZSR`@d43Y
zWt|}hardI1BsM|`b+du_mPIG!lU<raEgI`?VZMgG1Y-`KnAZ?>6Z>!@mlxZ=B~{%B
zDBi`LK@NlS2T<vn=pUt}ku{#WN8@y4{o`|JLo=5b!rg7sIe1|vfO&#CykZ^1O|$W$
zS(VF(h~1<3r3Cc%`$j#A;>?`rBi7P_2{aX{(`fQK;--CS(=8Ll^=M_q_4*eoi}#xb
zjeHV8>IGT1=$|TgOVIlHX_Z?n!Y?@l;S)eU1Y0waT1J_@vnv~>E&w*~JF0Vs(j61s
zd70n9E)OCXKa%v^4khx4IN?~aYgAK9sIlt?o(DU_(Tc^~u7G4aqSCut_#-Uu+syL1
zbMW~O(gFm%{rf3EuDCX~&5;6Ob30{U9*7<4bmg1+)KN11L~q=13s8i*nm(e8L%n$S
zm&4Y33CNqHXHnOTjW(uZYFIX+?if#50dAYDm74B|g~n?%qC8VotIW6ZfrR1Pd<O+t
z{pLYWXo!t36a*Yi(Iil@?3Q)z`wA-MTSg7)@YQife$>IUi9E9idT|y7LvI%p>NCaH
zZpfMDY&>Q34L(7Ar>nF6FSPK*^1}A>b0{--;Go~aMrr@%0;xm_8GQW^zX^3M{G$8K
zj+P5Ywi;V;YHLf%YD(DXu`72vb(3ZElWc|Qm69Gt%hXo*_P-hqIrK4pvGhTU_*Yv9
zi@5u~t<c>902u<-Fe2S+Bn0i)IAV#%>$sSDq0WyoJG<v~dbm;!41z1<2GDkP4@*4c
z>D@FEEHscg{cl?hQ^n#DK3h)Fat@@9qINu&U@8=+eb`>Of~*5%hX`#`l>*RS*jar}
z81T+eh1}uKYss@Q{BlBW^u0HsSHY`Q71l2WV)@Vei7j^NnVfz)@%Ie$uGTutwCi~i
zl!gvkMUC({0$)CUe=>k|olvU|J9@mowS*!(Ete$x+;>X@8p3YYy^PB9S|&T6L95)F
z9HvuTNas{tlw?!S9KO0zcc#41$~Km`okD@-@->Uk@hSF<Lg~1ltja@#{}5`e1FfdU
za|_ZlEUn|>&4q-&tOP)W8#env8PkN;W;>0A3z7WIS?RCZe}+Vqs%IK{o9v60Wa;wN
z63&3Vn91<W6b<(7A_s7JErv7leQ8y#Ws%jWD}Zm1CfvaPwU5sbp2_5BEwpAf+?o4R
z_KZ3u2xi9@bP_T3YmH#7{e(c&0J_g(xv8gU;ZWA)+tCZ#z2#H<eG7i#bL+TrJ6YLm
zr-fqm3G(G%*##X$K9K=552PQ3c`q#16;$aG@?aGJOa7=_o#)N<aiZQKC@Kf8mwya_
z=VWpEc}=`jKq~4u+R=&ISV1_N%*hfL=s3Td!>i^c^EO*iHmV@A+%<y74_ULzO0bEj
zIPd}z;jghZm<om51QC4Lswx%As1eJkap<1!cQ>CfKlyql$Q@MM<%IagM4QRKHc3V^
zZv8#J&0E9ExIyBxN~nlJ?GvxA_x;xO@y*9WCryJ5E|bSG`9G;b#ck^L1cuuWec*aa
zwIk?2*S=cq?z`XD_rys+<SRi*Af8I5OhGxlowi~~2#~tq_O<>})<5_F8m6Njjx;A*
zLf-F91;a{ZwDqFEtKaG>6{MgQ3sh8z9B{`$r*}LYzB+tu0F=Ixi1A=8|75rRm4-w>
zY4K?|_uPVA2$ZpeEz0OUrLS;$2Gx!^@k4^Ge9_f17HsX@Rjof-s0%SZYnX<rf(EfT
zyUxeB>Gs9_^n&4#we;hP06-&^to1?cBG`=?Mau-tYtVPgrHmsjFv*t-s_KceTZQnZ
z^zX$~ji0NuqVR5i$sq*tF9o@arN|_OC3!n(9<aw~XWw--3kEW3AS5(g0@^bRRzobV
zkO+zbOzvrTu8*@iu}w7!&Mz*$vnLK8@|=9&;-u|4Q(c<r3=Cml2zURm&v9wXL*8Sr
zUt^id1yq>cN$+SQK%M4~$`XyIj2jzMDB*RRZAFA*B8?K`aLW31F=M9;u!|gBi37GP
zU-l-C2lKD&&(adP^>6;vd&EAWd2;a3J|~(1IfZM0y6sgRqUF)((Z-LqeMdCjliscW
z!AkF#%?uiZ-BvDXkVpL$r4*s}fRMJKOB!#_>DIUmnyOCCx^plIWUK2d*-SVW*eL$a
z@6#_tFlrcp{1DQKU%7FVRRo~>j=^<5^^Py6$i7o;A?rHqA<(N}yA82VX#)<q5Ek0|
z<&+iyDP|7G1-4~Ni8d3A5J-WOL^T$l6K+s5Je;xJTbU9acfj&~Y@(h6Od<7v=)thd
z`9w?#*F=8h0<N^62b4(6u)7t5pR31E$@YrT&Wzz@hzcHkz+s<N4)(r_(czOL2KlVD
z*1DI{6`Aw*(yYclf&msgYGlXu#v;VhGC?<y?$=l8+NV+T;oG-03}|>@yMTe>HbuWU
zZI0|gzJHevgcOaqk~@oIE6AM?RC7Pfs=PGQNv#ngkpSDz3b;pC%~MjZ`&GQiw}sQj
zA}~Q)-BNsjKAdUj`m+iYIp`YA&xcmp_2lfEOdWg^9d=jG;6BdP1sb7ydkwEzP37+*
z_MuUj4AgN{(XQKueEN&4S{2MgB|=au4$6be)aJV4)YpL*Udq%vK9oSqzCk=`*(v<I
zF~nJ@Cx<T+MmyNJNBM)KnPM)K0O)6KD*_+rv$w1-1QaS<K|Q=$F`4)H6l8$r%8lNQ
zPh}$`*??BwV8^h*%;BI6P;!<3qU4yk?qK&)6b6MsQBV)wc)A$;3nDtVsp45>_du51
zb>n@6LM#$r1DYyxxC`iGuQSBA;8la8!cv`YMtD0MA#(|!eD1#dL|S{bVx=ua6cAcK
zTLvnK8<++CVLf(=GNuuxeLJ5A8|7kNa|TFSL!@pcJFOpsOoVb|bIuoI%)SO?V3JK8
z0}x4=fV?c!Ns(xryb&FR3&^TFksXe@ga#YN@4g=4yKryzE;JLd2z@ap+(sZ!oj%94
z^K_$Hi~)XLC>d;AinO!JEPdg<`d>6vQvU#7AbetXvJv9LJ0+}s$tvjrpd>^tc`Ii!
z#Ivo5UakfC6DTKnoX+YSZK}1bvgCHPRxfW1a|^N89nv;@(jw@sd#cBqRsN&5N(2Mr
z0V%K*nCS*8g5+8BlUh8fU@Q#&3Dk@VjNQ%s{Rq=EyY(`Mw(_v$s4>b--Q*f^TYWFX
z_-q3whJv9d^c8#Fgo{M6y8+3@W%jxW72Q<*kRrR>jh-0>Z0!K=Cv6TMT8oV>A8YFi
z^DV2T7D^eX>6Yo4IlB@I4CXDLxdJrg11SHn1vB>Z2wHD~{F7dx*d1zcxL&jwn9}nb
zxkLnzwZ6iFb@!SI5P%D(o7YF`x@Qb%ALzJ)O!_Hdg6d9JEt{{opOZ~7kmcN;BjR(!
zf^fEEP&74Q!HyLZjR4qD=c?WEr<ed8EyCkU%R}WrL9P0GKaj)90RaHDagq^jD<KYh
zl#RpQNQ146Wd*B>o8~v~pWQ5^Ey;V(EwGpVeQp9X)0>?K(depPN!A;LkUmv>cJ!*#
zS(pm_gK@zJ`ex9nrR)pNeS*&FX7AG3r0y$rZyi4d!XWTF9s=Kw|D$VKsIHom{;75W
zqIo%+Uz-h55F)hK*9=w$_>7KogL<>kj1#pt^N)@UU(@<|YN6<*R}$h&cU-pQ9VkN`
z{2VHGS^Wgz;ms~(s{nTUo;(32@{Wo9(WzWr@hgSiD?tsQzN}PX@F=5^4-DAJrqJd*
zo^B7|uOP8-sqj&vRAF&VYq?TE_cnqG=D+=Zi6nBV9T;U`sn6O}0{}U}B1>NPDIt}C
z@6ow#VPKF-mHhHU@AqiHa+mav07djkDTMug2Qd#QeQRZ&{xrY|arP0^hK^?OpxG?G
zbl+{Oqhzfo+AJWE(n9MZDAM)sg$0O)<qf`LyV6EL0nssHFFYH5^Pz#p&*lrc*Q2(x
zXHkZ}KI43RS*lumeCKvd+&kZ#5S7@YpWUW}aRZnObVQ+pBY<?NfIcV~LLqgyLd%eX
zuzz_Y<1)R!SdL&qWcZoINB<&F7V9g+`j#C|G_;S`h)ETxJV4PKw%!1ql+3sZ9bckh
zpau?k2Q=cmGzkW{I$k!wq$maLO%f|sCmqE7?smFUhw9xQQ!?Cc=QamY$*4z$PaP=K
z%76jF1HO<t)YU1&x9a1O%^-GC!0TI?QTxjktfeCWdy4DscJvz2mDH0|h6koYCkI-+
z3Klzt`(0O1-&MK-7XjDS5P}e+<`+3R<i!pHsQ8Xr!9<GpW3RpkJ2=(w>jWI#CBPjG
zGR4_j(&yv;+zmQSa(15YK?l74>r+`}qcDKBFTphi%C5JK{>GGWVsdU5$YD}cyyMVr
z|7HFTc;W1LjNTkV`uw>Hv}Zt@04At$yMm|$F$`9j9vAY4T!4PCxwzm5UmY*H)#<7!
zTyj$(v4R~EvrE?M<T5^DJODLI0r^FwMuA+ES=x*`YIba9*m#oO3*Q@Dhe!_yN@u8Q
zZLytm>fl4uCcI0jJdT9i1)t-(=Jj@>uT<oO!UsDtvdmY#2J1OSX;9^b_y3dEOj282
zGj3w%Sg{&`-@KJ2K|zQ7Jb}!DxxBO4C!p`Ynvj}uc$5;v0k2OsM_XGb{~mqPguJ{{
zh(tg<dZ(lXu)(x`T^%NeT{Bzl^GY-Oe%q?AzXw0s@QrDuH+y?cduQCyap8z}IoE9d
zw$ZSzxO%Uoa!wi0H9$X@B%|N_eaQNEj8~f7JkaG7WL;VLX$OI{mR<<VAD!dj8LD21
zBJYm{M#4X<YOyeUw*(?C-JcKi=YRnimRbT5m~8l`dSK^z$M?v=cbfoc0F#|rz$)Sb
zLJf~76uV)&!0HLhmSC}7DOp2q2R}Li0NYA^7;=IDFVK%dgV7|Yg4e{<i1I4yzB6aT
zzInfQK0!`7MdZClb-CQNP_1;<`AIQOF=i6D`rBaCv2#izs9TL&uf`1nZnk?g0}Ece
za%P?g;2dG<{DQgLt*W~%U3`<Iz#|i!fBERts8Tu<djrKLhC8YVh^ObUh3zI0LtzpD
zA<Y2|x#?}iz^T`roYhSQ>`T(IUd=YW;M_<aaeyxzVCIpC8<$wa%Q98xLQ$yqZi--n
zmjH73u@q_b*yB6KfF1y9`SdP|bstU;ZR+$<Eoo!*POeCt^kimqj!{G6bos^KV5whB
z(e1YY@Ryj2OlJ#als2^UT~08Xt3_UM7ssX7D0Z9N!L${Ih%Lkm*u1=uI(d@v8!T5v
z&vzX7=EB%U0U&d!U;@evu+*tc_9e<h!NtC#RiO+G41KRnjw`ZM=WMK#6Ycn-FvSB&
zpr((5`@7SnPxHM~J5eTy$zhy&-+|46W%nBsW^Oza;<~w=x-_hQgGpq(U%HSCFg~nb
zF`VAh`C7A(%aOY0)D$Kt3g^SdI8l1P(_Is=e-Ob_v^qc;a6P7$t@Eq|5g-bG61V*y
zORjzWi<fyI8%l3>3Da0{;ZIF77KUxqpQt~bqCE8ulQHkd6B?3fZ$Pa_in5(PFkra>
zr4#DVuy59R-&$WLPuB&5@hl61nEC84AOI;@!{_VUC4JYOnn5c9z-}J<=^~2><^osW
zwHd&X8;wg5uO%Ojqy)}f^vD=4G}k{w1Ac}w$V%S+2@k9r2@*Qpz_W^iHc7kNA%NOf
zoyiJP<-h_Rti5<mWpv8-e8MBy)1D1w_I<khp}R4?n>%od<QHj_bCg=k)sK%J=)}zX
zim`^TQX&S#tx1c{TCXrj>8rhf-&`Hn+YF(^1E<<f)u;<toEo{t)}xcrYH-4q`jl)n
zf^N7~mFtcy^&QzB2HAaEKrVsa2f}^sH>#;<VW27tH<|(Vh)&qdApX36FE}XiwWu7@
zi~s|5y<Bv!fLHDMNCb0xxnVo2!BUx%?baxA@7kDh1+%j3xok4&x6W}TKaaTmfR@wO
zPY8o(7^HBRT%P&kC8TWvkjIT0q+>vx0VFEBt>NBt`ktgVTEis$fKS532Nl4@h|T`8
zpHEbU{2m9McRK6ugn_eI{BeamafRHVyMWDR(?+I~M5Zsc0ryHH4-PNw37jy$Lu`n-
za479&)ogz~9Vem@6>vXt;j<3xE)!_U$!s9Q=`p|Pb<MGz<Ei0|6W?!VJ0wPmmtPb)
z%tTuC=>VJn0x)X0-!hcXeYrWU*vlCNMakNeOBR?+RjZ~?>UR2smS>jIKFDT{Lb)8L
zvDq3$RL^@~-G)rr`dI1}IjffCAm@sWOx2~PK}nOHkG#ul_M_!XJqW4e;#XFIv<W4P
zx4lUH0fXE{pEeW4EO*Z@Wu$C9XgG=nO@%V&=EGIW0get*43@TN#3^CVK}t?)a}8*7
zC9?o4*Zt^J*j5Pt^sWF<TM#wYIKaB0%%k6oJ8e4H(OU~r`0Nwm0?k{3B&ptDKRnl7
z8CpMe89*A4Hh4?Jd`ta<Y~35p1+NSaru2tRmb-uq-T0-MOF4b|i-MtEk+#!zQ_rfV
z90w0gKo6A#C@HMrjCVT@#U{}3Q(i)jrOselZtFgk1t8fW<eg8PsE_{qhB}l3<BLlv
zJ=;(h2FKbi?am)IeVPem_Pv=1$l1=1lfbf9qRW?U!x+hTV*$?oeeHY&@azDa9iZx1
za6$;kQ4x`T8|S%9-;x>E8?1F1LJIqyqs8-SyR4^~bwwc)4!lit{U4VCsUTM74_UX<
za3+77+o5WKfwb&<B6}G`YDl7i$a!>nsb@0Er-OKj)L^SnjKh@9*7=&m9&|3PEe@Mi
zQV^~=cANubTk-b=&pT;H+Hcc%Cxbe-;NYCkbUl;P+lo#j^|{&;pr5~l+flChh%pXV
z-wTsV&oQ&6<MZ<dQR3KAS~ZFW<8aA~5Wng^-(Z!~EIIl)6pC}!@Ee!FtPo$9O%kfb
z45e?@QA|%>O=(m!tmA=1x^XpcAc6tIgcf))6J{X*5*KgW%hFaEDcP=D^=fI5ECYsD
zIPe1<TJ;SBk*6`UWxccZdx|^{o~nX&v}Sr`%5-#!7pnstLyfz)1wN}<g#pq@HlTlh
zdk63fkO$6NDifY!-Ras0S<qc&!#|{ZONFzgSpQJnVq1nfbRZh8lL1jdzBH--Z8kY%
zb}01RaR>~JCYr8FDC5*=|BfhsS}XApdj6Beb=&hkWJwG+2tE_kiy2?mmK^2?wJy3B
z=XB4D`3>|s_V78hhlu%Jt+)|V;d5$t0xqc!G*$F13M6}qogh1a)_SgMi?*R{W?aCX
zhJ`=4knr8`G|7X+@U?2~ha9_slgGXWiqhnc{zr3k$f#KXzDwK`l~!piLUV?MT5j5R
zi?94J7!}A`zgu52_)X1_FjE9_$W9%NoEh+sLDiGgfc&Odxdt#_){|%lG%e7Py270?
z!hUN|r5h7uU!$>}>l3l_i>;geUZWLYKVHX~e>gvBI@-7=d$N<~f>d59F9V3{V56nw
zJ?b6<IMwxT$rLSVDg<#Ig|l}BbFTnGfB6bZsBT^t$)GuoqfJ}uPUao$&xae*Mo;cf
zaqnzv0lwodY9wOrvkA<5b1MQV!sJ#C_4Bgo36&bkHEs*)$6JuwhTZeV$etvyj@<de
zEPgHiyAs>*fM{`cFWOBJkfyXHx1?A0hkknQk0o*Sg8Bd&5`s-EFxEg+!I3-eh#5jM
z5P#o7MM_ot2e1A2PrRez#oW}P=badGc(O*Yt6p1^KQu>DL?i9&21cXGXhTL#?YvLq
zjmBT4kTWpXvL-Ii(U=2gD?=uGC1;qo!;e|Pw9HKY)yc{SiDGWII^Ahf2B$<BN_Ut-
zRUj>Fw83U0kk#)5JzBdyRb;X!rIW@*b7*jYBnlj#0GH>r+Hp<86nS3rZRx57wa8k|
zZP65L6|S+49NzF=l))LZrcTFa|EzxE;?^NkTT%)Kye^r#DfxJ!{<Y`|b6f33xEW4a
z$5THg1tSr<k>|-53`B(G@<l2`(&BgCrno?r!H4|79W5}9MQpj191-d-32TbRCK1;m
z%M7R29+E^66j=o;>LWj|G(rtc4uw-f#rm7mZ@LIfmK0BKb$y^O2JpTXTR`1K>8Otp
z-ro64r(RmfOsy#v;K%t60Dm8_*lZyYz92(i&Qf+qc1=fh(?S;b;T2*%FuM{pdh(>x
zHezT$q+bYRKX>h~zu6zUK(x#0@tyuVgd)bqXAXRz>m<EDxFA;k+6hY=aG6#=xwAjQ
z{&E=$L$AdgtrqTke+?+{9RUPtoiq0g#@&eXSy&5K2h+yIQ>P$%&6b6foj#F7(aCKK
zsCp^qD*zpg=JML(0%&NQksgpFrTWbcUxOQuOV_H6i^3K@3p-`(rl%Yi<U2+y>(9h;
zpSFo*nFiY--Msd4>!O4BdFtYKziYKw1mtn#HGs`IPgoBkEo9&5g2*Q^TE&_6{jB<<
zrPbU^%{1mA)LJ7ggM)45Ct4R4F)qO&USe*FCN73qTCcZCqfJMjHBW1u95ovoi!m9N
z0xsF&JPPvkHzN20YPm!v*4haKv6L4ym|+)6yo={NkYTe%M}g~i%l84%Oq?1xt=9FN
zN{!Tk<M&`stj0!a-Hq_X6VM(8o1zRTcBdtd4N_7A0``181-@r=Bc^}9EZy_p-y_1{
z4J<TmuA-4(v;O6|{{l${wNC)lopL(UK==u}5ThUq+<D-;MsxuKJ|3CweFqo>{)R+&
zMbKqVQbDrgI-;qmhJ1dG9~i%MOq}nvszyowazm^923*itL&lhZ>GG$Lb0tKSym&}$
z@QU?{tQoT*dtr#EZwbe-=L6bYW#FRUxAV>&)%eLp!*H9nc6*_rL5tw?&F+ggyl@`5
zI*DY3tbM%L+5-ngo!#Em!{!#psU0DgWz%vJp+XgV;0$0K+tM2tyN;4cP_~`*na@k<
zDr8i7qPHhzHnj(c%)Weo?rG_T9fftq@AWgYTP!-o3r+9wOUcuF0w2F?tmUmAD?qg9
zeIszRAS574-tf3%Sa9NCvDT_Q@2}rh!xu{3=6q{8pEq+Xbx|W^7V6x$+<NJ(tueH|
zC4+J;HsaI>W2e%rK|ekkGGJ2!2KG7ShWRl>Ue*FFMtA4S;qY-jKQ5m6ehKHe%X%U>
zs`DpKNPO^;?{k|eVoTG8v<s>lSk?n^76A*+s;g<Q{`P6hW_Bn;loTsg-x6~q+qk~K
z{4{-{t&k%6*yXV4La?#l8N+tNq59Z=FW4b){zRq+dW0`ya1k$lM?LX9J&JN98=lMl
z>qLhCEpQS;6x?K2(Y`P;MJ9^1@S)*HQX9YqgzLrLNH9Nkz?vA6Df=x&9BJJ3D!z@v
z&)FuV`;0`C2U^q-7Jz4%fEXrWp^bMM&MQIk6c%-5T}#_-o#-^`tRV2)`ki!0qtF{|
zK-vc?$pj;(-_jb?1boyl_#@@7^Q#9w(}Ou##?PxXY`*<rPfdr~?8Zj1%iW_%LLmmT
zPD^^G$Th@bYWHvIJaP7mkW74vbT|IX??%s<aT0)s4pjZeRR`Hvk^tGLMIP3jArb-j
zuJ?d$Ku@ZHQ_#U}q=lqBTu8U_-0I$@ROBJU#wEb%?cC<reGCliZk3k9492(bckUW?
zzG)EGY=ZZ5qL&sLSK$tA_|m!KtAEn8PHS3qI2=31`Yizzci2?WYy5ttM4(2Tw@g8?
z6pwxA{?|TZ^jxwO`|e}b(Qs4dj)Iv(KvgJHE+5}2{D6|_RO9LjVKQOGDDs$nL=eB{
z0TS%i$Lh=Uu++cWK&C~uxz4GE#c>)0I21KAy#lyS5de}S`Ea%fYy3DJO#S6H{_}a5
z#`BTesMfQ4knfi^ck=3;A62);c|1AEjsWGL3sDZ^YC=xB1?N$oTAH5MpXl72BCn@0
z*Vjl!3h)OQY|T%S$vYhO+a4DIH8>N|4kzet<tlbS^_Vy(&P1QUnuQ3Vs^8zjZ~;wa
z*u^rg_~AH}B#^Qtr}=d=ey>-OHze9jZG(|3Bm$>D6W!LH7|5Cpv!N&@o_>p?4-BQa
zjUR9WwP>8fHR43o;6yw%-wgE)(67MblrrJxfs-##5|Ddz%MePqHk;l1J{^`yv=)zs
z=(2CnH*L7~#n~z4>gqQxo*qr}1-^Gkzl;qobusdlqY)aVSbLhH;dg%#Q?<`wGzIs&
zb4r|MiqVjPtRWfE{2K6P0gcrHyVcwetR_mh&8Fmg@75ow&PaCrke6I*4TL0Q$9Z)G
zI%~uD(e!l87-S1h&R6L!&h>+~8gSWlhFA0aO`-K>6Td6P#ngraagIqQEaiQ*BBkQY
z9Sf}}AtzJAqkI?RZ*~o<9pErrs7nOWE7q?KUh;BgI>Ap&K%l-O>df>`D^AbYX$hFh
z7u6Y;Q9$?0KM({b$*LCabLa;6)wo%pE569|4Fo*hK~Z37>P3Fkt``g=o*T2*L~rJj
zo#XIhj`P{#O9NJRM@!t!l=^6ot1_{95K+VSt$_i_5C1{_Q4;lyH0sD#dM;S^o15&H
z-*SN%&kIFXPOGagkNN|B2Oed?C?4g#{X^hUP5H;d0@gr%HoGoofU$p6?|!V@A^pbM
zPSk%d)j+73`6bkZKqgzM>SRht&jYP8S&Q>c+|Y})sh{Bsy%ry3Y(FHT7c+))mx5gi
zf0W;1SoB9sFTMarw@|Ow@@|kJ3_WX<rBk$HwF!XFZw{FVkxuS}*U`A65D#q)@y{Q6
zoj9ViJdDqnfis1rFCW*Ob?EqUdntM6zjppITcLVAMBmC}4ElZH`@$?t2jyIFY;rDK
z7b|-6ZSq4n=-3zm15heysH|&O0Pu5w2Iz=^kQ%D5RgX_M8ha~kmAMNjhs(l)e&Ps9
zpc*y)I^#3hw7@|6I{jH@5OgFBPV+X7mla+@!8e*ra0jPrWT(2j#&93S>RL)(4mEeU
zEG(h9O_t!*zO^yB${Se}bAE>R5B~WYjnftIX?1OWzXZNFY);@B&#xue;p4#efV1n+
ziL}jAKNl#n+YBUvxxYKBDT4)w0qhe1N}s@~*GnOsjaXo+23%ToBOnc(U-;TREJq?N
z0UHdR3}79l2m<tf<1jYM*~rrlI`MX-mgJVt9r36fc<MM8!@D$*E&cmyw6*Mgd|`?y
zf}YduIQ^9y6c=4ETfk&L%(ezju&(STPRs3StGtO2FyKh##6egIqv?UE+|BInd%)*w
zzR~Pbxwf?N`kZbu1@PzqS*m*Hq?)wUg_c<BDb}KB_>sDOx;_b0rGbtBy)o#NBB`(E
ze&aDbE-eE1KT;;CdFM(+D1)$<ef+%??T?|&$-vTL5zqjRzRuSL%9f%Azpbs5pcX=#
z2Nh1x&4a#D>o&9z30WMiA?jNzv<W^zuMTd6lJ{Kn$fsPZa-pq{_`)=jz<`oZaWe4n
z72sEf+NY|)<AX8JN8mWg(P}%%tBfq1T9CE3VUNIn&NnJ$=KTh^(G|P-ds)tPnPx&l
zzZl&MF~A0?aTZXM>XP=$PwyGd{9Ql(rmHEkl*`SelOb0jI4M;5SB=|fDWu6Q@dz;p
zo7r2&IX#6=wNSGer~P?D>l4VWX6Iwd0nWV8Nt&Xjm&6>Z>9mpy&J&d0>AVWGoLam`
zjhmLH<?{MuSaXv0-E3x2PTU5ipObBBK@E<w5!h@Oc$aPGsZp0f)p=6x?e|ABoVMxz
zQ1_luQD#xsV5yA(1hge6(F{ryL^3Fdh!Pb9iJ~APl5;izN)!+gB#1~(0uqWWh$P8b
zLP;!Qk#m}J3$?r7?^`qTV`j}7{@6>ad7irA+;jHXd*4z6C+4pMY7>GPrq}b9!qnay
zg<zL8)8kx}7Z;LJjAWN6Zep2>6&Q?aNe#@szR>C%JQk4&$@H-H(#?z|brD<a){YoQ
z-RUz#F%<9$S(?euL#{`)O{1<xyy0DPzB`FR_g}q8?!$M@XI=u%bwSJmY$6`@E|}Kb
zDy&G_g?assn5YQd;f6sxwJmD?G7Vx5uG7DC@|bu<AaU%KUNQ#ZNWTh($^n$vX9E$A
zsmLHmieW`WgvX>gjvFVUtk-^=A4`S^_sEgsfBUI6mvzMs?BZJA;7l2mo=_h!K|(AB
zNEjymBm(g+nh&yK-m4)6{n-|@X}$r<f;fq_R;?`}f*@ZD0JbqknG_*r?*%NVFb%Zm
z!>c1et?6vjOlQ4GLC=I`NnRs}dw_@mm>vMZGXhV?K0aaQ1bRX`Y7Qb156J6h0|6>#
zM)>`weuBbt7K<Ef%8i>HIipo(Ky0xx#WD8eAS%xm1yPI&KvAs?pLy>r_dv!w#CLdn
z7ZIK@KqtmLzNY-UCmtGV)zUd>n|e*U#4Ka1sCX}Gz9J&#Z6IQ{cu5ZAp27Ofl>v_8
z@$KB9ZKcF)<%WRG>{ov?yLNY^{VfBThF;QWJ@mpN8&ouBTtLG`6|1vaeSQ}=_rJr_
z9!*fjx}Vr~7F0ehNP75RIU<Hu{ZC6uh`y8itSsoD&wGohP9&rlRrb(H${8E4dRx|o
zi5vvR!-jb}zN9UpIPz=p)NG`atJ<`uZOoC!Pojxg97XOc***KEiOY;XUe<z&TkRi)
z>JCoj_>P;L=?$4kC`M*#XB*Gl6L5dWZr|<o^-}`0vJBfo&G$T2N+owtW`_iI80B0b
z@!yUzXq1~$8UaC5JkLK1fgkoRM)?WqT|md)^mbGnXeE({%zL_j2EG@0D>X>R$!CL4
z(Mz{*!S;ev?2cWg(1k71h=O(c{_?-3Jn?_+>D>|N1l8pyKziJ=Ax6)D7914kWr&>C
zTSTv<L5sS<=M@SCQ19w{!Gww~)T>rpB|rbI=wUQF7D92@7o=?Jm8OazgRFNxRq|Xs
z28+}4{m4$MxXJ0>hBuy~(u*eh5Ofyz!`D5~*aJ1_5hKhDT50p0;iy&yc+%sCKRHSi
zp#DF7Uf~@xaO0T1$rlPNIalmvx~LBdeNam8K}G}!D@2x((2^lN{NSJB08@BSwJ1{L
zpqD5_yT$C}k><R~&IXrcK2ZMy<(nKF04TDo@t&e5#@{uGVuEC%_Ql`lVQip>X?p!@
zn({#BhOPSNJAjMIb`VB{PvY5!+*qJqOot}QpP&Ed96bMDG6wzs;@AG$jP$n=+qHrD
zs_X_EI~@UYJy)bLGn@FCYE>^7{Y{R1;J)VHS1z0%GKrQ1NCR|Bhd~xC8~Nqao3(?k
z6`@n^8yXQZhwyy9;fE2I$Qu}$wHM9*6BhPUh4{MokFx%X4Ex0`s5XvEliUAmjSN{W
zPK21<sTupUhGlj~2*x3hFJ}YY9-3Ef2vRc$=e?`vj0%XBHh%X!_r@suA5XdQp*hco
z6KLb=?+6G(wr4kJSxgN&iSYB5+K`)<T8nQaa3gqbSNX4%`Z`cn8d6yJ1DQpTyYCV7
zyx|}1E(Qh(L~q!Vqd$tkwE;q~J4kEv>{gQ^Dd?H8EE-u(przw<i(suolyu~aFi}rH
zncm{}1S_tx9%#WKo&cTo1rzAA-EWeDJ{#usQ(5UVz~{v5-(x`)1LVd1rm1_$75_@A
zA5H10-(a1v?@K>F76~xF$D1R;&*3c3;D{Kz!iRR<sCJ?jbTyDXhOAy}nz9cPW5aAa
z^YS&s&3{BK0t(@LV1QtG0mXcMzfJ?VY-Lc$ar?ZtyVbo5<jK)FdO|=$iDu9fs+J+{
zl3UJ$tPa<GKQIi&M=AV)S7;qhEfu#_Os%S+7GT`V&6gw*aLns>iIxwnD%GOx-@s!j
zgM^pJImG#N>u_a+94f*Yhy>ci4ZF}u`W+F>HO`dk=Jiu<z%kGa6-YCm_zKPyuDsu|
zt8#|BJ>!V6+gBUNo~J^5GhU6d@@@k|LH^MrrvyDSUPZf;Y#UWvJV>QA;)6_4fVYY$
zkE+eG_UFBsnBnv^JS@JJ0jHj-e$qe!lZUP8-rtamVeHhHv=5nT;ew<jPf4VZIs1g#
zoT30QQqNoVc2v!k&R+*n$onwW5yyrWDK4@a+~&b9*G8`GP%=Uu;@kUb)Bz}V5wg<Q
z?Z}e|jayS9Bb8dgmyYS5QznX^f?&rfGP8ms2gS1g{c5Ajla){zF6a&qrI8~UL3~Q)
z#?2Tn4W9CpkP9MCww!OnWirE&|A6<q?4yuAlR?1Cn8XQ%iP<0Tx-g-<mTtEGGZm1+
zhibE-TMVIbbqbN^tQfk}IYnmEn8C^=QjQm2tLAVsmte4|n2whsb*9XaV~E*CHqg5R
zPpsXMM{5S=TW)*4wP3!FOD}+qO+@ga-K&2X6TNnQ9=7_I#CESfQ3hz2J-5%GbUnD}
z1QCEx4n^c{#Af_7{LZy`(&(hgq>VYjNMN8z)qR+#s8kw_sH=+*3{TlB?()F)*7^}%
zLz_jq!w*RdBOlqfiQ>I2z?Ke<25HkuE2`to)Y4*SA}p``YgCU}D4Xj&?H4pCdj{1B
z&vEC!FxQSPNiM>Er?87+LF!`>q$>yi1_e~BG_eQWU*n~GZVkDtiOvc0h1DjFURuQ3
zDSa-eItb7U--(By!0dPwvjz=ZiYf_(sHK~r2I>sjVRsO}AM@T7cEizT>PzTNc4L%J
z2zoMADoMTC=ZO#7@d|k!UmMZu@^5f?^pi}KvEOqHNj5c97@5g}PNgdPu?6@c(mtM#
zPhlU3$0IYTr_x_Z_ANC-3%u;BAULBkhVg<q9K^ZHv24ChH$>o>@mDOU+>pkL_>cpw
zVb;!ekF_(&X+;Hd2e8{ZM&R@k2`e#(*4^)QrgqSFxTVT$b#SITMKnyn;V9~bft}Dh
z0!K19oS3aB6p4R#tm<msAM_K6{M4**26<HdsNR?2FJ#e}6oWV!8q=_5h+G4pLba7J
zcD@&S%%bk_-fX5_XigOLgh>5Cg%(LwFL>|hcFmIL!65a|oOt|GG0vY%ec-anW;@)o
zX*7e#elv*dXImE`dI({7Af5AYrdM@GCMEgp;sJzO)7f>SGV7^T=s37Igz9nw51gK9
zqnMdOxZR1XHjLKmaeLwTk|cQj7`n&9YyOdNet2g2?c%og3VKDLZh5l&&sP+)P@dUd
zHs}?J%Vw2rX%|{H!yNM<(K!q(y0=#fRe_Zb#Ipk^U(z^IH~|cSQ)w$)ojBF2<Jo+=
z<2P}#Cw6PFH!*fJWnH9K#nu<BtAGQBy`j78lck$ZlYWss&JB!hzo+zKEL*@oQ%VBs
zCSZHrAVS37FExa+n8%AiNb{};GBZo?<kNy)qAmi^LD3SKaa>VsW(LS2RsyXqBDLIV
z!0|l@O0>)9ybTrPqQS)JINU@f-~AV`fvzoR(>?t4<VqBd{&_NB=;eXLCpTOIX7B4t
z#Qf-Zf_Ngp!)a&{Ipwp;LbIC)lGe4F?nm8@N2*9s#X>Q4{lxB?M(3{5#tn_;cvQ%_
zp`-I4BYNbDHr=)Vn~#Lfa~bdgn&Xqu;gDSf28O13&P3T1I+H;VlfJ9VatF8T4$mj)
zKnDiKsX_Bd!D{R<H;6<sIZ8&78`ct9redN>1$SXam_vM>K*&<XQf^rXzBMPM{ejpl
z67t@z?g)kvlJ1LV!bIsI*k1U|JmoSTj%eT@BWsSg`X;9VlU=Vf@iHle(nKft%6`v@
ztaMJWS`m;7Ye((I^QQK6Gxtb(6^0zRR78KpfIrJ>7bel4LF&(f!f3w#Up;CMr`~<#
zis~_Bdj$Gz>&BYW*&NrC-XT^>p=ZKTPqZ{|kNCTPE3O|r5Q2sTh{NBl*&Sy~W`JH}
z9zG16@#c_E=Y4BLT?FnA*_=JR+)OJuIMR1aYj^3w`9TI%$|t^%Z+Kqd>_YdDumMtT
zrmlr33^CProWCgu9s?o5!E2=<-B^)N)+z#@9VOxSlGW=EbjU<yr&=X7kU3MH9bT(P
z4Q${#>*Bt}mG+6^nO)1`-*n&8p#t6#CHcK?9{%Lf&7%9IZF?G>XB3Ihp0pTG&(DC-
zRX|i3Lwv#Lk=T=40Y=&>>4k6x6(I|%T{4g_B!D|jgQF+spd}a>^}Vd$GC>Yu!0-cP
z{_j+<0C=sx77pl`J@N+vDix=5PulaCG)En}A%swL6s<mCPcG_!`0RcpxR(m|m*MGR
z#7Txc2m2{s2x%j0BPhMd@11u4HZ0TGrn+%Zb%_8PzrK<;DqyIx>-Lx9?i0&dF9yiK
zerz8y4?AJW{4O-^IXG`U2UxydH0>1fO;}Cd?8FW`>f(munnnr$76L7Q5j`k}!tU46
zgNg%ycb`I`G)7S9x{qGhKJslaLQ+Si8Y>KJ1{;%pqag{my4&3Z69Ays*0s-;ujDIM
zU>`xpI84CesBIUmeB>j_J=rM~lhPWHnOgQ?y~`uq8wWC5M{d#<C*!6(Byi6hRyQrd
zNa>SN52a<juJz)kIBfn2+`RIlSdpUBMEcKm?)wrCA{@*K=EWjwy(QDz#Vy(mAWg5+
z%Ug#|h40w5ZA_ArMT@<KvVn!N3uyhNaQ_rT5@KBI)2Se5B7A?UV@uP!OfYLrVU~?<
zQinMph1|#sls%wZii4A5(}8YiX`OP@6lf|_Lr+UXATjD5@1;xKNKhE$xQ2+iv^2~V
zV3Ji&y64=<Z_|#z&Vj1@u3DH`BeiZHx%fM3m(}AmyTNzLg@AM5T;m@&+fxKAOMUQd
z3wFP)T9A#?I8ko4J_6#*M?iQpjCJ}ZA3>k$+&<+2D6TATp{gOCb92qliI9^a(Rp#S
z9){MbcB)d80B9hg9qUaJnc$@Z-U1xoZ^ijVIvWy<FC6dba)hq&(As8TArmMKKtQfc
z^rUKed2ckL_a)v8k}e7m#NH!{kd9DnOD+BV0FkP)Du?!@P~vvNpE6seguD_&fKKpX
z3eve({aXq<F;;KZzO4TAH2?u4U4{IF?YXEl0OpZIGT;gcEDiP+E7g&gey)Hc=X1<|
z{gew0@bB4-4zpgaZ>hbrMK@B|1&VST4wVOC5jXq9*jTgd6eCbiMAk~gpHthq@`%i3
ziIcyJTvm_VW%Jo}j#qawXNxm=xpYeZlAuXXi|R}_Bk1USs@Z6E^?MH7RUX57B>@Ml
zJLt-;XfFJe#EenTOsHRZ&}Kx9UC@(d+plRgo?M`9qC*a7*&G^a)XPk-oww{8tLG=2
z*L;e_mK>IWND8O&*}R5Blc2aK)NkD;EXMUg>JE-!?@0m750?!loI!g39hkDWMCCTL
zF+mVag&9Jg?W<>K_<s0V>x{gFGqrn)I@^tk)a~Bs+I<5Civ^+zQTT?Q0r6bt9>22w
z#5M6li0q-gXA}6x_cit|sB>1DK&w?V*VoNcyk_V9Gx|^XXg{~RPU%=aS$Yu4Q3uCJ
zX;gT9oRWPj-vy66_j86V&q&2>&9fH#dv<A@j5nfdUz@Xivb>InFcX?IYoSvqYL^|M
zJ<SvW6qV;E9P3TP+XEwdixED|Si!L=<mqDGRdS<%3AwRc5L+!z9yyc-RhXg=Y$SQ0
z=v*UuydHwN4*;sc4X`m_r3U6&g8~wYB4-69RZtR3-UMRV*>ugfTvQq3bkZnXLc2$z
z9{6fE9?;nmW^%w*Y`l2O6kD?PQp}@#Rf$6v&ObV88r4If$%rhicHH9D2+<fb>p7Mx
zq77yORc>uuL-L00L0fK!-Jwy-EdEBr`6jf(umV#T9?>SwTiODrGFgE806s+$8cJYY
zBULEmO6%#zn@Zt2dwq*7|AQp9wWV#iNPE(-B~xMw2edKwRfsrAN?(_Z+3SMxMre)g
zXE#6f`8!rG3hlzMvV^1x@Mz(xtTs--CIA}ht7y*?D4Ms5!ww+f)`YuJWGXQ8?@udS
z%-yI{8GX^mYT`<jv!gm^qrH?KM^p+MDyy4k8FfE3gdQ$1UTPulEc+u3w@PcU1X)2b
z73Wsfk^#vxNSFneX1<s~J(!mxkgjG<EdIb?2%>zhTnC(!^cTcuS`{A{eaJ1mt=WU)
z&O6mIw7H3dYYObFVWdc<zv<Ksz3@3d>iyB?`Jb1wLhV<Knq=!K9^Iyf!;;cnGGF^D
z?+`B(^=2FO>$->eos~jIwfVyGb9V|y<n)X)%kU1-rsbMx5!U4ZVXU2hgb$r^Ghkk?
zcogJ#3{IBk30~TN1N+TJFc=7n-wO?V_3=C=%xyQ*^&tT-o9z<&J5=4l*7^kua)@fd
zY1y~Vx79!>PF6uVDW5rXP-mBF(TeMHq_hBMGQiykIiIOGklwzLF(h?KFAqw9RcTml
ztmNC}tv-+*z)J*J-mcK2e8`I6#$Sy9PKzyitv?m>NHSE+$+_q7WBf58O+s+S+pUX>
zy;;i@str>G-%x1kZ_ywthh|wOk_gGNkr~~Y+NoN%Iztfex(E@eZq5AW^yx{snHg@d
zyaJxX3C9ciN!~fh>kd$4Ai7onS=&t-&0sP@O&L;!K^JqDCaa%x9FdB(>NmN;+mT+k
zp3Kj{vM0p3b-avkYW;GW>Trcbr7s_j95P9HUi{a)RlcpbnxZRQG&;0M7|O{|f0eh8
z7vxmj&Q(4nX?ltrc+S*nT>7wMxb{u+*7dq>tasO)LN%TGPPe<dMyoOWdL$veFWe%K
zchN18nmF@`kKA*f?Zb6=kQtP!O&kea()>ofnck6U)KdnoZ7i0|t{ukbOnMh`+`tb(
z0GZz1Cmrc?RAm43?SocP64}=^7Ce)qQ(8sqjFy*jg=O00v%Wh7^BfbcKxZG)QR62e
zW3k%^1gBo!he|6vFp|P$rNMWTXrIb0n8=EREw3RCHtPHXO-<iD_p^e-x__*nAgeW>
zfm~&(c3LNtmlQ4vZwV)_e8XAM51!U?vPK3z#DqG8K<z+r4&w_}V+_3u5;<&OzUEC~
zPGY{lApH(^M${SF*(<S*^=XSfNpqCoQHB^)Z+d5wI`Q~J&lVEXwxp2Iq-S?cZiY=G
zn=9vcwbev!hyLXAU5+#6z?;*-Z*H2}<a-KlZUk=)GWJ0q_$sgSQe`oi;mvo@LaM!-
zmrKwpjx;7$y(Zb$ExO3e3`Pc<PITd_sg`dP6x<@z%)lWh76v?WZ)X3sEs-tPN|w}%
zxb(58Px|HUdCBWKR?Uv3L8hCv=g%g`O<n4FNm9JLam>Z^1xZI0Sz1l+xOtIq=fjQe
zb{8a?c*neE(aYv^c_s{`leP|pcO%C>ZVxprq6SHz^xlexF-T!Muf%Q>`V#F>CNqVg
z=@U)TnD>;vS%m#ar5l}km)jVuZ?D8qOO9m66^GmMjlb1=%PeYspKeHXL=Y9l(1^*n
zp6gW}3bF&=Psl2;#$?URCV!S=>jZn@&=y(n=2us6I?3Q)SI<7BtoeoBl(u+q@sWy|
z7&1l#6PK=na!<qHg5yg|PA7rvg<n-pegT+EJrkbjcURYs?bzrp1KR&h!&uXPd!wEr
z#GOs^>P;;mq(qq!5dOo)ZWG6VXO9Gv0mV-Zhj7j553t~OK!F%djer$yGJ@sa;zVKQ
zvP$vW6fwWMjprlqy<?+}4Q|L>62#`Or~~@f%sabWgf*=e=rbz<(jbc{ZF}y;NeKoc
zMcnuw8e}d6=-1X1)gH!N1TYcN=n%vMZKuObh%E<!1&t)hMMG4Ky1aNIW`Yk?*oYri
z)WE&H5@QL(1XvfrWzZ4@mCn7>brj9Py$lbfBXHF$kr5GPZg>4zOju~VcAsOfLqvh%
z)@B<8a8A($&qH8J#B`e50`r@$&2<Y``o_eQ+MF%Zjeq^o;?y^e_p5B$Zbx@d#+vt}
zeFtHsKp6X{j2wR8V4Y>?ECeGawuSM#@nQKAY2|8vovCmfE%znh=zzW%vhEhqJ*VwZ
zvxek*PK$3>*=TGy^M_P3`;|29nQ{c_#mAehOzR!yHhs!N)CON_9OOh+giq;RPIp~P
zRhwDiv|AC*EL9K#LM_=ITdOVSeVF%PzxjVLIz>W`7ib?w)aFym)BLz^TP%9r^{a95
z1(8`dWUdO5?>nBS>og*a%bKH^A|yR>f7pQmO9b0&!DLPu&`=H$9h0x$Lzpbr`cGUL
zG&Igz%CFmk_-FVLiL;KXku6K=&iWh&VH$=0Y<*|y;wykqjx2iqHDsr?|D~ns&#c3$
z&;8yNar;!`0dxoJrYVqWiv->m@+z+bZdAQ4VZjuf+s*-qgPLCYNjMg;w)B3)5Kb7q
z#MN7Dem$G5*Gl@<;7h6EO&~hkJU+yk$L^E&P~3)_0a}F6z&slUc^wCNNa~bcUK1di
z$eeHEv~-N)bxGebVL>D|il_qf0E8gSH&$hzz}^WI*ZYHA1bxFwfU9IJ|K{l_8ewzl
z)rll+RWq*$3Q<vy2ax4IPinfLlU~^zoZ{<{0aR2X)jzwZ!>jy5X+H=SuUwet!7Sa-
z{L*zkbuFcnf}qI^BGa=zp0vA6*V5adE!&dj6=gvnEu?uDSIeb#hcyVu>1^OEa=phy
zhbAZG-PWwFyM22h#}W-|nO_5Tsr6~_mX(^-oFklhZ_eLVi?VEk(kVMjmAzrnpe6^z
zV&DS;J;1ysIC_aSY^p8v+1`s2=|HRUzGoQ)6Kw}sA6J9BJTz#*L(B|W+>RxJ1mVF$
zg4ls2754e$qA6Z`GSSXk3Tf+DZPPjB5kc>VAvA9ahQ;xv{T^lAM!2Q{8XafqUE|-n
z=Y*hX4$zGWUlz)M5RK>lH6y)^c<8szv}tud>@O0^u(j-+jJ~##cla7U^{0{f`uxN#
z`594aoX$$GhIvgA3SE!f9I#&}YwxCC(ANLJPa2*nGxx@Tt>=3BP?r~VUcVIkUvDx#
z{e@AK=g~3*<_!z-=K_ouqzcRy%7&Fn&LENVWoUH-zWoq5v}2q<gZ%^IBf*z*QMRP%
zy@vV*sM<)q6J-DxwOL~Zzg|x7*?BO!b1+nMs7Z5Azd0NeGTQ+jR~CK)Rp*7ccK7C1
z+kv>UNp{rdaL86QW@Fz12s^-eqxbcd@Ss`ibFb^PqT26j-Ls50IvjXqDBXH!!#-!j
zljN=1$V-hJl>iC+qxt6{w`X$L>mua#X!%5Nv*l-ih8^y`yCxYsE=)9FI}VN0i{fA~
zcI+3(pnMSK$dfon$7yZ)t9us*dQ1xsN%j!|pDAQ?jT}n)5P#qnHS7H4L&KU!XnN)&
z6mc~v&qzf*mY3r=9d3VVO^G=WiHof$>YkjV6JKlMUaQt<dhjz`(3*#ln#H8i#t!To
zK=T7#q6BT)##chNB-&oU_=wUU?$3B6+<q*T30E}sWa8}3o)D`U)M8hSQF0sU+vwsk
zlA$9{c0b2~ow_v8v={UKX_eKfW6cY|YZl_s8bx2|l7+I&?|DJM$whsngK$0|sk@d=
zAQNqT?v=V1$q}v;(r)$UhSv|X6wx3;l7UnN%hbj*MDB(|XMKkQaKefHQpPJS8g3Di
znpr{spEbohA%&2MDqV$2GhhuO2(afJGDlsgmfPJQlI+LI!5|Av5G-?GtFcG4qpCZ4
z^9U@#2BUQQAM4!a1QpPxcSWpTA!vd}L|wn<(vj;rL0T#w0_Nv8Ia<e)HAqNJ7osaX
z+`Gv!@0+TSXz|xK^hevu54P2-=wI9FDtyCo;>tUqTJ`ONteEto@jj!Xm7Hyn%_6c{
zLEd$M7P%fz2Dv26o+Wefbk+34uB`*8SBL6_RgHXpWZjKYJK5WI&Y`2>67|P+FM@dh
zyenj#6#0>^C&^N{E&$K1?}L7tLiDWQI|JJ2T<fOXBY<g+0AaLmI>HBJMhSJ}io&*T
z+Fr=(&19$vcwH0PU}~w!B+na;<lx-Sz`BgL*gw3sG+&jfYBi$R&MgEIE@dEwZt3L}
zL7_-&0`0-f2Qjp|S}5bHkO>}ifOf_^@flb)ox_O6S7kO$ZL`?Ckc`>x7eam%%t%PV
zQY;os7?x<VeiTYZ;Xh4(v-L<a*|-Bz!Ptu8u(hSFlU?7&$|2jJZ00IF*D@S&PjFIm
zuJDuVT(hB7@8|2<OmBJ?{U4QErX#b3zK}GRyspXOYu4HxKd@}`>S16tbHDt1H~-J`
zH`U$h^qX@N`aJo2{T(9<&($jXesS1}0C((LPJK%m#`|>GO<HYM=v_s@&BFHM5%<J=
z!iWpKB+>hm5g7QJfxly>01x9YFDj5!BBKE!@~3PL_J_y*aT5sX-V##no^u3m8S&uL
zyS4X60mMxPS*UntPKphwhzCMwsUdab-mYU1q?Vo4NhZGTcmC#Wq}NL>X@KxeoZ=*9
zyme)G{?4>=3tCDCp<t9a5ff?fCNYea*x$dF13Hh1Fk{D64a4CA2##*ZJ`;+Y59iAi
zW44n_Z`pQJVx=2%qM2GD_C&yTMt@i^5eHnvKxF247CK;p2<|~wc{N-&uZdZ__bl^A
zA#%5|tkpp7UAK@C_hL#z;7y48zj6E^X@DmCfZuJXY(Ivu0IWuO|J+0Iwor(JV+9mh
zmZ~FJ9SCa{SV{y-m54fhAeIKHj#M4_zBGk&xsA@Ca?G?aZQYGgJj<iCRrM=~tBN3L
z6`Nq<*1z77M3IPi`~S&=pB(fOLKfs*O$IAq-USwDp;ihwDhG-`IE7zNy=eDjn^MpR
z@Y7HPRkM%7)c<BL3~@412?c{C0#ZV}xe}z$jVneWonnfx$*0}k!7xVm4J>*u4gm@b
zH1X{K4Ou(pqRzJI#P(X4fdD-Q*F<4F|C}>tk@F?$U1hXRng^|AbcuygJ6*XzRZO>5
z4k7t>kD&VA*04b-B(k6v{VGu&Kf~J;FK})z^LCopYR~wP7@)e#pGn{|P;1|?cNVTM
zdbY6X(-p%Az$8%@6Gof!5Ljvg1l5rHkmv-<w!8kBd8F}Qg$zerFmZ}_@B`ej?G~iy
zooP@89U}L|ftapMHWRM%s8I`k2?(&ffSPIB=7<y7etJ1cy{l2&j-B)w{R%Qvb`&sV
z?lYOe;NwVioR1I)y%H1$ND${|zy=FdS@#CRGQgt5PL0t21=Mb(U<e8A7|^nDXQb~`
zHKT+z+^}df)SC#wR8KF@<<EYzL&rEEy2Vw$j&Xn`K~wk-E;F)?%R~`?qlON>g9ttW
zw7ugD>SgO38S~ux5>aS4crA7aF0FdHa=LdD`G7G{CH<~e_Ysv{*V2IXL!>nzVPmZo
zP1%_Db<?vNl~YyVIccF&1_rBM=^&LyzBb|QDd0~JphM!EPzyTg`+<FLfuFD~MS5RZ
z!-aWmU#WJxte3d~#Q_jT`BSr9*XNii_vEBq=f!J*MO9~eQpXZ`>u9QQ9@kk<q6+BM
ze;3v-s=W%ue|NyYy#^5txD*T`dp_Bg9RiLXlGJO?-Hf~%T@ASzvbF0Q)4aomU(`XM
zD;qdmA*>y097M+NtImOdlgQ-u)a=iJ0Gj}{7;HH~L5MC+h|MJ7Uzb%|Y{OlPu0Hp6
z3I~)s5XvM)5*Di|kevZi7E`K6`9Il?G!*|mAASp409jiFfCn;bD<I&4Mjk0wj`)l1
z#1tObwXxkQLp>LzA;`MMr1^rgpvL1!mXG{iJlXW(hyQ4N9zwJQG8}KxS>O6S=G)m7
zD{fK4Kp~Pe&JxcX`6F+(h;sE|LvJytFro2kt1)tB>6S4D6LXU27h_9IL8JoUvM!f@
zzteHZ_EnJW-TW=i3DCDZLWEyAt2Pj~WpCV&Vw+~zJvNgAepoO%d_H-JDIjfB`FQaF
z=a4<)4SZ^ek@->2Ju{k29A=!-xB9URUzes()c}gfvE<(w1>~q-^zs5=mbVjdI82C(
z`=4A0D4Or{P>HJTsT;SUw&WJ^pnJYtw?7OHV;+D^b}cMZPB|O{CT<|OuYsJEQN>T<
zQtoTKHETGkAfK=@p<8vp)&~rZRp2!s!V=q`n*fP+#?Lfo(u1-c4(~q+W<ScuAb$Om
zU;?M}@fc8{F%D<Qgh@(ue>Y9f-i*R?EBd(tLMB8fL`u?kBceUZ3Y93*K9Nd`{g);y
zSFMyqch7AIztzavfqCsIt4jCZ$aBs2Ect&T4_vASM~z#lys~(rAdr?~mGoi$&koJB
zw<zQMSb{9HlSaEIyK+BVoVoM;JuT%!i!GJVOOD~>v&1Pq-b}uKyM*%}<vfZ?xTDhK
z`+q-y^C-l&@Ub;RQp|42C!Y=>{uOu=gkGUeEU`RXS>ZZ7Uj=SpMAO@#!zFV<uj_ig
zgpbb^MLry-tI-xg=Gkx+)F==O<Iyo|`zhxkfX4emQXxcbXF%hk=!D`GOw{{*LXC;S
z6s{7dkd?~j19XsyJssk9+&?(LEWFVFDCvWfJcIFMdc2a%?%4v0AWK`o9|U@Ooplr8
zfa<o_czb0C^es);4>y<qf4wRlqzgxpTh7CG+KVYaKudcG^&p9*t3R>;f|w2?3-#M}
zOa~-&XS^6t8Q;^Ax`nguo+f69A#l(<aa!lV-Vt&r{SN&uJAyfrc&@O|S=>dKNDG25
z^N&M7?3arM4sIwT7$m%gw+L9{zoHNp1g04M*G_3k-9hh>&6s5Lh-n_Z2@>@F-+q&L
zD7NBL>WiOd{|%?}u9fBS&~JKd@8$$QSzDu4m7(&=ui;3XeDDBjb-<F?8l_v>;*?hO
zNCM1P$WEqz`rGS9&|TQwB=8n+^9dLX1v@8Qz&ySIRg?7ZLs|RR_J*wHSIE&006*pc
z;69JY{4XnEq=Gp|>*3*^0N7Fj8RFnPJN-CSKn$FU1qvJ`>8N!d*N-a-+NNMFZLGGk
z&yP(^gz$FSbL6ac+p}A7Qi3bnqR3M8`Lll7k@=ULwrGCX{LdZ#yKTH(a@P;W2Y}G%
zpOSm*Bie0>tP__J(en^qGvrE8LWAYukqU8uI3B=t8ZEw$uJUS40u}DlLe*Mxd;ubr
zeHx~B4L43xPJSYmCOOp22tewCn#>PQP{DT3C0~!8O)zD6XRH;Z0FDm26+fo*fn$$&
zVr9q>C#|mMPLV5_v2a@pk0>w_MG+_xj7-!~KLoNw@L41#_h6j<E4c?#EfU3WL^q&B
z>#FNYyx`UaiJ<rJrrs6e_FoosC*ZP(_@rgEcGoS-zJ^p<D2~fhGLRHmcSzLr0CJ^-
zPG=xtwD5~Snq+@>>)_VG`N|@WPS3fFq=bEe!yIJDjr=9Z`JK)puPM5qZ$OkFUQR^3
z@g~|aXMU`kd>GP&?0cwBk9uMdR<VF<Z08IILsC^y0hR{oO(1cQ4+<u#qLB7ykQbsu
zC4ufkrxGhsuglHk+I<0nteas=A=vDdAqP6zbx^g(H0Bx0p&mU2oSJ&sW8hIo#jMb+
zo}~87T-&1*>lLY^(Y}FwDdi)|B@%IEh!0&B0-icB0H8DV$b$QnI)Ek#w#le8L;Oe)
ze_>ms>dZ*_;owNvJ-*=xgwBRM(XH%zfKQ3A!NowRyqf<VT)<&~n5~@^{k^lnZvvAT
z46B%RaH3Q54nb_<^0{empv(E3Repl!R`YX(CL5C0AvZg?j|9;njPGS3uVe&n)4W+b
zYZCbx;A;!l_9=Z`M=-)?0w9tH3=v8t;j6Jevm$=A@<im2q@<dnp^C3FUQsP-2dC~>
z4tuEwhk1|HT3PGW$HLVQn+C|$C}U1N8GJ_EXf1S}Ats{QO1b!c;alSK1H}e<Wp5+u
zdyW>lDuA^OvSCv)X#F&K40G{HEF0PH00!Pun8#v)(bW>aH)|=HF1REFL;B)U4)GL>
zr`rj=RPMKa;;91Kb_4ZpdEeH%_LQsSI7Ya#i>wTZSGx`2YDsAk(h1hL@{x^&ND*?(
z5gDf|I1kl53R*;FO9-INp#DnhS?+l*@P3@q6#1}y%AzGdv<@cT)Ng{|7-Y;kxBV01
zBvhQl(hvNdL*4}(iKvdC&CIldq3*HCop-+&lov*lDmZN(BD(Rz<x1C=tb#-%qEl|C
zPbP3}ncq6<INK{;S%>$EtU;*@Yw;JS@GQno+U@9?sM{rpd3-gNjhQ$Cb3~XrUc^Ef
zh)V!fg|mPp1Y@;*4+paB>k8|3!6#aMRXp@;;9r>@;>~M<*HXgBWHE&HFD~no6%_8o
zo1`@MXNev`@`0k|P^2bmY2zC*A=mv{nP+7Rm#l^FhbH3QxGuk;r(>I+mR2hAv^boi
zfal}^b>jn~ioaR-nX`7%N_V*mF5N5xEc)X@2<3>lQFvY>Tnx;M`TcS@^2>udXPl6Y
z9J;rKFr)cSEXnq+{{!UTLowC)_WrDwlrMA=X`m{MQ5mNdiS1tT!cTx6SQiWe^fjD@
z4i!_V7LD?kPUu5>ricD}dneTX3=ykMTX4tGQViVe_M574!u=i8<eLx4KAch{2eWRX
z$s?SAsA+xg(=SQUw%a2h5dih`75qd0;938}12!E=aW8@DRk?IP9I*Ig$LUCmoO*X;
z=r&Ojk}-X%?}x1m4~mDi^YW*{+8>JAHX<)S<oPp|I9Bx5dPw29k;~X2lC<5g6f|{<
zVW!zf2hQjL?ZFaHSaJ}teYPUx2&9L@2$nFk((bmI@C2i`x0Va<n)a9ZY%7h?`->B&
zA2=*c0i!@+BdXKv2IFUmQ48H2!U2{(=u4o^&(CrTac*WvOM4|0_KOS{*lv~Cl(S9~
zQzbrMaxatB6|+uYJ!<R|QS2uj%@uNhJK@O5@3DOB)J}Xgryhjo3^5;-1L-E2sqU?0
zbdey4J<p%5Bbq}LPUe($R9QC5u6RdU8@`2`Ar!^)PSp;cdy$rD$M?kU)DwboS+)lT
zb0oy%A`xOmx1kUZh!6(8qr}`thzKI=j5mSA<EUS5%nc%xr^NSH1keHkm|WS_*$es%
z5c`@{Lq-EywO~0iV8B6cndWFjz^z^+T55M2nUEtsUSZ))8GP1{IxUY}{Z_=e)xe5o
z6rHJE)cQpU&^~>#mMRWdOlOzZZL(8tt*>1>BUXW|g^|%>X+}5po$ZFPsMr*2Jx1}*
zEcw<fCQsTB_m6nYA=6~Y;NWJqYuC5aCprP*F^31J^%SIyIsZG4jQyw3U6J@L+*Yky
zN*ffJa1Fs=DM6zYcDZ5fEF?8S%ggTovARj4#f*eZW72+<eAulYvwzj~(!qx8dT7{G
zFoe31-~zMRtlMjCN`45>K?W`N`Oy{Ce*2U+mbOvQ>qjcwZXDmaFi}e(xL@Z8Fi8Um
z9CdHcSZ0(eX_EIc1I2^_?M9>}XyNxEhsHZa+*)pyI{UC}{vdUyF^I;<$V`?)pxI2W
z3x=oMclESZlh=38S!e4HwU^BS{hSa#e(Odcmp0RV&Bes?cLk96C^otdZgd5?PMH_+
ziU=4a@GS^Hgk9nS6&Q?vLPWhzNe2ahPcOoYe&20Acw5e%=r18z<zM)&>`yN|Tn^{~
zZ{Lua1SL0E#?M3Et?Y;{rJ3l-<#A-1l%^b%nEGNS#P15K8ncX)aZ5UMuP5B->HX+%
zIQ5Bsb5LPr_Fo1HpJ*x%A?2EQT96ZAwyJJ)%!4R>$S!k)t5?=6{1&j?_r(0g2EvvF
z20Z8e!P))8En_X`c;?o>k&`>o$5k<?8o&o#1Hw2GE12~^Fj~y*Zx<2!MjKg{>(dFv
zdxoF6iXAjjxG&KBq|uI~wq3o;tz!U}t{k1P-<&b=k})68fy)(SPPj)Sm~dQh`--6H
z8zcAxi0WM1=Ng!^2!RL{nR3!IxVgB$gq^*e^pOL%CQ<L7?s>`4s*PNWel??8pI*3m
zt9=qcQp340%O|cg*r!q(@c;xm9X^*K)+6k#(uwsd4=2h#;64Gcvm=5<KwmUqkJpn*
zXym|FbSh>C;b_O~G~v1s4@u#OaSIA*g)r+&=>|6<bEKX<+-Aa4>;@V<l)^HVR%T#w
z1~LyH-R<)H<RI%=pMRLmaAn1|CILFBgl)AHro`<xO87@cbg>ly_<w$sk=fOspNp;A
z7wG=_i~sX~4Bsj)6n^42o;bC+1<o*U*ss6gw+|e2&e0cM8+-nE;E}w9#LgW7O>aKy
z%iK81z9W!avWsO<hcrfEOJU#88AF+;hmO+k`%2+{I6$p;fFrx$nzo)%=E>_B3*ESd
zBUkR#df&%JW0&gi;q3(?_)32(gF5f2rSDT=*N>h5^Txmaqdw{Y-T(Nz$9Tnme^KJU
zmRPbr-~B&6_fwDxv~d6ZnPwm*UN!vhzqO-q``1Wq|BHx+1YB7B-=7G{|3AGRQ?}jA
zUHh?wxQ~T}J@e?BT)hAOKVwOml#t->NWe;;Wn&wvVu}2C6pi%7Z~y%ib9_=#;M!C%
zj`PLlFn{qGa&q!vHuUR$D*R`7f1Xf3urXamxrIHd-i7{sU5-{FRj0W3GtZv?jIW)V
zl$0Bm_8Qr-og|HUH_wwa!iOKbj;^?>s04L8&D9=JIUx6+krr#~?d4PuTluJUz`0&@
z>8hNZ&k8AeM6vzm3Z6IdXy|_?i{~-TW$}fUo35NMdb5q+{rYIt>!%O?GxwF;>IX#c
zee?Fte{=zU*DJ$y?f>!IBWD$<%qO$js}og{WVwhBoH4p|{y*PFFBdMim!jd)euSGB
zLmzRS)%YJDDT&RO7$-ESAC4mV8+~HEii@Q2KV$d!fcoAjl7qbWzrTu$aHyW&37?v#
zPouqj^WO{ou?ICR?K{W1F8EU2aG~Oj+qVsAFX!asyh}sBcKT2n&1C~?jqlDN(9Oum
z_+F@(Bbr{`y^G=Q#+>F_?>h^pt^3UfUk8d`uD-8%%<V+A93=*`fe+bpKg2QW#hb_C
zqeHLK3TCf0&x-LdKK?wb(Plu{ISnG?pE~OC-8%Uf{Fp@5;iBV9*ri^_Q(Rp2^Fm(h
zyGyS4?z{tvosO24mJYJR;TexQd2SauVZTR;<K}Y@!C)QOb6TrGN2n`wNI}6>g~E6<
zWpp1M&j*RRwUL~UpPeE`cYqTHcjI4rG~w*cTIE&&*IDulAh9_bzW!z*Bp*`%w$jV0
zt~3&R9$cD_6W=hzP8F>&;QT|^cV7e<@n7iS0$O_+e=a^9*)gmDEAw~?xpk9y#+T0$
zLEe#Pq@quU(!c<{Qg;~TE&MA~n^cbL<!;PXZ(N3$B`t_uQ&Z)cT$Xk78~Wej)?<5i
zV_4wVV$AkzI9(NIX{z^{w>*(U3`4YuX}7uLtn+2rlx?*A_3$*r-`gP0`eOIv!DWtd
zURzM(?xdrm+tfVZytT1(^8k6tIgn>#y313xr~K!Io}MPPd@Z3Lp|aA7@-F^Ve&Mn0
z&v`}R{Vr~OfF1bv&z$7?ZV>G5jV>(Iig22h$v?Up;Ydj5sv*bhgH{3Nr@9H-i&(Uk
zgGV2k`un!^?ogxli8vWUJttRFm?xiAy}7_u^G3B8H=b?UbA9pLPM7lKJs3Sw(hobf
z2D;k>T`E^aS0?RX*JXY_x|$Fdv1)l~KHIqKyDDbugtVXs0}1Bw8a8HoTWQ8-Maiox
zw1nOQmc9OB?W8=D_|Y!yE!)o3F-nJ?Mb+X5n>0Tayj?LDW227JO>@;5hYxrp;{tKM
zASC|iOLMvY?YS~O;qn~`S9~ofK>v=Jx@x<<MRH}GYaI*|yY$tgGUhx_3g<L@?oKMY
zFZuPTj-pVn5XBPnu2-zz#4$&2DjgtSro?C0%}BOQRhd@o!aSxONv%%0mEvial$6Bl
z+8n;q?O?mMW6H+bP8X@)&yi8RWOXa2yc<B2V{B|S-DK8Xhcv#69+hbmuW4n2yPu3A
zE-+paT#@3zudeC$OXa*{3ih<vZ!dXGpWvhOde)8qEmMiX;jKzcy$Cn_?^2)tT9@Iv
zr+M?{J@uIoao3_`wRDL$?6>baH2KNy`TE3C1HXK1d}%OeU<c3s5DM*&Bt`0fg?VQg
zwO?~|%r`7Io$4*zXAq6?bd}Vy9}1fN`Hb?)cke-dyT1ji1!0}wkJez)8@oS5PUe<p
z=-242%nmIYTuHbL(eUdN8QPEP1{#^kjs&I7oYbY5ba&NTRZl5hCEef1@re?sCJ$ec
zE9?+*PrKeXy)SmpH0?KWo*jqeF5Z`kJs@;Zyt_??bAz`B%CrfA9BW_Z3>O6#VWy+a
zuSN@`$ZWG7^B+;a81`NMi;s_w%v68OmaC-XGs7KGpN~rLM$=rKzwGji);~H-(s!pB
zXU6^m^f}ZLdp_n7m&l7<ft**fzWoT#AaqI(c0^dmvOFk#8e_A!u8#h$L-&~<=U#K=
z$<U}*aC5WN&to=Am!(hN`LM5&U7ku}Pj1xFP#8Mje-E8cFppM7d8Yit@dAg1hn8ID
z95^RiR?h#lZH`mOv3*grM#!JMutKhVnK;iS*kvcu7d{$fQM+zzpB%)o`a#Hv@Ruug
zkU(2a0j?RJdIcVnA9pp*=idB$@2$m3h5lv+*E^b@;@+-$J5Pr`{@$;5%<7^L*$0qR
z{%448KC)j}Ta47u*?6*n$Ih=O$4z$Suw;3CqTy!A_u_v1JzA<^)kRrJ>5|Jch#bT*
zO1&%=d98fiCYF_xQ@*pV@G1vODtila7$@4e7q6wLXH`=Ni`$UG$ekIF92^Vst4ZZk
zc<1{*Z2fqM<;Dij%!e*Hzw1(h?ghtUc$U6#U0W%om!<s43opBuH0sIsfa;h1R#caP
z6?)j*WSl`<ZzE#eM&#n|m#>E~CFG^lmtNt1!ji%RdHngMW9NS=$WvdY<aXV8@fz{y
zP*FKmFTPbUy5oS1fuonz=S6LjWX~%K0ZpV!Y1v*j`z32)WeitDns=^y%ur%3I$8Bi
z^p|^0zU$rdlPRoAsDko#F-tKcoF7-Yv<_=%X>qWrrs`E(vSZp_$QT}vHmZlleYO0!
zu$G`0$jx3^te%cBy+w6-S7X+N7Mbyv>dmBlxgWn5VYNQrt7M})wjy;xj%=D4c01-J
z#1S**|Hcsynv2CV-{=>8c0O1p`TY=u3}RFr;YYu=wLLjFHcu;-`mAu;)eK8Ah=m^*
zCF_13Kk_!vK>hI+_vQ}FRSJ^E$Bt(I8nDwx1X$a<cRikO{D2SEap~lI+;;ati9)4P
z-7yHYudtA#pv+_RrQCKPsZhCf>l!2=hHgz&zC$&^HLy=*{nqsL_2CdTalGq=-E*>X
z6`$)cG>~Cb+Z=m>m8JOVu%>IVY{7_4^S})y-(#j%6TTPDc-<(P-rc-wdH(?Ok->k?
zV5u6bgji-zqx)8~W#&AL2X_5y7%I8BL>Dg!+ONMi-0@b-InSF(^vCCZRZUIyx#3#g
zl&_k0eQp84!FIYIH#Z#^b|{E0yhf89JH)x_n5ve3JhlF>D${8yi`SN5<#GJ#;9P=L
zo$0QtvL7PJmG+V!jkznBFn#0F`9RLirp`8YMq{7Fm=|=Eldo>3K+1Pq@``fhbT!E$
z>EtCWNi4thyzT9!?&u8D9xvGMcKSi=%hUXN4?2~b2ee&RM^*Kwgt^|{YIu9wYiQjs
z<<&&NvDiJL*5MC>7T-9G3Uog3DK~EVVb|ew%KF~S_fdJnOc!~BHJNb(li)Y28}K-{
zm;wEfw}x$VDo3Ar)todcxj08{E6~%)IayngEUqAPZ<4}LsG!SfC^@3ob+bW<=gyt%
zm1_^N&g+o`A$>nS=i<f+#jQsIxg3LqT<;&~#Vj0_58lyc87ZuHI8Ez0B)OIBCU047
zGKlfV-BQCqz<)tl{=!vhqv+3kj9Hl)KMz~(q1CA1Ypr{Pbvt#0-?pz!b8qeuw}!m}
zId&Hgs%o0MVT0d#dXlcaVdY?IJAU`M#l2&n#p*-xgrYT*=0n1>^abt=L;Ee1$6iJM
zw1$jt^UZ|8CHV7df}Q-?0>uNhAH5tOD5g1^TBkjZb@z^coe>hOaV%v?|G7|?#z&Jb
zI>92_XvTSnU>{SW>PQ`hYjFbCRe!!w@8dO?Ry;$;r*uUw|MInOwdZxLBR1Eq>&1>&
zEGF}cUOGg>o+bIIIdH#LoIGR$Y1fP-A?X?uv%Dg2`?<41q-gBND~S#QZ(K^nrktSp
zoupC0q|B@;f~jD3{rq2$Ot9<oaw;rm=m@SzCU0$#o?%cjap;at>HEa+W7VB6VoXlq
zm6*%D`|2!)y1l}m4`6L-9wy-Ozc6{leLj$vr9?+D`HEMIaoE(&w>-d{H^6}bo_k$#
z(nc_QP0LU$ubuNbAw&C+(B^#B!S`w5QTjLaUM=8%_BY;8Kd1Apu1Gy21%FIyKFh&w
zjd}3vCWpn?;J&qU!uJ$fCO&tGF060Nd0kPT+Bd{=ca~&vAo!6|j_S8!`TOAy1&;yJ
z|B2QCW-$Fn#boJHolW?lh`vJ6=w(#_L6Y(tnipCf3U+q}hOG+kKO!h|MOIy}m?bYo
zfN8@^;=$3(T*D6?FP}bujrSF6JXUXfsCLys#3OsXty)}TGCARPdf`g^#)d;vcQms+
zo`xc@Kb=?a`$YNTp7w+QU#wR|cL3Rrv=0Y<g!JFuV7NEZ5EV-;-Xo<}EX@<pBXxLl
zC|2SDM{fJN%~au1XvDHV?&p<3Rtx2VN~OoBfL*V8S?@vxDf5l9{(+?Yw3m5D`<dvz
zZ_VrIym6Q8l2d@~q*}egyynZ;wo|^1`BUi>y-j7a#E9iHEuCvM_^Rc^Q@4&5_ELP4
z@7ieN%@|cx=+K?l4CE}5r0HH&?6~{mau!1mTYlTRvQ3(ETg3i-ads0{Ar3=5JW&q~
zujaPC3=kLHP)Tr{vW;a~uu>hI6I<n2vp0LUv^9;pvC%znt3>FY!_%{M#kcF$Dx;6p
zhs%Fu=$_AG=(=gF;F-nG$fq;<F13K^+^EPA;iZQOYM<GMWq2947Qc3H*0vcL1cwP6
zz&XB=FL_;CAp5O$?Ui@<+>YihaVs7rolH4v;h|~Yti|Q)Uq9{3)E|89rPtkU^ij`g
z`4s~hzn^P<uFLqtgtX2(#TBDdiOgmfS|@p2PY4QaUSk`sdgXsezomt2a^~@O$d+E+
z?iNrA`~LB82*uw1?h6a}?3w${!dxbsJ{!lf?h6=KJS-`>bZZz}Qf=ZD<J3rg%<{PW
z=oHoqlQSeylGL_2=w)-Rp;629U4)`@xW;H|>d;V?@r_p#9-(<&=`^Z4_tulUHLTJ(
zPk-4nxpPF1Y_ZDJ?1TlC;92cK))K*&PGVU$lj?@1lsc4+I&En>T;$}1wm9iw^+Ja%
zY%rbBu=PZ~7Ek2Da{v?`zrHpsY02?IJN>R3`|XUc^B<W5ISB_j&dX!h2Y6gNgD2PM
z#wZ@GXEFR(cW3Ct-l_{DWUL)J$I7B}n!P|fR(nQ<ZBR8-dym={+-c&ZX_I3A!|Jb5
zlM>6+Vx804R{5hc5j2-fT~-`3TsLZBSzf!Z?;}eMJfrGV8lfqu3i-GFQm4lx_25Q~
z_^rz<C#x-k`9CTT_fC_X(Xoo|Y3q5ra8A5nASIXOZe5JuGnxd2qIr48xRI;s3Je)u
zspHujVxu!@yMtd>g~cpY*^RGMR@2>axGCwnv@x#Z|BPNI$F|nSQ=aPK6NmDZnhBYF
zJFNZsxG#n4YFb)Hy>;T~a)eW-){XR$(^Xtd`VRhQU>opwy|ev(RWHC>cF$ktCXTnN
z>x|bbS2NS{6;5ldAIzWB({3Tj45IBm8_0!iZnmVYPQf0S7D9FEDEsrao;vZZmHHaz
zr5*#E?amc)lgqwBUJTSQKR;Pf=DHy(E#76$7Dx7e7s^X+$U8lVNaQcM%stxww~|D(
zc5K|(o3yI8f~r-U)?8IzYKwz}*w$^VKZg|i7g(^h)ED;cU>l_57p-c%Qv~3NJ}!?I
zHs*BoSx1X|==cj{;CRuKK6b|O?~~mW-_$3JX*;wR&sA}-o-2&9N#0cGT<;IG$Qyq>
zDpM#E+<k^D8Q<z~FqFym#bUQls7-p9D?aCB+JonXJGV;QRfm4Y;(i1(SeCx;{=#Ea
zWuWi5pc(Ecm{>Ac|HLP)s&BGbArF(s65f!gzNm6Um|sd*QX|cDqi3mTjm>ePh;ZlU
zdB(2hw9V@wc8$hu18R31?hOpj6c?|a>YT1|4ajyci)G2OihDkz(tdkj+BD`)hd?u#
z_yA9J!ob&|kSEIKWxhw8U$XE5SMg|_@v|G|CiJ4?T%T;Mnrpb?j&mixq;*jn*4(<-
zQl2>j#*}0^c!`p6Rwm3k8>3r;P+U}beID88n<Nc82KjRj3Z8wz(8>?<0DfCgLC{FV
z<!$-_baQ5Ckf593BI!*6OaB1JdEd96E4BA^JAJ%jld_WFJjxPB{=F{nNc(!0tj78o
z;X#(9bep(j$Hjw!*#_aG`z$P2^f)|Qt3rmO`*Z@;J4B6VL>E2r6YJCBX=~pN$J1S9
zZHgCon*$wo?HQ^L8=ne16YN?#pDX<tpE~<gLvK~Z^^A3wD_0k8*}rgSm*KPP-#YRm
z{lYD?M*UyQZO)&!sCKj1lrBECA{pMZPtDd0w^qkBQIS-*@^(~?T+2{={6~G&$LnHu
z3v(*6^Rv1tw!Z0X25xjL<QS?tU%T%zZ93sbHO&v;Q?3?!2vAqU%CW|F@)2EEYP_iN
zJ$f5q#aXmxOr0ljHv(w++Q;knqV!^e&$e$-bMNww@?DQz7YvSlrn!i7oGP^0F+b86
zEti&AX=+Aqp$yHcN;o_+L7nud`_|qbodp+^Uz}lqYG`$woQL7GR`)UW2Q8(tS}|Q#
z%g&Ax$5pIUyY2a%E`3ww;1hlM`<%Ectr0l7FVt#=G2>^Oht+gQ#9wM#E$syx1&<(h
zG_@Ueq0UW>h_IeCNNI3}L03@q-x`h6d2=FvQ_tZ>+MNzH!L56^bk!^QaxkoLsyK?o
zK5VrvdG6L;V{a?Msl}L*G1Wt>zed01A5aw;kugWAKkTt7AFJJ`X`V+jGHx=IR}wX@
zoHRNq$J}1pHx!_u$leK+IXBpGNU<EtAGE@sS=)jHMZvddOTMMT#Y`sT%t=3ETcaGm
zt%Z8Hj;d(oQ1h4^j(%Zna6jjpOZFs-A3t(VjEq_t<Zm2~7#(}n<}S2$ZbHbq$%#*-
zXTho0M`vPgV^^;<l-Fr5-W;j2D!Coj<&Gc38td3AS=xmM(XOqA2Sj-pB$;e_dWSd%
zjml_N<2l*2E8QM5D~ezMl%kfvL7>UFTkiRq`r;m_xh@RGPgg4W1At@z0?Llum;-sm
z<7>n~lfe3%Vq}V6w)~@)@MSWe#{Jcd>?cl#8_>qx*Vv)6OS|oHrm#@t=-6jTOGnE>
zhThG!w?#RrEv-9Sc099?RoI#A>Yk)3#+lzHVl4F3N@@~Ta_~#q9utTDIN_aBx7WfR
z<?J+bY*uRSdd3$kEnif^`GDh{z1yg_tSVJ|(Ng{^i7o<x_r?-J0&(}7554C9*s@t9
zWcZ4ed`O>{%TiD3bMyxhTj$1eypKv59Cu#lI>E=vFK)$d^SN^%z0M)IE7Z4R!~gZI
z@4+&(I8Jg8n@R$(r8l;&+~9F}L**03+WE{2fjFz88MUfb7S~w>)ISb&xH$f;z=HkI
zD24G7n|*PDZC%5ckVUqz5TMn!|L|Lm6LH!Pd|KzExSVeZI6W2Br8VR$;(Yob0cTqH
z1{d&*-jzezwwT^r_v`XXd-VrlCZAD(ZjsG}74@aLij?-X%ve0TbDf8G^6T{v{x^6`
z-1)Q<PsY8^tsiKuxK0Z!(G}^0uIz7l8)9P=1M07eN3uQi@5qmQJhScwkw^OwCkkzu
z0y%OsSmVF#&k5L`YvNQKS?RMnZb>`jWfCBj<J#N`M+_SrF}pnXV743pavmCfXL^AH
z-(z0EXtTo#;OtQuj#>I{cLph6PclJLGltu{U&!T=MKvqc$8AqNJ4}5&zv5{v&7)5a
zgz@X;dWSpuXxRx_%yvqQT-`C%Qgz6pgLIB>s^F-!O>!0s_wh!R3QN=V58fyYz0~;y
z{5S>?uvRMB+J76Oljaa}_^ZyW;kd=KKh4V19RyQm$lg@XCyD7RJUux8=J`{6*bjgS
zsnu<b<V>{wbU8GM^}5WJpmJe==S+&)(G#aRKC={C*$$b>+lB|^EwxpCfg>e~Bk8z2
z_vliK3|Y_1qupbV7{{YywH_&0jGSzE<xj1|^4;p`K#9AK#yx!T#MBX)PVbt@nS`XG
zz$muXoPu?(wt6SNiE+8&Vwy3(5bGeS*S@@k>CHWTILAqkwk21NiGgUGYn?S^2O0g}
zL+&$a!n_4@ILfL%MpGG+KJFu;8#l%a?^So=ot`g*X$+iHS}j^GT8PLWUsC9rV(atH
z{<cs`$)(^RQqlt>`%`79$2QVwDIb?L1yINcAX~%T7yJw2y)?6~M(K6S3KtJi`@G(<
ztDf_%sH%u1ZD{mx&+@7EIxSZ5L5Y&<=%g}gO;pK%UP-e>9n|s@^?k$jk){r-djMd%
z<a=D&4Ir;D={Gy>2Bu1kSivUW4=BoG1CrA=^RY{Prs0zuO^tM2@(t>GLX(LKRZlgF
zImt{`LY2d81AAx__NtE(3i2M>f8n4+$+?p1>ccN1{#vf*Q@)OTy-Y+wVs`K}?%P%P
zsBt)WtF!2@Te-&{XoU+8&F1SZW<|>7?ahP3?mTm^v3iu1MTNDnpzz5bmbRSXcbd%k
zTsu`iR?}$&auqg5biYvkE9JAI7K>V<$wsJb-k|S`KxH9+i;T^SX)=4mM;dEvRC;Dr
z97Pl~)@c{-J}!!&<d|;nUmjK6h$)o3c#=G;Yp5gQVe>Wb)FRyC>Xxs7O!Oh^)zxr|
z6_&q4KPmx=UX^?*GK;0Gv=KjDS(nu|(5~;$Kk#M-r?<i6a3;Sh*rmm#E-87bKwKOz
zBWrfnStrb*yh8u$SGU->oNqrEW&8jT4vS@OO4G#7)=M>DJ`8j(va{3~4^(-Ds+@mk
zw3v{$l61qom&cKCyvbwfYy_69*2^S3U(uz~4TD(@qTyCnRqeti7JI$lk#<x%T*`OM
z2e9f&s!;k~y8-gGH>t-TNI@{iy+10%`}Oaq)^~NAPT8vOm^v2XxUq}JhOozK95dJ2
zLFLODe5Adb?bJPkw-M8MKNNlhzq_XVUnrX2BI?me58L%iiLRTu6E5RN^3B#Y^CTBx
z2>eHxm)RU`C-kI*clRU+B-Gr&s(l`yXxK+vIMKPTuanJk>+@k9=0LlVlbw1-BI9}>
z+T&5pn{^?O>wIz@1|;(8gMjG%^>>ps`cfbArTE)S_*0fg^((C^W;gzi_TD@i>i7L0
zpAr>GCFW(<A~GSeOR|$K5@pR&h>+b_D<x!XA$xYRg~>jaq_J;f--Q_aZmjdYpL*5%
z^?IMr_nhB3-}61c^E>A^|2bz4?)!P)*L6LX>v|epv2f6^ZhY+AAI85!U{m7R5CBx*
zMU?aKv+^5nloDTq4Now<sgtJf8YEtt8F?u{%QWExlkdb&o_tSL0`_|U3gGp_j*_<T
zyud8#k+BNK4#rObFni6Fmr%1Wy}2j7(ue<v$X{C>dcCT|eGFD@gQVrV3!{{ghw9{R
z2EfpdIa^=#J`E@m@1?tE7Hm4CC(a;-cz9*g4V6U4@OOGaoVf$E3p_ptlWH&!jryP!
zTUNfH_yTqPh`QI4l|GB-aNAyMeXhB9H|5!)9A5E6hvHFJArHkg1JHiw!j=<c(%xjf
zt??f0TKJHCF44`cKvFx2z3|5^uNj4_^dcSTi?{@ltvAQ#kIsN%?dA_3&1(+5w)>?W
zGP+!&ksfmfp~GGT7Lnl&Yh-ID(_j;Pn4>V#lY9LB?D)*=mO@sKBY3?-ayR<NSkg+K
z1fp|AM3yH}$jW{4<z9Anefa_jXiVhrCJU`DefBm5f)@eEsM$j8JaTtimi^kTN|)!0
z7pvi=XJ9avlct=-=lNi{@+flf+NBrZz%BC@gE(M%D7D$@J${@Dq^}QJ$eEbM)u|>X
z*R>Y^GYW@Ppzr&FgN9EA+a>clYiRt5Mh1<iOYUO$P_g;z^Y4Eq3#=}-RbG`J^%`9F
z=^QH_s~rvg!K?Ks@ZR6i9`U)-9QhK^{QaZOP`t+-pUdyp-Ve2M1r?b_)u;oR1%b(+
zw3-{mBsTpN7jsiSs75-8sTftIj^mCvd0&a?;WMVs{YYyl_NLL?(KZf>MuxnL*^-p^
zN;A-~tmQdS1Tc<IJTc91Uz=~bY*!iKr1QDTbISj-i6i0LYr7h3<uk*tpoUH$7R|e_
zv8U0bkWSd=5nn1l_}sPr?F#OD)#CNM@|Go!X*gg3A34Q0W5$;jnigxSX1A<^Z^SVb
z%pP|JFq+<J*oXA_@+XYjR+_l<2KpC1-hWj0Y`qrQ;+}tA0)+2n;bO`=n?r&FCL*S$
zshI1f0GjjJ-p$3U#GC!(MlOTXS~2sBDkYShS+1;>lU#`gJSb3MzB*Fe0U#W_i2RHQ
z=Xnuw1<FIH_fBzcBlf51zCI_g46vpS-32P)HwL~iZafWu8PUl6YdiIqHc=(2qQj1N
zdc=1#y7nwm@h8Kz`M;98Q1v0KCb}P#<90@Z>hs0tl+}XC<S1+M=LfP8p3cOThy9y7
zRZ4Dayf}uZ?%f(ut}W@Q=If@oiBsvQ8p|Z6tv(T!;I&1UYne<RYx{TRyu!Ki_5v(k
zM}Hm@edw}VyUE?E+NsDY-g-%l2%hsfrd?6>%~mgo%f|&PpCDhZpVPfB<aJ-Jt)zKf
z*m6yYcx?%DV3S7kbf??vs(o(xDB3v8V#3gwJELgyl_8(FWSQGb=B2la0m@W+@BFR+
zF6$~T4iSHJ1_szH=IJ8I27ox+t|53zWNAGn)p2&HR((z4o^FBJLLuM<7{Cs%-UB=Q
z7E)U)UboZG&^V=)?Jh0{jNk(I$cit?lZGTqg(Q1-K`PbrvNHn<0N0T;C&0$sUYumb
z<V$}P`a|uf8u1r@{DzKAMg$}q&}QN@_?bWkTgm)y{Zz}8DJQUCqJ^cYN4t`x=!6c1
zNxGg>WV6949X8-&I5l=mwgXiT&;|HuH%UxNO#fI;SzBz;%LzIhc`8<f|Hb{~<3bo~
zaZd(igaW&}gZ!4JN@vEAR|PGY5wcT_yj#YR786x~+w^QZDGyIP#m)Ro2gs6IV|Fdw
z-QBr^`KOjS0k91fFAm&%aJrG}`c~}JW@&)^_Eq>%*qCgxd{D%a=T>=vSsQaNtt5%T
zZ4^1E3Bdc$VSBeJ5;pv+k@jw9(Mdqm`JTu+P@eSqdu$B=E$nURSWrA8Us#}*;p)!C
z{5{si+G+_((#{|{mJPqapUj(@F>oVYECMf7{5&cjP;17u{jS+yN92%dWtyz!bpheA
zl|h5EZsN&@h{9F}$7r{Gd3Lm@s^AAL4i8k}+K-qF3(K3=+(x%k0o}<fF3C1w)<|$w
zQqCgQ?Gv7i5hR{3i(3enw4kM?09C1HxkmyEzH|OI$<?oaq8{5s?ULT4&x`&J33t`r
zp}JD{aEc=^+o+0)nS_w_Yu=SWYFFm*_6bgw3Qk6XW)9d*RS7TGxt!vg_h3xH-AqPa
zE<%PoU2W^<WRN6##tQ>qI!8vVbr#RJ(H`i%K?G)d<$n4DTKJE({T4nZvU92qwEI^Z
zt3GJi+>lr==9`oDGSkV&TUkapZcZf|@QX{<BC_U{E>d#EJVhccZxvv7;wpJ|d#kLF
zQg~~O&at@qsc7Tyd0v<M=m}<l4dc0zDr>`+jZm;cfnX(}f~aRE3hiMw^hQmQv1<oQ
z2@#Z41a^_({#}oX9~F-amW!sI=d6!xloLZ+c!-4_+qv=UZZj@%p55unYEP|Pr`&qx
zwn5;0Uq98d$A8e~;Hc1>skK|F+Kk`N&OXv3fizZoTGX{vT;&9K>Uq+u<H~=Nb}9(L
zvI&<3H=9O35?z&`HM><`h5mO4jl#b!zj}`61$WcPQ-R{6K%t2G9&nf=Cx!$yFHRR7
z!8Zmp2HL~N3E=b@$fl9(Av)PU2LuF6ttAjE^!Kv2FfaGWgf2k`5L`y@F3|6q@AsZ!
zCn=$3#*B9->Kz;iIWW0vq#ep-DQY^>%UKe^TzQ_OXk^UF3$?*=Zfx?usFUc=k20BF
zZfMAjcVV`~`YUJU?HqasdldKSaBf;X-Y>M?8nA}(?0$F`;}(cl2{c93G=cm=dx-~)
z8pIDbs5zr`Cx~Y=U3W<VoNQdFT8Sho6;-XU01<9Pk;{X!YF~n?0icSQ_>Z0b+jiqv
zqB>dRJ6`e3{Ozfw2DiM8_>7K(yooO^&HOl=P+p)HmuL@D<%X-dr6^~hZ;_Jagi(3D
zK33Z{v@jog*(_pzt2OR{n08Wt`asOw)Ixd{r{iGH2j*!?I`s?F9_zXqI=9-^t4}KP
zABkd%Ta#9$1(+P~Jp$zwr$k55RpZ;E_HZvQP%4a|jVIRomUThE^9KR1x0IBsOd3rq
zAwd{>70>B?nzgE?rCwcfGUM(f2dg7Qul(Th*+d?3fB|~m7G-|8!$G>z%hmHY-GoM<
z;&=VqlP%r0`ZPmvqrB`}y?-mtrfS#MQ)JtY3s!LI8XUkaZqXl%&aB*5di+x$AtI?G
zOhs+>vfU}qGYchQ4_BB~ET!Yb4=jsw1;r&Z>4{||w>R2YB8M##1jHr%l%FnmY(@4=
zZ0hf>>Q8gh3n(@|F|cNmuEZ-+>dV-=k6yu%(~Iw)%PiZN(|8~{vcBFzF;O*P`iilC
zLtZ4`D`4Nv2`$)9{bZp<eql>9{j$!xJTb+J-T7KO_a!;p#7!Yp;oV=B0qovgPV$c=
zz%5`CJ4nV>-p<eD%F8-1B-=WcxH%*{MOqvk-zO|CxEBHR4)FTe0~!vO_M<a^pz7uJ
zW)?@Hw?AzGHsr}<2CJPWhu!&LQByir!F*b&-Bg&UH$dKRS@j^L5g*obhH<Ju0qD&S
zUTn<qx&M&DQIpIijQr1vc-uoWRp*9yiCdPWt6t%oKTXnv%<nEf%DhRWEoUval_|xm
zBpyT6z>^rA3lJm8{Z$8#`<DZ}-WR<Y31bBNxu7Edc-TIup+*Ix{Q)bMnJPv(vo)~a
z)219$4(g%{Za=OT+kU{~Uj<;RRDJNLn<$TuhTY>bV;52T!YE{@5-1a}l8ng{tK*_>
z^{kbl4t}^}@5vDk@}Q~c7$YE$6rLtpM1y07E)57>Da@YGu_n^p@WsAavb!*5WGY%+
z#a}MIw_FPdBXTwPAz`F5nQ>+^1C02+eFq|p*6*KKC_Xyl4H=oLMYM8s*aF}@5s?3G
zo%LBZb?^6q1*3o|{$p60+tjvY$t^>3T!Z8}{o5-G{GTF&JMZ_7pAU>THI&OpZ{2*-
zpTC3EIz#mAyJ$`sc_X(}`w7p!9`U@S?hkRYs<%!<zg2#_o)t{YS6az*yS;>)o_AGy
zmV|Qdy2@U<TxFhOv7y3K95L%xWNJE1Q_ng_ix5H)sgD;mg3MJeexb;7irg(!g<@uR
z;&~gL-g)9Nv-ew$=`$(DAkm$dB=J5DrWH4aBT~!CL{kCgI}CMF(?xP+tH$02oucRT
zZ!#@C7x{IPV7AFXPTlSZ@|+B~XkHC2U?Ow}Ibhx~_-URUk$0ZV6UDzUp3E7-^@H-!
z{an0cS&H~EXU7k27>g4<x;J$gW>Yp~ax7lc>uEe0J?b#ES=39^9|0Ax(JSkk&(HbX
z@Y9cHX%f($K?fAkD~zuaWW*L-0$!Oo{&Yxph!eHYNz@QInA@^`|MSwgv)4OkjX3~z
zjd-G_XpydkFJ9THWZ78L6M+lNbS}?}qq|M~N{oTK24rh<kbPJ&j{f_Iq}rOkJ{5Bv
zi-y6hWsdL%d;Ymc`RTd$a()`v^p}!?E&KZt0ef2M?|1|AX4uC3x+cQMS-zL6iApa=
z<)SjOUaXP(J}e$jqlwvx-q`#mBi!#Qo&8APeAGsyOk1#Oy{%xag~%ZIc5d=3I_p5{
ziUGlh?z(L-eu1SUC~>9@J0{eD5{sf)>WCF}l^VE|y{Xzw=v8_qz|wyyy<9aa{-ey5
zFQ}zKEBHovh-&*OZaNd4{O7d<3Hvgorz4&<Bf~~bh|#be3`4WFv5-TvCY{LCQ91xU
zqCiEPDNKA4W!JCIH?<n1TdY?9j>=u<38-n5E7x1!2B|025me-zn*8=NF+Pu-3=%i!
z6&EgFg|YIQa#xH0iq94xK34;G^~g3CYx+kSI|?ObgrI5=W!01vaL1W)|E}#}V^^Xy
zU`)3G(*Mi-uO$QgsTz+39norXSCRsIWdzx8haJ+ZZGP{98HI9T!Q}F$L|+(Oz(#_l
z=q~|QU?#B7V*%zG;I_HSEY@<1Y}C(gs3F%S=x5)e^VGK&%cRL5S|BrXP(5Tga+;--
z2-VAua(x{Gl&k)4bWNPfEb6LBLGA533T{}z3Y^Gsh~nhZvBK6PzNVdZEFpMpVz}n;
zYVfs^jk(R7*`DfsU(<sY!;tN!N~>Y!_x(x|>^CF`LK=b-<a1&U3Hx%>^*qc#Vwm6&
zY~|tzQH&h1P)kai72NI&(ve8-+mivOBDfS5IX)yPlQdma#6MLB6RZ6q5UpkNDtqX!
zUT*!<L6oC^w(5kPCKYsXl+MH9W|~JFZbSAJs{BLT6;wfz7L#LGWk65=6}|-XL>twT
z^`cyPDk5iM4giET*<rnfkP<Fk@atN98r6~QmG(cEa5uTCJ-7Ph=Z(AUEeLTQ!-w~Z
zU)*C3s^QwiId^+70N2Q=mbS;6ngim#r)rtWO@5~Gd;}`ewW;!&$rF7Gqz2Cb@2R}(
zP*RqIH>aRdZ|~B;bAVIx9fu4fzm8KY2iXf&EK_az^pt{o>9|r;-gfI+ps&-1_>Zfy
zLJd-LBB(F0a-hX{C>D`07~TL}!$r$xWy`%Z7vt-pKuFLKT;uB)?lTElT=7~ZNCMDC
zjPU5@QPO6ie#AEMq(AH~2!r*XPukC~WJX>Ma6VE8+5*k7vqb)!yE_L$OKCh&w0w17
zq<exl>I~Nrmp_2t_(y|Yrd%4yOK^O{n@gWT5$#C{WWu2IEsBX}-LLl8blmDErOLNM
zS`oNFMF%>J#%O*iVL&W?%Sf8S{E+N6|5=K}Bh@D%9g@?}{jatZC8Cn^iIKkrd>?&G
zmXYK5v!+z^#Z4N`z%OD8cRj4yL~+#o$Q?GmZ1?!CJ-n-h`1AVpO%<;LQs@0w=T9+M
zA~g^Lybwx1z3O=i1FrqZkFf`FBEuGHcJl_i+4z%prU<<!b6R+A(K!j(VJ=56lAXx{
zltd5jO>RJY)vWuh>Rfmximh5y{k+l5Qr|kdZ-}EF0R|uq!MQthB0%96b<%Mcqm7*a
z`ie&d(hp;gSEX9BCcJ!?r}GpUeD#C*Q9dQUs8*H3?8y4oe(<Ad+cR7U+|55?{M>f+
zFg}00Snq@jQ`Bj1ZBQ%7{izj@rgX3lh-SV0y`5^Jl(Enm{o67Ikh#=qz`2ScjZ<ai
zZGBnZwKS4h7cL<l*S{sl`3L55_vok9id1?9SP>Vze9lYGeX`<m$*CCAa+A6cJFzR+
zkUP2`=}=VsA->Ds=~Ta~Y-pUWxz544g%W!*c&aHM7->)4Ibt`2mP&oP=bRwI)gr&?
z6Gu>-)G$Tjb8&Ic(z*w|U%YA-w^8UN^ll|%0AVlC!xcL8)rfC`#0!um);sqTLXD>E
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

diff --git a/doc/guides/prog_guide/packet_framework.rst b/doc/guides/prog_guide/packet_framework.rst
index 9eb2c5d3de..98cf3be109 100644
--- a/doc/guides/prog_guide/packet_framework.rst
+++ b/doc/guides/prog_guide/packet_framework.rst
@@ -131,817 +131,6 @@ The port abstract interface is described below.
    |   |                |                                                                                         |
    +---+----------------+-----------------------------------------------------------------------------------------+
 
-Table Library Design
---------------------
-
-Table Types
-~~~~~~~~~~~
-
-:numref:`packet_framework_table_qos_21` is a non-exhaustive list of types of tables
-that can be implemented with the Packet Framework.
-
-.. _packet_framework_table_qos_21:
-
-.. table:: Table Types
-
-   +---+----------------------------+-----------------------------------------------------------------------------+
-   | # | Table Type                 | Description                                                                 |
-   |   |                            |                                                                             |
-   +===+============================+=============================================================================+
-   | 1 | Hash table                 | Lookup key is n-tuple based.                                                |
-   |   |                            |                                                                             |
-   |   |                            | Typically, the lookup key is hashed to produce a signature that is used to  |
-   |   |                            | identify a bucket of entries where the lookup key is searched next.         |
-   |   |                            |                                                                             |
-   |   |                            | The signature associated with the lookup key of each input packet is either |
-   |   |                            | read from the packet descriptor (pre-computed signature) or computed at     |
-   |   |                            | table lookup time.                                                          |
-   |   |                            |                                                                             |
-   |   |                            | The table lookup, add entry and delete entry operations, as well as any     |
-   |   |                            | other pipeline block that pre-computes the signature all have to use the    |
-   |   |                            | same hashing algorithm to generate the signature.                           |
-   |   |                            |                                                                             |
-   |   |                            | Typically used to implement flow classification tables, ARP caches, routing |
-   |   |                            | table for tunnelling protocols, etc.                                        |
-   |   |                            |                                                                             |
-   +---+----------------------------+-----------------------------------------------------------------------------+
-   | 2 | Longest Prefix Match (LPM) | Lookup key is the IP address.                                               |
-   |   |                            |                                                                             |
-   |   |                            | Each table entries has an associated IP prefix (IP and depth).              |
-   |   |                            |                                                                             |
-   |   |                            | The table lookup operation selects the IP prefix that is matched by the     |
-   |   |                            | lookup key; in case of multiple matches, the entry with the longest prefix  |
-   |   |                            | depth wins.                                                                 |
-   |   |                            |                                                                             |
-   |   |                            | Typically used to implement IP routing tables.                              |
-   |   |                            |                                                                             |
-   +---+----------------------------+-----------------------------------------------------------------------------+
-   | 3 | Access Control List (ACLs) | Lookup key is 7-tuple of two VLAN/MPLS labels, IP destination address,      |
-   |   |                            | IP source addresses, L4 protocol, L4 destination port, L4 source port.      |
-   |   |                            |                                                                             |
-   |   |                            | Each table entry has an associated ACL and priority. The ACL contains bit   |
-   |   |                            | masks for the VLAN/MPLS labels, IP prefix for IP destination address, IP    |
-   |   |                            | prefix for IP source addresses, L4 protocol and bitmask, L4 destination     |
-   |   |                            | port and bit mask, L4 source port and bit mask.                             |
-   |   |                            |                                                                             |
-   |   |                            | The table lookup operation selects the ACL that is matched by the lookup    |
-   |   |                            | key; in case of multiple matches, the entry with the highest priority wins. |
-   |   |                            |                                                                             |
-   |   |                            | Typically used to implement rule databases for firewalls, etc.              |
-   |   |                            |                                                                             |
-   +---+----------------------------+-----------------------------------------------------------------------------+
-   | 4 | Pattern matching search    | Lookup key is the packet payload.                                           |
-   |   |                            |                                                                             |
-   |   |                            | Table is a database of patterns, with each pattern having a priority        |
-   |   |                            | assigned.                                                                   |
-   |   |                            |                                                                             |
-   |   |                            | The table lookup operation selects the patterns that is matched by the      |
-   |   |                            | input packet; in case of multiple matches, the matching pattern with the    |
-   |   |                            | highest priority wins.                                                      |
-   |   |                            |                                                                             |
-   +---+----------------------------+-----------------------------------------------------------------------------+
-   | 5 | Array                      | Lookup key is the table entry index itself.                                 |
-   |   |                            |                                                                             |
-   +---+----------------------------+-----------------------------------------------------------------------------+
-
-Table Interface
-~~~~~~~~~~~~~~~
-
-Each table is required to implement an abstract interface that defines the initialization
-and run-time operation of the table.
-The table abstract interface is described in :numref:`packet_framework_table_qos_29_1`.
-
-.. _packet_framework_table_qos_29_1:
-
-.. table:: Table Abstract Interface
-
-   +---+-----------------+----------------------------------------------------------------------------------------+
-   | # | Table operation | Description                                                                            |
-   |   |                 |                                                                                        |
-   +===+=================+========================================================================================+
-   | 1 | Create          | Create the low-level data structures of the lookup table. Can internally allocate      |
-   |   |                 | memory.                                                                                |
-   |   |                 |                                                                                        |
-   +---+-----------------+----------------------------------------------------------------------------------------+
-   | 2 | Free            | Free up all the resources used by the lookup table.                                    |
-   |   |                 |                                                                                        |
-   +---+-----------------+----------------------------------------------------------------------------------------+
-   | 3 | Add entry       | Add new entry to the lookup table.                                                     |
-   |   |                 |                                                                                        |
-   +---+-----------------+----------------------------------------------------------------------------------------+
-   | 4 | Delete entry    | Delete specific entry from the lookup table.                                           |
-   |   |                 |                                                                                        |
-   +---+-----------------+----------------------------------------------------------------------------------------+
-   | 5 | Lookup          | Look up a burst of input packets and return a bit mask specifying the result of the    |
-   |   |                 | lookup operation for each packet: a set bit signifies lookup hit for the corresponding |
-   |   |                 | packet, while a cleared bit a lookup miss.                                             |
-   |   |                 |                                                                                        |
-   |   |                 | For each lookup hit packet, the lookup operation also returns a pointer to the table   |
-   |   |                 | entry that was hit, which contains the actions to be applied on the packet and any     |
-   |   |                 | associated metadata.                                                                   |
-   |   |                 |                                                                                        |
-   |   |                 | For each lookup miss packet, the actions to be applied on the packet and any           |
-   |   |                 | associated metadata are specified by the default table entry preconfigured for lookup  |
-   |   |                 | miss.                                                                                  |
-   |   |                 |                                                                                        |
-   +---+-----------------+----------------------------------------------------------------------------------------+
-
-
-Hash Table Design
-~~~~~~~~~~~~~~~~~
-
-Hash Table Overview
-^^^^^^^^^^^^^^^^^^^
-
-Hash tables are important because the key lookup operation is optimized for speed:
-instead of having to linearly search the lookup key through all the keys in the table,
-the search is limited to only the keys stored in a single table bucket.
-
-**Associative Arrays**
-
-An associative array is a function that can be specified as a set of (key, value) pairs,
-with each key from the possible set of input keys present at most once.
-For a given associative array, the possible operations are:
-
-#.  *add (key, value)*: When no value is currently associated with *key*, then the (key, *value* ) association is created.
-    When *key* is already associated value *value0*, then the association (*key*, *value0*) is removed
-    and association *(key, value)* is created;
-
-#.  *delete key*: When no value is currently associated with *key*, this operation has no effect.
-    When *key* is already associated  *value*, then association  *(key, value)* is removed;
-
-#.  *lookup key*: When no value is currently associated with  *key*, then this operation returns void value (lookup miss).
-    When *key* is associated with *value*, then this operation returns *value*.
-    The *(key, value)* association is not changed.
-
-The matching criterion used to compare the input key against the keys in the associative array is *exact match*,
-as the key size (number of bytes) and the key value (array of bytes) have to match exactly for the two keys under comparison.
-
-**Hash Function**
-
-A hash function deterministically maps data of variable length (key) to data of fixed size (hash value or key signature).
-Typically, the size of the key is bigger than the size of the key signature.
-The hash function basically compresses a long key into a short signature.
-Several keys can share the same signature (collisions).
-
-High quality hash functions have uniform distribution.
-For large number of keys, when dividing the space of signature values into a fixed number of equal intervals (buckets),
-it is desirable to have the key signatures evenly distributed across these intervals (uniform distribution),
-as opposed to most of the signatures going into only a few of the intervals
-and the rest of the intervals being largely unused (non-uniform distribution).
-
-**Hash Table**
-
-A hash table is an associative array that uses a hash function for its operation.
-The reason for using a hash function is to optimize the performance of the lookup operation
-by minimizing the number of table keys that have to be compared against the input key.
-
-Instead of storing the (key, value) pairs in a single list, the hash table maintains multiple lists (buckets).
-For any given key, there is a single bucket where that key might exist, and this bucket is uniquely identified based on the key signature.
-Once the key signature is computed and the hash table bucket identified,
-the key is either located in this bucket or it is not present in the hash table at all,
-so the key search can be narrowed down from the full set of keys currently in the table
-to just the set of keys currently in the identified table bucket.
-
-The performance of the hash table lookup operation is greatly improved,
-provided that the table keys are evenly distributed among the hash table buckets,
-which can be achieved by using a hash function with uniform distribution.
-The rule to map a key to its bucket can simply be to use the key signature (modulo the number of table buckets) as the table bucket ID:
-
-    *bucket_id = f_hash(key) % n_buckets;*
-
-By selecting the number of buckets to be a power of two, the modulo operator can be replaced by a bitwise AND logical operation:
-
-    *bucket_id = f_hash(key) & (n_buckets - 1);*
-
-considering *n_bits* as the number of bits set in *bucket_mask = n_buckets - 1*,
-this means that all the keys that end up in the same hash table bucket have the lower *n_bits* of their signature identical.
-In order to reduce the number of keys in the same bucket (collisions), the number of hash table buckets needs to be increased.
-
-In packet processing context, the sequence of operations involved in hash table operations
-is described in :numref:`packet_framework_figure_33`:
-
-.. _packet_framework_figure_33:
-
-.. figure:: img/figure33.*
-
-   Sequence of Steps for Hash Table Operations in a Packet Processing Context
-
-
-
-Hash Table Use Cases
-^^^^^^^^^^^^^^^^^^^^
-
-**Flow Classification**
-
-*Description:* The flow classification is executed at least once for each input packet.
-This operation maps each incoming packet against one of the known traffic flows in the flow database that typically contains millions of flows.
-
-*Hash table name:* Flow classification table
-
-*Number of keys:* Millions
-
-*Key format:* n-tuple of packet fields that uniquely identify a traffic flow/connection.
-Example: DiffServ 5-tuple of (Source IP address, Destination IP address, L4 protocol, L4 protocol source port, L4 protocol destination port).
-For IPv4 protocol and L4 protocols like TCP, UDP or SCTP, the size of the DiffServ 5-tuple is 13 bytes, while for IPv6 it is 37 bytes.
-
-*Key value (key data):* actions and action meta-data describing what processing to be applied for the packets of the current flow.
-The size of the data associated with each traffic flow can vary from 8 bytes to kilobytes.
-
-**Address Resolution Protocol (ARP)**
-
-*Description:* Once a route has been identified for an IP packet (so the output interface and the IP address of the next hop station are known),
-the MAC address of the next hop station is needed in order to send this packet onto the next leg of the journey
-towards its destination (as identified by its destination IP address).
-The MAC address of the next hop station becomes the destination MAC address of the outgoing Ethernet frame.
-
-*Hash table name:* ARP table
-
-*Number of keys:* Thousands
-
-*Key format:* The pair of (Output interface, Next Hop IP address), which is typically 5 bytes for IPv4 and 17 bytes for IPv6.
-
-*Key value (key data):* MAC address of the next hop station (6 bytes).
-
-Hash Table Types
-^^^^^^^^^^^^^^^^
-
-:numref:`packet_framework_table_qos_22` lists the hash table configuration parameters
-shared by all different hash table types.
-
-.. _packet_framework_table_qos_22:
-
-.. table:: Configuration Parameters Common for All Hash Table Types
-
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | # | Parameter                 | Details                                                                      |
-   |   |                           |                                                                              |
-   +===+===========================+==============================================================================+
-   | 1 | Key size                  | Measured as number of bytes. All keys have the same size.                    |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 2 | Key value (key data) size | Measured as number of bytes.                                                 |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 3 | Number of buckets         | Needs to be a power of two.                                                  |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 4 | Maximum number of keys    | Needs to be a power of two.                                                  |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 5 | Hash function             | Examples: jhash, CRC hash, etc.                                              |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 6 | Hash function seed        | Parameter to be passed to the hash function.                                 |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 7 | Key offset                | Offset of the lookup key byte array within the packet meta-data stored in    |
-   |   |                           | the packet buffer.                                                           |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-
-Bucket Full Problem
-"""""""""""""""""""
-
-On initialization, each hash table bucket is allocated space for exactly 4 keys.
-As keys are added to the table, it can happen that a given bucket already has 4 keys when a new key has to be added to this bucket.
-The possible options are:
-
-#.  **Least Recently Used (LRU) Hash Table.**
-    One of the existing keys in the bucket is deleted and the new key is added in its place.
-    The number of keys in each bucket never grows bigger than 4. The logic to pick the key to be dropped from the bucket is LRU.
-    The hash table lookup operation maintains the order in which the keys in the same bucket are hit, so every time a key is hit,
-    it becomes the new Most Recently Used (MRU) key, i.e. the last candidate for drop.
-    When a key is added to the bucket, it also becomes the new MRU key.
-    When a key needs to be picked and dropped, the first candidate for drop, i.e. the current LRU key, is always picked.
-    The LRU logic requires maintaining specific data structures per each bucket.
-
-#.  **Extendable Bucket Hash Table.**
-    The bucket is extended with space for 4 more keys.
-    This is done by allocating additional memory at table initialization time,
-    which is used to create a pool of free keys (the size of this pool is configurable and always a multiple of 4).
-    On key add operation, the allocation of a group of 4 keys only happens successfully within the limit of free keys,
-    otherwise the key add operation fails.
-    On key delete operation, a group of 4 keys is freed back to the pool of free keys
-    when the key to be deleted is the only key that was used within its group of 4 keys at that time.
-    On key lookup operation, if the current bucket is in extended state and a match is not found in the first group of 4 keys,
-    the search continues beyond the first group of 4 keys, potentially until all keys in this bucket are examined.
-    The extendable bucket logic requires maintaining specific data structures per table and per each bucket.
-
-.. table:: Configuration Parameters Specific to Extendable Bucket Hash Table
-
-   +---+---------------------------+--------------------------------------------------+
-   | # | Parameter                 | Details                                          |
-   |   |                           |                                                  |
-   +===+===========================+==================================================+
-   | 1 | Number of additional keys | Needs to be a power of two, at least equal to 4. |
-   |   |                           |                                                  |
-   +---+---------------------------+--------------------------------------------------+
-
-
-Signature Computation
-"""""""""""""""""""""
-
-The possible options for key signature computation are:
-
-#.  **Pre-computed key signature.**
-    The key lookup operation is split between two CPU cores.
-    The first CPU core (typically the CPU core that performs packet RX) extracts the key from the input packet,
-    computes the key signature and saves both the key and the key signature in the packet buffer as packet meta-data.
-    The second CPU core reads both the key and the key signature from the packet meta-data
-    and performs the bucket search step of the key lookup operation.
-
-#.  **Key signature computed on lookup ("do-sig" version).**
-    The same CPU core reads the key from the packet meta-data, uses it to compute the key signature
-    and also performs the bucket search step of the key lookup operation.
-
-.. table:: Configuration Parameters Specific to Pre-computed Key Signature Hash Table
-
-   +---+------------------+-----------------------------------------------------------------------+
-   | # | Parameter        | Details                                                               |
-   |   |                  |                                                                       |
-   +===+==================+=======================================================================+
-   | 1 | Signature offset | Offset of the pre-computed key signature within the packet meta-data. |
-   |   |                  |                                                                       |
-   +---+------------------+-----------------------------------------------------------------------+
-
-Key Size Optimized Hash Tables
-""""""""""""""""""""""""""""""
-
-For specific key sizes, the data structures and algorithm of key lookup operation can be specially handcrafted for further performance improvements,
-so following options are possible:
-
-#.  **Implementation supporting configurable key size.**
-
-#.  **Implementation supporting a single key size.**
-    Typical key sizes are 8 bytes and 16 bytes.
-
-Bucket Search Logic for Configurable Key Size Hash Tables
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The performance of the bucket search logic is one of the main factors influencing the performance of the key lookup operation.
-The data structures and algorithm are designed to make the best use of Intel CPU architecture resources like:
-cache memory space, cache memory bandwidth, external memory bandwidth, multiple execution units working in parallel,
-out of order instruction execution, special CPU instructions, etc.
-
-The bucket search logic handles multiple input packets in parallel.
-It is built as a pipeline of several stages (3 or 4), with each pipeline stage handling two different packets from the burst of input packets.
-On each pipeline iteration, the packets are pushed to the next pipeline stage: for the 4-stage pipeline,
-two packets (that just completed stage 3) exit the pipeline,
-two packets (that just completed stage 2) are now executing stage 3, two packets (that just completed stage 1) are now executing stage 2,
-two packets (that just completed stage 0) are now executing stage 1 and two packets (next two packets to read from the burst of input packets)
-are entering the pipeline to execute stage 0.
-The pipeline iterations continue until all packets from the burst of input packets execute the last stage of the pipeline.
-
-The bucket search logic is broken into pipeline stages at the boundary of the next memory access.
-Each pipeline stage uses data structures that are stored (with high probability) into the L1 or L2 cache memory of the current CPU core and
-breaks just before the next memory access required by the algorithm.
-The current pipeline stage finalizes by prefetching the data structures required by the next pipeline stage,
-so given enough time for the prefetch to complete,
-when the next pipeline stage eventually gets executed for the same packets,
-it will read the data structures it needs from L1 or L2 cache memory and thus avoid the significant penalty incurred by L2 or L3 cache memory miss.
-
-By prefetching the data structures required by the next pipeline stage in advance (before they are used)
-and switching to executing another pipeline stage for different packets,
-the number of L2 or L3 cache memory misses is greatly reduced, hence one of the main reasons for improved performance.
-This is because the cost of L2/L3 cache memory miss on memory read accesses is high, as usually due to data dependency between instructions,
-the CPU execution units have to stall until the read operation is completed from L3 cache memory or external DRAM memory.
-By using prefetch instructions, the latency of memory read accesses is hidden,
-provided that it is performed early enough before the respective data structure is actually used.
-
-By splitting the processing into several stages that are executed on different packets (the packets from the input burst are interlaced),
-enough work is created to allow the prefetch instructions to complete successfully (before the prefetched data structures are actually accessed) and
-also the data dependency between instructions is loosened.
-For example, for the 4-stage pipeline, stage 0 is executed on packets 0 and 1 and then,
-before same packets 0 and 1 are used (i.e. before stage 1 is executed on packets 0 and 1),
-different packets are used: packets 2 and 3 (executing stage 1), packets 4 and 5 (executing stage 2) and packets 6 and 7 (executing stage 3).
-By executing useful work while the data structures are brought into the L1 or L2 cache memory, the latency of the read memory accesses is hidden.
-By increasing the gap between two consecutive accesses to the same data structure, the data dependency between instructions is loosened;
-this allows making the best use of the super-scalar and out-of-order execution CPU architecture,
-as the number of CPU core execution units that are active (rather than idle or stalled due to data dependency constraints between instructions) is maximized.
-
-The bucket search logic is also implemented without using any branch instructions.
-This avoids the important cost associated with flushing the CPU core execution pipeline on every instance of branch misprediction.
-
-Configurable Key Size Hash Table
-""""""""""""""""""""""""""""""""
-
-:numref:`packet_framework_figure_34`, :numref:`packet_framework_table_qos_25`
-and :numref:`packet_framework_table_qos_26`
-detail the main data structures used to implement configurable key size hash tables
-(either LRU or extendable bucket, either with pre-computed signature or "do-sig").
-
-.. _packet_framework_figure_34:
-
-.. figure:: img/figure34.*
-
-   Data Structures for Configurable Key Size Hash Tables
-
-
-.. _packet_framework_table_qos_25:
-
-.. table:: Main Large Data Structures (Arrays) used for Configurable Key Size Hash Tables
-
-   +---+-------------------------+------------------------------+---------------------------+-------------------------------+
-   | # | Array name              | Number of entries            | Entry size (bytes)        | Description                   |
-   |   |                         |                              |                           |                               |
-   +===+=========================+==============================+===========================+===============================+
-   | 1 | Bucket array            | n_buckets (configurable)     | 32                        | Buckets of the hash table.    |
-   |   |                         |                              |                           |                               |
-   +---+-------------------------+------------------------------+---------------------------+-------------------------------+
-   | 2 | Bucket extensions array | n_buckets_ext (configurable) | 32                        | This array is only created    |
-   |   |                         |                              |                           | for extendable bucket tables. |
-   |   |                         |                              |                           |                               |
-   +---+-------------------------+------------------------------+---------------------------+-------------------------------+
-   | 3 | Key array               | n_keys                       | key_size (configurable)   | Keys added to the hash table. |
-   |   |                         |                              |                           |                               |
-   +---+-------------------------+------------------------------+---------------------------+-------------------------------+
-   | 4 | Data array              | n_keys                       | entry_size (configurable) | Key values (key data)         |
-   |   |                         |                              |                           | associated with the hash      |
-   |   |                         |                              |                           | table keys.                   |
-   |   |                         |                              |                           |                               |
-   +---+-------------------------+------------------------------+---------------------------+-------------------------------+
-
-.. _packet_framework_table_qos_26:
-
-.. table:: Field Description for Bucket Array Entry (Configurable Key Size Hash Tables)
-
-   +---+------------------+--------------------+------------------------------------------------------------------+
-   | # | Field name       | Field size (bytes) | Description                                                      |
-   |   |                  |                    |                                                                  |
-   +===+==================+====================+==================================================================+
-   | 1 | Next Ptr/LRU     | 8                  | For LRU tables, this fields represents the LRU list for the      |
-   |   |                  |                    | current bucket stored as array of 4 entries of 2 bytes each.     |
-   |   |                  |                    | Entry 0 stores the index (0 .. 3) of the MRU key, while entry 3  |
-   |   |                  |                    | stores the index of the LRU key.                                 |
-   |   |                  |                    |                                                                  |
-   |   |                  |                    | For extendable bucket tables, this field represents the next     |
-   |   |                  |                    | pointer (i.e. the pointer to the next group of 4 keys linked to  |
-   |   |                  |                    | the current bucket). The next pointer is not NULL if the bucket  |
-   |   |                  |                    | is currently extended or NULL otherwise.                         |
-   |   |                  |                    | To help the branchless implementation, bit 0 (least significant  |
-   |   |                  |                    | bit) of this field is set to 1 if the next pointer is not NULL   |
-   |   |                  |                    | and to 0 otherwise.                                              |
-   |   |                  |                    |                                                                  |
-   +---+------------------+--------------------+------------------------------------------------------------------+
-   | 2 | Sig[0 .. 3]      | 4 x 2              | If key X (X = 0 .. 3) is valid, then sig X bits 15 .. 1 store    |
-   |   |                  |                    | the most significant 15 bits of key X signature and sig X bit 0  |
-   |   |                  |                    | is set to 1.                                                     |
-   |   |                  |                    |                                                                  |
-   |   |                  |                    | If key X is not valid, then sig X is set to zero.                |
-   |   |                  |                    |                                                                  |
-   +---+------------------+--------------------+------------------------------------------------------------------+
-   | 3 | Key Pos [0 .. 3] | 4 x 4              | If key X is valid (X = 0 .. 3), then Key Pos X represents the    |
-   |   |                  |                    | index into the key array where key X is stored, as well as the   |
-   |   |                  |                    | index into the data array where the value associated with key X  |
-   |   |                  |                    | is stored.                                                       |
-   |   |                  |                    |                                                                  |
-   |   |                  |                    | If key X is not valid, then the value of Key Pos X is undefined. |
-   |   |                  |                    |                                                                  |
-   +---+------------------+--------------------+------------------------------------------------------------------+
-
-
-:numref:`packet_framework_figure_35` and :numref:`packet_framework_table_qos_27`
-detail the bucket search pipeline stages
-(either LRU or extendable bucket, either with pre-computed signature or "do-sig").
-For each pipeline stage, the described operations are applied to each of the two packets handled by that stage.
-
-.. _packet_framework_figure_35:
-
-.. figure:: img/figure35.*
-
-   Bucket Search Pipeline for Key Lookup Operation (Configurable Key Size Hash
-   Tables)
-
-
-.. _packet_framework_table_qos_27:
-
-.. table:: Description of the Bucket Search Pipeline Stages (Configurable Key Size Hash Tables)
-
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | # | Stage name                | Description                                                                  |
-   |   |                           |                                                                              |
-   +===+===========================+==============================================================================+
-   | 0 | Prefetch packet meta-data | Select next two packets from the burst of input packets.                     |
-   |   |                           |                                                                              |
-   |   |                           | Prefetch packet meta-data containing the key and key signature.              |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 1 | Prefetch table bucket     | Read the key signature from the packet meta-data (for extendable bucket hash |
-   |   |                           | tables) or read the key from the packet meta-data and compute key signature  |
-   |   |                           | (for LRU tables).                                                            |
-   |   |                           |                                                                              |
-   |   |                           | Identify the bucket ID using the key signature.                              |
-   |   |                           |                                                                              |
-   |   |                           | Set bit 0 of the signature to 1 (to match only signatures of valid keys from |
-   |   |                           | the table).                                                                  |
-   |   |                           |                                                                              |
-   |   |                           | Prefetch the bucket.                                                         |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 2 | Prefetch table key        | Read the key signatures from the bucket.                                     |
-   |   |                           |                                                                              |
-   |   |                           | Compare the signature of the input key against the 4 key signatures from the |
-   |   |                           | packet. As result, the following is obtained:                                |
-   |   |                           |                                                                              |
-   |   |                           | *match*                                                                      |
-   |   |                           | = equal to TRUE if there was at least one signature match and to FALSE in    |
-   |   |                           | the case of no signature match;                                              |
-   |   |                           |                                                                              |
-   |   |                           | *match_many*                                                                 |
-   |   |                           | = equal to TRUE is there were more than one signature matches (can be up to  |
-   |   |                           | 4 signature matches in the worst case scenario) and to FALSE otherwise;      |
-   |   |                           |                                                                              |
-   |   |                           | *match_pos*                                                                  |
-   |   |                           | = the index of the first key that produced signature match (only valid if    |
-   |   |                           | match is true).                                                              |
-   |   |                           |                                                                              |
-   |   |                           | For extendable bucket hash tables only, set                                  |
-   |   |                           | *match_many*                                                                 |
-   |   |                           | to TRUE if next pointer is valid.                                            |
-   |   |                           |                                                                              |
-   |   |                           | Prefetch the bucket key indicated by                                         |
-   |   |                           | *match_pos*                                                                  |
-   |   |                           | (even if                                                                     |
-   |   |                           | *match_pos*                                                                  |
-   |   |                           | does not point to valid key valid).                                          |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-   | 3 | Prefetch table data       | Read the bucket key indicated by                                             |
-   |   |                           | *match_pos*.                                                                 |
-   |   |                           |                                                                              |
-   |   |                           | Compare the bucket key against the input key. As result, the following is    |
-   |   |                           | obtained:                                                                    |
-   |   |                           | *match_key*                                                                  |
-   |   |                           | = equal to TRUE if the two keys match and to FALSE otherwise.                |
-   |   |                           |                                                                              |
-   |   |                           | Report input key as lookup hit only when both                                |
-   |   |                           | *match*                                                                      |
-   |   |                           | and                                                                          |
-   |   |                           | *match_key*                                                                  |
-   |   |                           | are equal to TRUE and as lookup miss otherwise.                              |
-   |   |                           |                                                                              |
-   |   |                           | For LRU tables only, use branchless logic to update the bucket LRU list      |
-   |   |                           | (the current key becomes the new MRU) only on lookup hit.                    |
-   |   |                           |                                                                              |
-   |   |                           | Prefetch the key value (key data) associated with the current key (to avoid  |
-   |   |                           | branches, this is done on both lookup hit and miss).                         |
-   |   |                           |                                                                              |
-   +---+---------------------------+------------------------------------------------------------------------------+
-
-
-Additional notes:
-
-#.  The pipelined version of the bucket search algorithm is executed only if there are at least 7 packets in the burst of input packets.
-    If there are less than 7 packets in the burst of input packets,
-    a non-optimized implementation of the bucket search algorithm is executed.
-
-#.  Once the pipelined version of the bucket search algorithm has been executed for all the packets in the burst of input packets,
-    the non-optimized implementation of the bucket search algorithm is also executed for any packets that did not produce a lookup hit,
-    but have the *match_many* flag set.
-    As result of executing the non-optimized version, some of these packets may produce a lookup hit or lookup miss.
-    This does not impact the performance of the key lookup operation,
-    as the probability of matching more than one signature in the same group of 4 keys or of having the bucket in extended state
-    (for extendable bucket hash tables only) is relatively small.
-
-**Key Signature Comparison Logic**
-
-The key signature comparison logic is described in :numref:`packet_framework_table_qos_28`.
-
-.. _packet_framework_table_qos_28:
-
-.. table:: Lookup Tables for Match, Match_Many and Match_Pos
-
-   +----+------+---------------+--------------------+--------------------+
-   | #  | mask | match (1 bit) | match_many (1 bit) | match_pos (2 bits) |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 0  | 0000 | 0             | 0                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 1  | 0001 | 1             | 0                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 2  | 0010 | 1             | 0                  | 01                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 3  | 0011 | 1             | 1                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 4  | 0100 | 1             | 0                  | 10                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 5  | 0101 | 1             | 1                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 6  | 0110 | 1             | 1                  | 01                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 7  | 0111 | 1             | 1                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 8  | 1000 | 1             | 0                  | 11                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 9  | 1001 | 1             | 1                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 10 | 1010 | 1             | 1                  | 01                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 11 | 1011 | 1             | 1                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 12 | 1100 | 1             | 1                  | 10                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 13 | 1101 | 1             | 1                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 14 | 1110 | 1             | 1                  | 01                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-   | 15 | 1111 | 1             | 1                  | 00                 |
-   |    |      |               |                    |                    |
-   +----+------+---------------+--------------------+--------------------+
-
-The input *mask* hash bit X (X = 0 .. 3) set to 1 if input signature is equal to bucket signature X and set to 0 otherwise.
-The outputs *match*, *match_many* and *match_pos* are 1 bit, 1 bit and 2 bits in size respectively and their meaning has been explained above.
-
-As displayed in :numref:`packet_framework_table_qos_29`,
-the lookup tables for *match* and *match_many* can be collapsed into a single 32-bit value
-and the lookup table for *match_pos* can be collapsed into a 64-bit value.
-Given the input *mask*, the values for *match*, *match_many* and *match_pos* can be obtained by indexing their respective bit array to extract 1 bit,
-1 bit and 2 bits respectively with branchless logic.
-
-.. _packet_framework_table_qos_29:
-
-.. table:: Collapsed Lookup Tables for Match, Match_Many and Match_Pos
-
-   +------------+------------------------------------------+-------------------+
-   |            | Bit array                                | Hexadecimal value |
-   |            |                                          |                   |
-   +------------+------------------------------------------+-------------------+
-   | match      | 1111_1111_1111_1110                      | 0xFFFELLU         |
-   |            |                                          |                   |
-   +------------+------------------------------------------+-------------------+
-   | match_many | 1111_1110_1110_1000                      | 0xFEE8LLU         |
-   |            |                                          |                   |
-   +------------+------------------------------------------+-------------------+
-   | match_pos  | 0001_0010_0001_0011__0001_0010_0001_0000 | 0x12131210LLU     |
-   |            |                                          |                   |
-   +------------+------------------------------------------+-------------------+
-
-
-The pseudo-code for match, match_many and match_pos is::
-
-    match = (0xFFFELLU >> mask) & 1;
-
-    match_many = (0xFEE8LLU >> mask) & 1;
-
-    match_pos = (0x12131210LLU >> (mask << 1)) & 3;
-
-Single Key Size Hash Tables
-"""""""""""""""""""""""""""
-
-:numref:`packet_framework_figure_37`, :numref:`packet_framework_figure_38`,
-:numref:`packet_framework_table_qos_30` and :numref:`packet_framework_table_qos_31`
-detail the main data structures used to implement 8-byte and 16-byte key hash tables
-(either LRU or extendable bucket, either with pre-computed signature or "do-sig").
-
-.. _packet_framework_figure_37:
-
-.. figure:: img/figure37.*
-
-   Data Structures for 8-byte Key Hash Tables
-
-
-.. _packet_framework_figure_38:
-
-.. figure:: img/figure38.*
-
-   Data Structures for 16-byte Key Hash Tables
-
-
-.. _packet_framework_table_qos_30:
-
-.. table:: Main Large Data Structures (Arrays) used for 8-byte and 16-byte Key Size Hash Tables
-
-   +---+-------------------------+------------------------------+----------------------+------------------------------------+
-   | # | Array name              | Number of entries            | Entry size (bytes)   | Description                        |
-   |   |                         |                              |                      |                                    |
-   +===+=========================+==============================+======================+====================================+
-   | 1 | Bucket array            | n_buckets (configurable)     | *8-byte key size:*   | Buckets of the hash table.         |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              | 64 + 4 x entry_size  |                                    |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              | *16-byte key size:*  |                                    |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              | 128 + 4 x entry_size |                                    |
-   |   |                         |                              |                      |                                    |
-   +---+-------------------------+------------------------------+----------------------+------------------------------------+
-   | 2 | Bucket extensions array | n_buckets_ext (configurable) | *8-byte key size:*   | This array is only created for     |
-   |   |                         |                              |                      | extendable bucket tables.          |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              | 64 + 4 x entry_size  |                                    |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              | *16-byte key size:*  |                                    |
-   |   |                         |                              |                      |                                    |
-   |   |                         |                              | 128 + 4 x entry_size |                                    |
-   |   |                         |                              |                      |                                    |
-   +---+-------------------------+------------------------------+----------------------+------------------------------------+
-
-.. _packet_framework_table_qos_31:
-
-.. table:: Field Description for Bucket Array Entry (8-byte and 16-byte Key Hash Tables)
-
-   +---+---------------+--------------------+-------------------------------------------------------------------------------+
-   | # | Field name    | Field size (bytes) | Description                                                                   |
-   |   |               |                    |                                                                               |
-   +===+===============+====================+===============================================================================+
-   | 1 | Valid         | 8                  | Bit X (X = 0 .. 3) is set to 1 if key X is valid or to 0 otherwise.           |
-   |   |               |                    |                                                                               |
-   |   |               |                    | Bit 4 is only used for extendable bucket tables to help with the              |
-   |   |               |                    | implementation of the branchless logic. In this case, bit 4 is set to 1 if    |
-   |   |               |                    | next pointer is valid (not NULL) or to 0 otherwise.                           |
-   |   |               |                    |                                                                               |
-   +---+---------------+--------------------+-------------------------------------------------------------------------------+
-   | 2 | Next Ptr/LRU  | 8                  | For LRU tables, this fields represents the LRU list for the current bucket    |
-   |   |               |                    | stored as array of 4 entries of 2 bytes each. Entry 0 stores the index        |
-   |   |               |                    | (0 .. 3) of the MRU key, while entry 3 stores the index of the LRU key.       |
-   |   |               |                    |                                                                               |
-   |   |               |                    | For extendable bucket tables, this field represents the next pointer (i.e.    |
-   |   |               |                    | the pointer to the next group of 4 keys linked to the current bucket). The    |
-   |   |               |                    | next pointer is not NULL if the bucket is currently extended or NULL          |
-   |   |               |                    | otherwise.                                                                    |
-   |   |               |                    |                                                                               |
-   +---+---------------+--------------------+-------------------------------------------------------------------------------+
-   | 3 | Key [0 .. 3]  | 4 x key_size       | Full keys.                                                                    |
-   |   |               |                    |                                                                               |
-   +---+---------------+--------------------+-------------------------------------------------------------------------------+
-   | 4 | Data [0 .. 3] | 4 x entry_size     | Full key values (key data) associated with keys 0 .. 3.                       |
-   |   |               |                    |                                                                               |
-   +---+---------------+--------------------+-------------------------------------------------------------------------------+
-
-and detail the bucket search pipeline used to implement 8-byte and 16-byte key hash tables (either LRU or extendable bucket,
-either with pre-computed signature or "do-sig").
-For each pipeline stage, the described operations are applied to each of the two packets handled by that stage.
-
-.. figure:: img/figure39.*
-
-   Bucket Search Pipeline for Key Lookup Operation (Single Key Size Hash
-   Tables)
-
-.. table:: Description of the Bucket Search Pipeline Stages (8-byte and 16-byte Key Hash Tables)
-
-   +---+---------------------------+-----------------------------------------------------------------------------+
-   | # | Stage name                | Description                                                                 |
-   |   |                           |                                                                             |
-   +===+===========================+=============================================================================+
-   | 0 | Prefetch packet meta-data | #.  Select next two packets from the burst of input packets.                |
-   |   |                           |                                                                             |
-   |   |                           | #.  Prefetch packet meta-data containing the key and key signature.         |
-   |   |                           |                                                                             |
-   +---+---------------------------+-----------------------------------------------------------------------------+
-   | 1 | Prefetch table bucket     | #.  Read the key signature from the packet meta-data (for extendable bucket |
-   |   |                           |     hash tables) or read the key from the packet meta-data and compute key  |
-   |   |                           |     signature (for LRU tables).                                             |
-   |   |                           |                                                                             |
-   |   |                           | #.  Identify the bucket ID using the key signature.                         |
-   |   |                           |                                                                             |
-   |   |                           | #.  Prefetch the bucket.                                                    |
-   |   |                           |                                                                             |
-   +---+---------------------------+-----------------------------------------------------------------------------+
-   | 2 | Prefetch table data       | #.  Read the bucket.                                                        |
-   |   |                           |                                                                             |
-   |   |                           | #.  Compare all 4 bucket keys against the input key.                        |
-   |   |                           |                                                                             |
-   |   |                           | #.  Report input key as lookup hit only when a match is identified (more    |
-   |   |                           |     than one key match is not possible)                                     |
-   |   |                           |                                                                             |
-   |   |                           | #.  For LRU tables only, use branchless logic to update the bucket LRU list |
-   |   |                           |     (the current key becomes the new MRU) only on lookup hit.               |
-   |   |                           |                                                                             |
-   |   |                           | #.  Prefetch the key value (key data) associated with the matched key (to   |
-   |   |                           |     avoid branches, this is done on both lookup hit and miss).              |
-   |   |                           |                                                                             |
-   +---+---------------------------+-----------------------------------------------------------------------------+
-
-Additional notes:
-
-#.  The pipelined version of the bucket search algorithm is executed only if there are at least 5 packets in the burst of input packets.
-    If there are less than 5 packets in the burst of input packets, a non-optimized implementation of the bucket search algorithm is executed.
-
-#.  For extendable bucket hash tables only,
-    once the pipelined version of the bucket search algorithm has been executed for all the packets in the burst of input packets,
-    the non-optimized implementation of the bucket search algorithm is also executed for any packets that did not produce a lookup hit,
-    but have the bucket in extended state.
-    As result of executing the non-optimized version, some of these packets may produce a lookup hit or lookup miss.
-    This does not impact the performance of the key lookup operation,
-    as the probability of having the bucket in extended state is relatively small.
-
 The Software Switch (SWX) Pipeline
 ----------------------------------
 
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 758652a492..9dcf86098f 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -148,11 +148,6 @@ Deprecation Notices
   The graph walk functions will process nodes in topological order
   using bitmap scanning instead of the circular buffer.
 
-* table: The table library legacy API (functions rte_table_*)
-  will be deprecated and subsequently removed in DPDK 24.11 release.
-  Before this, the new table library API (functions rte_swx_table_*)
-  will gradually transition from experimental to stable status.
-
 * port: The port library legacy API (functions rte_port_*)
   will be deprecated and subsequently removed in DPDK 24.11 release.
   Before this, the new port library API (functions rte_swx_port_*)
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a1056ae5d2..306482c1d9 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,9 @@ Removed Items
   ``rte_port_in_action_*`` and ``rte_table_action_*`` functions.
   The SWX pipeline API (``rte_swx_pipeline_*``) remains.
 
+* Removed the legacy table library API (``rte_table_*`` functions).
+  The SWX table API (``rte_swx_table_*``) remains.
+
 
 API Changes
 -----------
diff --git a/lib/table/meson.build b/lib/table/meson.build
index e27957fe89..620c20e594 100644
--- a/lib/table/meson.build
+++ b/lib/table/meson.build
@@ -9,42 +9,14 @@ sources = files(
         'rte_swx_table_learner.c',
         'rte_swx_table_selector.c',
         'rte_swx_table_wm.c',
-        'rte_table_acl.c',
-        'rte_table_array.c',
-        'rte_table_hash_cuckoo.c',
-        'rte_table_hash_ext.c',
-        'rte_table_hash_key8.c',
-        'rte_table_hash_key16.c',
-        'rte_table_hash_key32.c',
-        'rte_table_hash_lru.c',
-        'rte_table_lpm.c',
-        'rte_table_lpm_ipv6.c',
-        'rte_table_stub.c',
-        'table_log.c',
 )
 
 headers = files(
-        'rte_lru.h',
         'rte_swx_hash_func.h',
         'rte_swx_table.h',
         'rte_swx_table_em.h',
         'rte_swx_table_learner.h',
         'rte_swx_table_selector.h',
         'rte_swx_table_wm.h',
-        'rte_table.h',
-        'rte_table_acl.h',
-        'rte_table_array.h',
-        'rte_table_hash.h',
-        'rte_table_hash_cuckoo.h',
-        'rte_table_hash_func.h',
-        'rte_table_lpm.h',
-        'rte_table_lpm_ipv6.h',
-        'rte_table_stub.h',
-)
-deps += ['mbuf', 'port', 'lpm', 'hash', 'acl']
-
-indirect_headers += files(
-        'rte_lru_arm64.h',
-        'rte_lru_x86.h',
-        'rte_table_hash_func_arm64.h',
 )
+deps += ['mbuf', 'hash', 'acl']
diff --git a/lib/table/rte_lru.h b/lib/table/rte_lru.h
deleted file mode 100644
index 1436425e16..0000000000
--- a/lib/table/rte_lru.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_LRU_H__
-#define __INCLUDE_RTE_LRU_H__
-
-#include <rte_config.h>
-#ifdef RTE_ARCH_X86_64
-#include "rte_lru_x86.h"
-#elif defined(RTE_ARCH_ARM64)
-#include "rte_lru_arm64.h"
-#else
-#undef RTE_TABLE_HASH_LRU_STRATEGY
-#define RTE_TABLE_HASH_LRU_STRATEGY                        1
-#endif
-
-#if RTE_TABLE_HASH_LRU_STRATEGY == 0
-
-#define lru_init(bucket)						\
-do									\
-	bucket = bucket;						\
-while (0)
-
-#define lru_pos(bucket) (bucket->lru_list & 0xFFFFLLU)
-
-#define lru_update(bucket, mru_val)					\
-do {									\
-	bucket = bucket;						\
-	mru_val = mru_val;						\
-} while (0)
-
-#elif RTE_TABLE_HASH_LRU_STRATEGY == 1
-
-#define lru_init(bucket)						\
-do									\
-	bucket->lru_list = 0x0000000100020003LLU;			\
-while (0)
-
-#define lru_pos(bucket) (bucket->lru_list & 0xFFFFLLU)
-
-#define lru_update(bucket, mru_val)					\
-do {									\
-	uint64_t _x, _pos, _x0, _x1, _x2, _mask;			\
-									\
-	_x = bucket->lru_list;						\
-									\
-	_pos = 4;							\
-	if ((_x >> 48) == ((uint64_t) mru_val))			\
-		_pos = 3;						\
-									\
-	if (((_x >> 32) & 0xFFFFLLU) == ((uint64_t) mru_val))		\
-		_pos = 2;						\
-									\
-	if (((_x >> 16) & 0xFFFFLLU) == ((uint64_t) mru_val))		\
-		_pos = 1;						\
-									\
-	if ((_x & 0xFFFFLLU) == ((uint64_t) mru_val))			\
-		_pos = 0;						\
-									\
-									\
-	_pos <<= 4;							\
-	_mask = (~0LLU) << _pos;					\
-	_x0 = _x & (~_mask);						\
-	_x1 = (_x >> 16) & _mask;					\
-	_x2 = (_x << (48 - _pos)) & (0xFFFFLLU << 48);			\
-	_x = _x0 | _x1 | _x2;						\
-									\
-	if (_pos != 64)							\
-		bucket->lru_list = _x;					\
-} while (0)
-
-#elif (RTE_TABLE_HASH_LRU_STRATEGY == 2) || (RTE_TABLE_HASH_LRU_STRATEGY == 3)
-
-/**
- * These strategies are implemented in architecture specific header files.
- */
-
-#else
-
-#error "Incorrect value for RTE_TABLE_HASH_LRU_STRATEGY"
-
-#endif
-
-#endif
diff --git a/lib/table/rte_lru_arm64.h b/lib/table/rte_lru_arm64.h
deleted file mode 100644
index 817b791b6e..0000000000
--- a/lib/table/rte_lru_arm64.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2017 Cavium, Inc
- */
-
-#ifndef __RTE_LRU_ARM64_H__
-#define __RTE_LRU_ARM64_H__
-
-#include <stdint.h>
-#include <rte_vect.h>
-#include <rte_bitops.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#ifndef RTE_TABLE_HASH_LRU_STRATEGY
-#ifdef __ARM_NEON
-#define RTE_TABLE_HASH_LRU_STRATEGY                        3
-#else /* if no NEON, use simple scalar version */
-#define RTE_TABLE_HASH_LRU_STRATEGY                        1
-#endif
-#endif
-
-#if RTE_TABLE_HASH_LRU_STRATEGY == 3
-
-#define lru_init(bucket)						\
-	{ bucket->lru_list = ~0LLU; }
-
-static inline int
-f_lru_pos(uint64_t lru_list)
-{
-	/* Compare the vector to zero vector */
-	uint16x4_t lru_vec = vld1_u16((uint16_t *)&lru_list);
-	uint16x4_t min_vec = vmov_n_u16(vminv_u16(lru_vec));
-	uint64_t mask = vget_lane_u64(vreinterpret_u64_u16(
-			vceq_u16(min_vec, lru_vec)), 0);
-	return rte_clz64(mask) >> 4;
-}
-#define lru_pos(bucket) f_lru_pos(bucket->lru_list)
-
-#define lru_update(bucket, mru_val)					\
-do {									\
-	const uint64_t _orvals[] = {0xFFFFLLU, 0xFFFFLLU << 16,		\
-		0xFFFFLLU << 32, 0xFFFFLLU << 48, 0LLU};		\
-	const uint64_t _decs[] = {0x1000100010001LLU, 0};		\
-	uint64x1_t _lru = vdup_n_u64(bucket->lru_list);			\
-	uint64x1_t _vdec = vdup_n_u64(_decs[mru_val>>2]);			\
-	bucket->lru_list = vget_lane_u64(vreinterpret_u64_u16(		\
-				vsub_u16(vreinterpret_u16_u64(_lru),	\
-					vreinterpret_u16_u64(_vdec))),	\
-				0);					\
-	bucket->lru_list |= _orvals[mru_val];				\
-} while (0)
-
-#endif
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_lru_x86.h b/lib/table/rte_lru_x86.h
deleted file mode 100644
index de74513653..0000000000
--- a/lib/table/rte_lru_x86.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_LRU_X86_H__
-#define __INCLUDE_RTE_LRU_X86_H__
-
-#include <stdint.h>
-
-#include <rte_config.h>
-#include <rte_common.h>
-
-#ifndef RTE_TABLE_HASH_LRU_STRATEGY
-#define RTE_TABLE_HASH_LRU_STRATEGY                        2
-#endif
-
-#if RTE_TABLE_HASH_LRU_STRATEGY == 2
-
-#if RTE_CC_IS_GNU
-#include <x86intrin.h>
-#else
-#include <emmintrin.h>
-#include <smmintrin.h>
-#include <xmmintrin.h>
-#endif
-
-#define lru_init(bucket)						\
-	{ bucket->lru_list = 0x0000000100020003LLU; }
-
-#define lru_pos(bucket) (bucket->lru_list & 0xFFFFLLU)
-
-#define lru_update(bucket, mru_val)					\
-do {									\
-	/* set up the masks for all possible shuffles, depends on pos */\
-	static uint64_t masks[10] = {					\
-		/* Shuffle order; Make Zero (see _mm_shuffle_epi8 manual) */\
-		0x0100070605040302, 0x8080808080808080,			\
-		0x0302070605040100, 0x8080808080808080,			\
-		0x0504070603020100, 0x8080808080808080,			\
-		0x0706050403020100, 0x8080808080808080,			\
-		0x0706050403020100, 0x8080808080808080};		\
-	/* load up one register with repeats of mru-val  */		\
-	uint64_t mru2 = mru_val;					\
-	uint64_t mru3 = mru2 | (mru2 << 16);				\
-	uint64_t lru = bucket->lru_list;				\
-	/* XOR to cause the word we're looking for to go to zero */	\
-	uint64_t mru = lru ^ ((mru3 << 32) | mru3);			\
-	__m128i c = _mm_cvtsi64_si128(mru);				\
-	__m128i b = _mm_cvtsi64_si128(lru);				\
-	/* Find the minimum value (first zero word, if it's in there) */\
-	__m128i d = _mm_minpos_epu16(c);				\
-	/* Second word is the index to found word (first word is the value) */\
-	unsigned int _pos = _mm_extract_epi16(d, 1);			\
-	/* move the recently used location to top of list */		\
-	__m128i k = _mm_shuffle_epi8(b, *((__m128i *) &masks[2 * _pos]));\
-	/* Finally, update the original list with the reordered data */	\
-	bucket->lru_list = _mm_extract_epi64(k, 0);			\
-	/* Phwew! */							\
-} while (0)
-
-#elif RTE_TABLE_HASH_LRU_STRATEGY == 3
-
-#if RTE_CC_IS_GNU
-#include <x86intrin.h>
-#else
-#include <emmintrin.h>
-#include <smmintrin.h>
-#include <xmmintrin.h>
-#endif
-
-#define lru_init(bucket)						\
-	{ bucket->lru_list = ~0LLU; }
-
-static inline int
-f_lru_pos(uint64_t lru_list)
-{
-	__m128i lst = _mm_set_epi64x((uint64_t)-1, lru_list);
-	__m128i min = _mm_minpos_epu16(lst);
-	return _mm_extract_epi16(min, 1);
-}
-#define lru_pos(bucket) f_lru_pos(bucket->lru_list)
-
-#define lru_update(bucket, mru_val)					\
-do {									\
-	const uint64_t orvals[] = {0xFFFFLLU, 0xFFFFLLU << 16,		\
-		0xFFFFLLU << 32, 0xFFFFLLU << 48, 0LLU};		\
-	const uint64_t decs[] = {0x1000100010001LLU, 0};		\
-	__m128i lru = _mm_cvtsi64_si128(bucket->lru_list);		\
-	__m128i vdec = _mm_cvtsi64_si128(decs[mru_val>>2]);		\
-	lru = _mm_subs_epu16(lru, vdec);				\
-	bucket->lru_list = _mm_extract_epi64(lru, 0) | orvals[mru_val];	\
-} while (0)
-
-#endif
-
-#endif
diff --git a/lib/table/rte_table.h b/lib/table/rte_table.h
deleted file mode 100644
index 2743070b32..0000000000
--- a/lib/table/rte_table.h
+++ /dev/null
@@ -1,263 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_H__
-#define __INCLUDE_RTE_TABLE_H__
-
-/**
- * @file
- * RTE Table
- *
- * This tool is part of the DPDK Packet Framework tool suite and provides
- * a standard interface to implement different types of lookup tables for data
- * plane processing.
- *
- * Virtually any search algorithm that can uniquely associate data to a lookup
- * key can be fitted under this lookup table abstraction. For the flow table
- * use-case, the lookup key is an n-tuple of packet fields that uniquely
- * identifies a traffic flow, while data represents actions and action
- * meta-data associated with the same traffic flow.
- */
-
-#include <stdint.h>
-#include <rte_port.h>
-
-struct rte_mbuf;
-
-/** Lookup table statistics */
-struct rte_table_stats {
-	uint64_t n_pkts_in;
-	uint64_t n_pkts_lookup_miss;
-};
-
-/**
- * Lookup table create
- *
- * @param params
- *   Parameters for lookup table creation. The underlying data structure is
- *   different for each lookup table type.
- * @param socket_id
- *   CPU socket ID (e.g. for memory allocation purpose)
- * @param entry_size
- *   Data size of each lookup table entry (measured in bytes)
- * @return
- *   Handle to lookup table instance
- */
-typedef void* (*rte_table_op_create)(void *params, int socket_id,
-	uint32_t entry_size);
-
-/**
- * Lookup table free
- *
- * @param table
- *   Handle to lookup table instance
- * @return
- *   0 on success, error code otherwise
- */
-typedef int (*rte_table_op_free)(void *table);
-
-/**
- * Lookup table entry add
- *
- * @param table
- *   Handle to lookup table instance
- * @param key
- *   Lookup key
- * @param entry
- *   Data to be associated with the current key. This parameter has to point to
- *   a valid memory buffer where the first entry_size bytes (table create
- *   parameter) are populated with the data.
- * @param key_found
- *   After successful invocation, *key_found is set to a value different than 0
- *   if the current key is already present in the table and to 0 if not. This
- *   pointer has to be set to a valid memory location before the table entry add
- *   function is called.
- * @param entry_ptr
- *   After successful invocation, *entry_ptr stores the handle to the table
- *   entry containing the data associated with the current key. This handle can
- *   be used to perform further read-write accesses to this entry. This handle
- *   is valid until the key is deleted from the table or the same key is
- *   re-added to the table, typically to associate it with different data. This
- *   pointer has to be set to a valid memory location before the function is
- *   called.
- * @return
- *   0 on success, error code otherwise
- */
-typedef int (*rte_table_op_entry_add)(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr);
-
-/**
- * Lookup table entry delete
- *
- * @param table
- *   Handle to lookup table instance
- * @param key
- *   Lookup key
- * @param key_found
- *   After successful invocation, *key_found is set to a value different than 0
- *   if the current key was present in the table before the delete operation
- *   was performed and to 0 if not. This pointer has to be set to a valid
- *   memory location before the table entry delete function is called.
- * @param entry
- *   After successful invocation, if the key is found in the table (*key found
- *   is different than 0 after function call is completed) and entry points to
- *   a valid buffer (entry is set to a value different than NULL before the
- *   function is called), then the first entry_size bytes (table create
- *   parameter) in *entry store a copy of table entry that contained the data
- *   associated with the current key before the key was deleted.
- * @return
- *   0 on success, error code otherwise
- */
-typedef int (*rte_table_op_entry_delete)(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry);
-
-/**
- * Lookup table entry add bulk
- *
- * @param table
- *   Handle to lookup table instance
- * @param keys
- *   Array containing lookup keys
- * @param entries
- *   Array containing data to be associated with each key. Every item in the
- *   array has to point to a valid memory buffer where the first entry_size
- *   bytes (table create parameter) are populated with the data.
- * @param n_keys
- *   Number of keys to add
- * @param key_found
- *   After successful invocation, key_found for every item in the array is set
- *   to a value different than 0 if the current key is already present in the
- *   table and to 0 if not. This pointer has to be set to a valid memory
- *   location before the table entry add function is called.
- * @param entries_ptr
- *   After successful invocation, array *entries_ptr stores the handle to the
- *   table entry containing the data associated with every key. This handle can
- *   be used to perform further read-write accesses to this entry. This handle
- *   is valid until the key is deleted from the table or the same key is
- *   re-added to the table, typically to associate it with different data. This
- *   pointer has to be set to a valid memory location before the function is
- *   called.
- * @return
- *   0 on success, error code otherwise
- */
-typedef int (*rte_table_op_entry_add_bulk)(
-	void *table,
-	void **keys,
-	void **entries,
-	uint32_t n_keys,
-	int *key_found,
-	void **entries_ptr);
-
-/**
- * Lookup table entry delete bulk
- *
- * @param table
- *   Handle to lookup table instance
- * @param keys
- *   Array containing lookup keys
- * @param n_keys
- *   Number of keys to delete
- * @param key_found
- *   After successful invocation, key_found for every item in the array is set
- *   to a value different than 0if the current key was present in the table
- *   before the delete operation was performed and to 0 if not. This pointer
- *   has to be set to a valid memory location before the table entry delete
- *   function is called.
- * @param entries
- *   If entries pointer is NULL, this pointer is ignored for every entry found.
- *   Else, after successful invocation, if specific key is found in the table
- *   (key_found is different than 0 for this item after function call is
- *   completed) and item of entry array points to a valid buffer (entry is set
- *   to a value different than NULL before the function is called), then the
- *   first entry_size bytes (table create parameter) in *entry store a copy of
- *   table entry that contained the data associated with the current key before
- *   the key was deleted.
- * @return
- *   0 on success, error code otherwise
- */
-typedef int (*rte_table_op_entry_delete_bulk)(
-	void *table,
-	void **keys,
-	uint32_t n_keys,
-	int *key_found,
-	void **entries);
-
-/**
- * Lookup table lookup
- *
- * @param table
- *   Handle to lookup table instance
- * @param pkts
- *   Burst of input packets specified as array of up to 64 pointers to struct
- *   rte_mbuf
- * @param pkts_mask
- *   64-bit bitmask specifying which packets in the input burst are valid. When
- *   pkts_mask bit n is set, then element n of pkts array is pointing to a
- *   valid packet. Otherwise, element n of pkts array does not point to a valid
- *   packet, therefore it will not be accessed.
- * @param lookup_hit_mask
- *   Once the table lookup operation is completed, this 64-bit bitmask
- *   specifies which of the valid packets in the input burst resulted in lookup
- *   hit. For each valid input packet (pkts_mask bit n is set), the following
- *   are true on lookup hit: lookup_hit_mask bit n is set, element n of entries
- *   array is valid and it points to the lookup table entry that was hit. For
- *   each valid input packet (pkts_mask bit n is set), the following are true
- *   on lookup miss: lookup_hit_mask bit n is not set and element n of entries
- *   array is not valid.
- * @param entries
- *   Once the table lookup operation is completed, this array provides the
- *   lookup table entries that were hit, as described above. It is required
- *   that this array is always pre-allocated by the caller of this function
- *   with exactly 64 elements. The implementation is allowed to speculatively
- *   modify the elements of this array, so elements marked as invalid in
- *   lookup_hit_mask once the table lookup operation is completed might have
- *   been modified by this function.
- * @return
- *   0 on success, error code otherwise
- */
-typedef int (*rte_table_op_lookup)(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries);
-
-/**
- * Lookup table stats read
- *
- * @param table
- *   Handle to lookup table instance
- * @param stats
- *   Handle to table stats struct to copy data
- * @param clear
- *   Flag indicating that stats should be cleared after read
- *
- * @return
- *   Error code or 0 on success.
- */
-typedef int (*rte_table_op_stats_read)(
-	void *table,
-	struct rte_table_stats *stats,
-	int clear);
-
-/** Lookup table interface defining the lookup table operation */
-struct rte_table_ops {
-	rte_table_op_create f_create;                 /**< Create */
-	rte_table_op_free f_free;                     /**< Free */
-	rte_table_op_entry_add f_add;                 /**< Entry add */
-	rte_table_op_entry_delete f_delete;           /**< Entry delete */
-	rte_table_op_entry_add_bulk f_add_bulk;       /**< Add entry bulk */
-	rte_table_op_entry_delete_bulk f_delete_bulk; /**< Delete entry bulk */
-	rte_table_op_lookup f_lookup;                 /**< Lookup */
-	rte_table_op_stats_read f_stats;              /**< Stats */
-};
-
-#endif
diff --git a/lib/table/rte_table_acl.c b/lib/table/rte_table_acl.c
deleted file mode 100644
index 74fa0145d8..0000000000
--- a/lib/table/rte_table_acl.c
+++ /dev/null
@@ -1,795 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_acl.h"
-
-#include "table_log.h"
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_ACL_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_ACL_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_ACL_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_ACL_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-struct rte_table_acl {
-	struct rte_table_stats stats;
-
-	/* Low-level ACL table */
-	char name[2][RTE_ACL_NAMESIZE];
-	struct rte_acl_param acl_params; /* for creating low level acl table */
-	struct rte_acl_config cfg; /* Holds the field definitions (metadata) */
-	struct rte_acl_ctx *ctx;
-	uint32_t name_id;
-
-	/* Input parameters */
-	uint32_t n_rules;
-	uint32_t entry_size;
-
-	/* Internal tables */
-	uint8_t *action_table;
-	struct rte_acl_rule **acl_rule_list; /* Array of pointers to rules */
-	uint8_t *acl_rule_memory; /* Memory to store the rules */
-
-	/* Memory to store the action table and stack of free entries */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t memory[];
-};
-
-
-static void *
-rte_table_acl_create(
-	void *params,
-	int socket_id,
-	uint32_t entry_size)
-{
-	struct rte_table_acl_params *p = params;
-	struct rte_table_acl *acl;
-	uint32_t action_table_size, acl_rule_list_size, acl_rule_memory_size;
-	uint32_t total_size;
-
-	RTE_BUILD_BUG_ON(((sizeof(struct rte_table_acl) % RTE_CACHE_LINE_SIZE)
-		!= 0));
-
-	/* Check input parameters */
-	if (p == NULL) {
-		TABLE_LOG(ERR, "%s: Invalid value for params", __func__);
-		return NULL;
-	}
-	if (p->name == NULL) {
-		TABLE_LOG(ERR, "%s: Invalid value for name", __func__);
-		return NULL;
-	}
-	if (p->n_rules == 0) {
-		TABLE_LOG(ERR, "%s: Invalid value for n_rules",
-			__func__);
-		return NULL;
-	}
-	if ((p->n_rule_fields == 0) ||
-	    (p->n_rule_fields > RTE_ACL_MAX_FIELDS)) {
-		TABLE_LOG(ERR, "%s: Invalid value for n_rule_fields",
-			__func__);
-		return NULL;
-	}
-
-	entry_size = RTE_ALIGN(entry_size, sizeof(uint64_t));
-
-	/* Memory allocation */
-	action_table_size = RTE_CACHE_LINE_ROUNDUP(p->n_rules * entry_size);
-	acl_rule_list_size =
-		RTE_CACHE_LINE_ROUNDUP(p->n_rules * sizeof(struct rte_acl_rule *));
-	acl_rule_memory_size = RTE_CACHE_LINE_ROUNDUP(p->n_rules *
-		RTE_ACL_RULE_SZ(p->n_rule_fields));
-	total_size = sizeof(struct rte_table_acl) + action_table_size +
-		acl_rule_list_size + acl_rule_memory_size;
-
-	acl = rte_zmalloc_socket("TABLE", total_size, RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (acl == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %u bytes for ACL table",
-			__func__, total_size);
-		return NULL;
-	}
-
-	acl->action_table = &acl->memory[0];
-	acl->acl_rule_list =
-		(struct rte_acl_rule **) &acl->memory[action_table_size];
-	acl->acl_rule_memory = (uint8_t *)
-		&acl->memory[action_table_size + acl_rule_list_size];
-
-	/* Initialization of internal fields */
-	snprintf(acl->name[0], RTE_ACL_NAMESIZE, "%s_a", p->name);
-	snprintf(acl->name[1], RTE_ACL_NAMESIZE, "%s_b", p->name);
-	acl->name_id = 1;
-
-	acl->acl_params.name = acl->name[acl->name_id];
-	acl->acl_params.socket_id = socket_id;
-	acl->acl_params.rule_size = RTE_ACL_RULE_SZ(p->n_rule_fields);
-	acl->acl_params.max_rule_num = p->n_rules;
-
-	acl->cfg.num_categories = 1;
-	acl->cfg.num_fields = p->n_rule_fields;
-	memcpy(&acl->cfg.defs[0], &p->field_format[0],
-		p->n_rule_fields * sizeof(struct rte_acl_field_def));
-
-	acl->ctx = NULL;
-
-	acl->n_rules = p->n_rules;
-	acl->entry_size = entry_size;
-
-	return acl;
-}
-
-static int
-rte_table_acl_free(void *table)
-{
-	struct rte_table_acl *acl = table;
-
-	/* Check input parameters */
-	if (table == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	/* Free previously allocated resources */
-	rte_acl_free(acl->ctx);
-
-	rte_free(acl);
-
-	return 0;
-}
-
-RTE_ACL_RULE_DEF(rte_pipeline_acl_rule, RTE_ACL_MAX_FIELDS);
-
-static int
-rte_table_acl_build(struct rte_table_acl *acl, struct rte_acl_ctx **acl_ctx)
-{
-	struct rte_acl_ctx *ctx = NULL;
-	uint32_t n_rules, i;
-	int status;
-
-	/* Create low level ACL table */
-	ctx = rte_acl_create(&acl->acl_params);
-	if (ctx == NULL) {
-		TABLE_LOG(ERR, "%s: Cannot create low level ACL table",
-			__func__);
-		return -1;
-	}
-
-	/* Add rules to low level ACL table */
-	n_rules = 0;
-	for (i = 1; i < acl->n_rules; i++) {
-		if (acl->acl_rule_list[i] != NULL) {
-			status = rte_acl_add_rules(ctx, acl->acl_rule_list[i],
-				1);
-			if (status != 0) {
-				TABLE_LOG(ERR,
-				"%s: Cannot add rule to low level ACL table",
-					__func__);
-				rte_acl_free(ctx);
-				return -1;
-			}
-
-			n_rules++;
-		}
-	}
-
-	if (n_rules == 0) {
-		rte_acl_free(ctx);
-		*acl_ctx = NULL;
-		return 0;
-	}
-
-	/* Build low level ACl table */
-	status = rte_acl_build(ctx, &acl->cfg);
-	if (status != 0) {
-		TABLE_LOG(ERR,
-			"%s: Cannot build the low level ACL table",
-			__func__);
-		rte_acl_free(ctx);
-		return -1;
-	}
-
-	*acl_ctx = ctx;
-	return 0;
-}
-
-static int
-rte_table_acl_entry_add(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_acl *acl = table;
-	struct rte_table_acl_rule_add_params *rule =
-		key;
-	struct rte_pipeline_acl_rule acl_rule;
-	struct rte_acl_rule *rule_location;
-	struct rte_acl_ctx *ctx;
-	uint32_t free_pos, free_pos_valid, i;
-	int status;
-
-	/* Check input parameters */
-	if (table == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (key == NULL) {
-		TABLE_LOG(ERR, "%s: key parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (entry == NULL) {
-		TABLE_LOG(ERR, "%s: entry parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (key_found == NULL) {
-		TABLE_LOG(ERR, "%s: key_found parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if (entry_ptr == NULL) {
-		TABLE_LOG(ERR, "%s: entry_ptr parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if (rule->priority > RTE_ACL_MAX_PRIORITY) {
-		TABLE_LOG(ERR, "%s: Priority is too high", __func__);
-		return -EINVAL;
-	}
-
-	/* Setup rule data structure */
-	memset(&acl_rule, 0, sizeof(acl_rule));
-	acl_rule.data.category_mask = 1;
-	acl_rule.data.priority = RTE_ACL_MAX_PRIORITY - rule->priority;
-	acl_rule.data.userdata = 0; /* To be set up later */
-	memcpy(&acl_rule.field[0],
-		&rule->field_value[0],
-		acl->cfg.num_fields * sizeof(struct rte_acl_field));
-
-	/* Look to see if the rule exists already in the table */
-	free_pos = 0;
-	free_pos_valid = 0;
-	for (i = 1; i < acl->n_rules; i++) {
-		if (acl->acl_rule_list[i] == NULL) {
-			if (free_pos_valid == 0) {
-				free_pos = i;
-				free_pos_valid = 1;
-			}
-
-			continue;
-		}
-
-		/* Compare the key fields */
-		status = memcmp(&acl->acl_rule_list[i]->field[0],
-			&rule->field_value[0],
-			acl->cfg.num_fields * sizeof(struct rte_acl_field));
-
-		/* Rule found: update data associated with the rule */
-		if (status == 0) {
-			*key_found = 1;
-			*entry_ptr = &acl->memory[i * acl->entry_size];
-			memcpy(*entry_ptr, entry, acl->entry_size);
-
-			return 0;
-		}
-	}
-
-	/* Return if max rules */
-	if (free_pos_valid == 0) {
-		TABLE_LOG(ERR, "%s: Max number of rules reached",
-			__func__);
-		return -ENOSPC;
-	}
-
-	/* Add the new rule to the rule set */
-	acl_rule.data.userdata = free_pos;
-	rule_location = (struct rte_acl_rule *)
-		&acl->acl_rule_memory[free_pos * acl->acl_params.rule_size];
-	memcpy(rule_location, &acl_rule, acl->acl_params.rule_size);
-	acl->acl_rule_list[free_pos] = rule_location;
-
-	/* Build low level ACL table */
-	acl->name_id ^= 1;
-	acl->acl_params.name = acl->name[acl->name_id];
-	status = rte_table_acl_build(acl, &ctx);
-	if (status != 0) {
-		/* Roll back changes */
-		acl->acl_rule_list[free_pos] = NULL;
-		acl->name_id ^= 1;
-
-		return -EINVAL;
-	}
-
-	/* Commit changes */
-	rte_acl_free(acl->ctx);
-	acl->ctx = ctx;
-	*key_found = 0;
-	*entry_ptr = &acl->memory[free_pos * acl->entry_size];
-	memcpy(*entry_ptr, entry, acl->entry_size);
-
-	return 0;
-}
-
-static int
-rte_table_acl_entry_delete(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_acl *acl = table;
-	struct rte_table_acl_rule_delete_params *rule =
-		key;
-	struct rte_acl_rule *deleted_rule = NULL;
-	struct rte_acl_ctx *ctx;
-	uint32_t pos, pos_valid, i;
-	int status;
-
-	/* Check input parameters */
-	if (table == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (key == NULL) {
-		TABLE_LOG(ERR, "%s: key parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (key_found == NULL) {
-		TABLE_LOG(ERR, "%s: key_found parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-
-	/* Look for the rule in the table */
-	pos = 0;
-	pos_valid = 0;
-	for (i = 1; i < acl->n_rules; i++) {
-		if (acl->acl_rule_list[i] != NULL) {
-			/* Compare the key fields */
-			status = memcmp(&acl->acl_rule_list[i]->field[0],
-				&rule->field_value[0], acl->cfg.num_fields *
-				sizeof(struct rte_acl_field));
-
-			/* Rule found: remove from table */
-			if (status == 0) {
-				pos = i;
-				pos_valid = 1;
-
-				deleted_rule = acl->acl_rule_list[i];
-				acl->acl_rule_list[i] = NULL;
-			}
-		}
-	}
-
-	/* Return if rule not found */
-	if (pos_valid == 0) {
-		*key_found = 0;
-		return 0;
-	}
-
-	/* Build low level ACL table */
-	acl->name_id ^= 1;
-	acl->acl_params.name = acl->name[acl->name_id];
-	status = rte_table_acl_build(acl, &ctx);
-	if (status != 0) {
-		/* Roll back changes */
-		acl->acl_rule_list[pos] = deleted_rule;
-		acl->name_id ^= 1;
-
-		return -EINVAL;
-	}
-
-	/* Commit changes */
-	rte_acl_free(acl->ctx);
-
-	acl->ctx = ctx;
-	*key_found = 1;
-	if (entry != NULL)
-		memcpy(entry, &acl->memory[pos * acl->entry_size],
-			acl->entry_size);
-
-	return 0;
-}
-
-static int
-rte_table_acl_entry_add_bulk(
-	void *table,
-	void **keys,
-	void **entries,
-	uint32_t n_keys,
-	int *key_found,
-	void **entries_ptr)
-{
-	struct rte_table_acl *acl = table;
-	struct rte_acl_ctx *ctx;
-	uint32_t rule_pos[n_keys];
-	uint32_t i;
-	int err = 0, build = 0;
-	int status;
-
-	/* Check input parameters */
-	if (table == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (keys == NULL) {
-		TABLE_LOG(ERR, "%s: keys parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (entries == NULL) {
-		TABLE_LOG(ERR, "%s: entries parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (n_keys == 0) {
-		TABLE_LOG(ERR, "%s: 0 rules to add", __func__);
-		return -EINVAL;
-	}
-	if (key_found == NULL) {
-		TABLE_LOG(ERR, "%s: key_found parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if (entries_ptr == NULL) {
-		TABLE_LOG(ERR, "%s: entries_ptr parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-
-	/* Check input parameters in arrays */
-	for (i = 0; i < n_keys; i++) {
-		struct rte_table_acl_rule_add_params *rule;
-
-		if (keys[i] == NULL) {
-			TABLE_LOG(ERR, "%s: keys[%" PRIu32 "] parameter is NULL",
-					__func__, i);
-			return -EINVAL;
-		}
-
-		if (entries[i] == NULL) {
-			TABLE_LOG(ERR, "%s: entries[%" PRIu32 "] parameter is NULL",
-					__func__, i);
-			return -EINVAL;
-		}
-
-		rule = keys[i];
-		if (rule->priority > RTE_ACL_MAX_PRIORITY) {
-			TABLE_LOG(ERR, "%s: Priority is too high", __func__);
-			return -EINVAL;
-		}
-	}
-
-	memset(rule_pos, 0, n_keys * sizeof(uint32_t));
-	memset(key_found, 0, n_keys * sizeof(int));
-	for (i = 0; i < n_keys; i++) {
-		struct rte_table_acl_rule_add_params *rule =
-				keys[i];
-		struct rte_pipeline_acl_rule acl_rule;
-		struct rte_acl_rule *rule_location;
-		uint32_t free_pos, free_pos_valid, j;
-
-		/* Setup rule data structure */
-		memset(&acl_rule, 0, sizeof(acl_rule));
-		acl_rule.data.category_mask = 1;
-		acl_rule.data.priority = RTE_ACL_MAX_PRIORITY - rule->priority;
-		acl_rule.data.userdata = 0; /* To be set up later */
-		memcpy(&acl_rule.field[0],
-			&rule->field_value[0],
-			acl->cfg.num_fields * sizeof(struct rte_acl_field));
-
-		/* Look to see if the rule exists already in the table */
-		free_pos = 0;
-		free_pos_valid = 0;
-		for (j = 1; j < acl->n_rules; j++) {
-			if (acl->acl_rule_list[j] == NULL) {
-				if (free_pos_valid == 0) {
-					free_pos = j;
-					free_pos_valid = 1;
-				}
-
-				continue;
-			}
-
-			/* Compare the key fields */
-			status = memcmp(&acl->acl_rule_list[j]->field[0],
-				&rule->field_value[0],
-				acl->cfg.num_fields * sizeof(struct rte_acl_field));
-
-			/* Rule found: update data associated with the rule */
-			if (status == 0) {
-				key_found[i] = 1;
-				entries_ptr[i] = &acl->memory[j * acl->entry_size];
-				memcpy(entries_ptr[i], entries[i], acl->entry_size);
-
-				break;
-			}
-		}
-
-		/* Key already in the table */
-		if (key_found[i] != 0)
-			continue;
-
-		/* Maximum number of rules reached */
-		if (free_pos_valid == 0) {
-			err = 1;
-			break;
-		}
-
-		/* Add the new rule to the rule set */
-		acl_rule.data.userdata = free_pos;
-		rule_location = (struct rte_acl_rule *)
-			&acl->acl_rule_memory[free_pos * acl->acl_params.rule_size];
-		memcpy(rule_location, &acl_rule, acl->acl_params.rule_size);
-		acl->acl_rule_list[free_pos] = rule_location;
-		rule_pos[i] = free_pos;
-		build = 1;
-	}
-
-	if (err != 0) {
-		for (i = 0; i < n_keys; i++) {
-			if (rule_pos[i] == 0)
-				continue;
-
-			acl->acl_rule_list[rule_pos[i]] = NULL;
-		}
-
-		return -ENOSPC;
-	}
-
-	if (build == 0)
-		return 0;
-
-	/* Build low level ACL table */
-	acl->name_id ^= 1;
-	acl->acl_params.name = acl->name[acl->name_id];
-	status = rte_table_acl_build(acl, &ctx);
-	if (status != 0) {
-		/* Roll back changes */
-		for (i = 0; i < n_keys; i++) {
-			if (rule_pos[i] == 0)
-				continue;
-
-			acl->acl_rule_list[rule_pos[i]] = NULL;
-		}
-		acl->name_id ^= 1;
-
-		return -EINVAL;
-	}
-
-	/* Commit changes */
-	rte_acl_free(acl->ctx);
-	acl->ctx = ctx;
-
-	for (i = 0; i < n_keys; i++) {
-		if (rule_pos[i] == 0)
-			continue;
-
-		key_found[i] = 0;
-		entries_ptr[i] = &acl->memory[rule_pos[i] * acl->entry_size];
-		memcpy(entries_ptr[i], entries[i], acl->entry_size);
-	}
-
-	return 0;
-}
-
-static int
-rte_table_acl_entry_delete_bulk(
-	void *table,
-	void **keys,
-	uint32_t n_keys,
-	int *key_found,
-	void **entries)
-{
-	struct rte_table_acl *acl = table;
-	struct rte_acl_rule *deleted_rules[n_keys];
-	uint32_t rule_pos[n_keys];
-	struct rte_acl_ctx *ctx;
-	uint32_t i;
-	int status;
-	int build = 0;
-
-	/* Check input parameters */
-	if (table == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (keys == NULL) {
-		TABLE_LOG(ERR, "%s: key parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (n_keys == 0) {
-		TABLE_LOG(ERR, "%s: 0 rules to delete", __func__);
-		return -EINVAL;
-	}
-	if (key_found == NULL) {
-		TABLE_LOG(ERR, "%s: key_found parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < n_keys; i++) {
-		if (keys[i] == NULL) {
-			TABLE_LOG(ERR, "%s: keys[%" PRIu32 "] parameter is NULL",
-					__func__, i);
-			return -EINVAL;
-		}
-	}
-
-	memset(deleted_rules, 0, n_keys * sizeof(struct rte_acl_rule *));
-	memset(rule_pos, 0, n_keys * sizeof(uint32_t));
-	for (i = 0; i < n_keys; i++) {
-		struct rte_table_acl_rule_delete_params *rule =
-			keys[i];
-		uint32_t pos_valid, j;
-
-		/* Look for the rule in the table */
-		pos_valid = 0;
-		for (j = 1; j < acl->n_rules; j++) {
-			if (acl->acl_rule_list[j] == NULL)
-				continue;
-
-			/* Compare the key fields */
-			status = memcmp(&acl->acl_rule_list[j]->field[0],
-					&rule->field_value[0],
-					acl->cfg.num_fields * sizeof(struct rte_acl_field));
-
-			/* Rule found: remove from table */
-			if (status == 0) {
-				pos_valid = 1;
-
-				deleted_rules[i] = acl->acl_rule_list[j];
-				acl->acl_rule_list[j] = NULL;
-				rule_pos[i] = j;
-
-				build = 1;
-			}
-		}
-
-		if (pos_valid == 0) {
-			key_found[i] = 0;
-			continue;
-		}
-	}
-
-	/* Return if no changes to acl table */
-	if (build == 0) {
-		return 0;
-	}
-
-	/* Build low level ACL table */
-	acl->name_id ^= 1;
-	acl->acl_params.name = acl->name[acl->name_id];
-	status = rte_table_acl_build(acl, &ctx);
-	if (status != 0) {
-		/* Roll back changes */
-		for (i = 0; i < n_keys; i++) {
-			if (rule_pos[i] == 0)
-				continue;
-
-			acl->acl_rule_list[rule_pos[i]] = deleted_rules[i];
-		}
-
-		acl->name_id ^= 1;
-
-		return -EINVAL;
-	}
-
-	/* Commit changes */
-	rte_acl_free(acl->ctx);
-
-	acl->ctx = ctx;
-	for (i = 0; i < n_keys; i++) {
-		if (rule_pos[i] == 0)
-			continue;
-
-		key_found[i] = 1;
-		if (entries != NULL && entries[i] != NULL)
-			memcpy(entries[i], &acl->memory[rule_pos[i] * acl->entry_size],
-					acl->entry_size);
-	}
-
-	return 0;
-}
-
-static int
-rte_table_acl_lookup(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_acl *acl = (struct rte_table_acl *) table;
-	const uint8_t *pkts_data[RTE_PORT_IN_BURST_SIZE_MAX];
-	uint32_t results[RTE_PORT_IN_BURST_SIZE_MAX];
-	uint64_t pkts_out_mask;
-	uint32_t n_pkts, i, j;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_ACL_STATS_PKTS_IN_ADD(acl, n_pkts_in);
-
-	/* Input conversion */
-	for (i = 0, j = 0; i < (uint32_t)(RTE_PORT_IN_BURST_SIZE_MAX -
-		rte_clz64(pkts_mask)); i++) {
-		uint64_t pkt_mask = 1LLU << i;
-
-		if (pkt_mask & pkts_mask) {
-			pkts_data[j] = rte_pktmbuf_mtod(pkts[i], uint8_t *);
-			j++;
-		}
-	}
-	n_pkts = j;
-
-	/* Low-level ACL table lookup */
-	if (acl->ctx != NULL)
-		rte_acl_classify(acl->ctx, pkts_data, results, n_pkts, 1);
-	else
-		n_pkts = 0;
-
-	/* Output conversion */
-	pkts_out_mask = 0;
-	for (i = 0; i < n_pkts; i++) {
-		uint32_t action_table_pos = results[i];
-		uint32_t pkt_pos = rte_ctz64(pkts_mask);
-		uint64_t pkt_mask = 1LLU << pkt_pos;
-
-		pkts_mask &= ~pkt_mask;
-
-		if (action_table_pos != 0) {
-			pkts_out_mask |= pkt_mask;
-			entries[pkt_pos] = (void *)
-				&acl->memory[action_table_pos *
-				acl->entry_size];
-			rte_prefetch0(entries[pkt_pos]);
-		}
-	}
-
-	*lookup_hit_mask = pkts_out_mask;
-	RTE_TABLE_ACL_STATS_PKTS_LOOKUP_MISS(acl, n_pkts_in - rte_popcount64(pkts_out_mask));
-
-	return 0;
-}
-
-static int
-rte_table_acl_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_acl *acl = table;
-
-	if (stats != NULL)
-		memcpy(stats, &acl->stats, sizeof(acl->stats));
-
-	if (clear)
-		memset(&acl->stats, 0, sizeof(acl->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_acl_ops)
-struct rte_table_ops rte_table_acl_ops = {
-	.f_create = rte_table_acl_create,
-	.f_free = rte_table_acl_free,
-	.f_add = rte_table_acl_entry_add,
-	.f_delete = rte_table_acl_entry_delete,
-	.f_add_bulk = rte_table_acl_entry_add_bulk,
-	.f_delete_bulk = rte_table_acl_entry_delete_bulk,
-	.f_lookup = rte_table_acl_lookup,
-	.f_stats = rte_table_acl_stats_read,
-};
diff --git a/lib/table/rte_table_acl.h b/lib/table/rte_table_acl.h
deleted file mode 100644
index 61af7b88e4..0000000000
--- a/lib/table/rte_table_acl.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_ACL_H__
-#define __INCLUDE_RTE_TABLE_ACL_H__
-
-/**
- * @file
- * RTE Table ACL
- *
- * This table uses the Access Control List (ACL) algorithm to uniquely
- * associate data to lookup keys.
- *
- * Use-cases: Firewall rule database, etc.
- */
-
-#include <stdint.h>
-
-#include "rte_acl.h"
-
-#include "rte_table.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/** ACL table parameters */
-struct rte_table_acl_params {
-	/** Name */
-	const char *name;
-
-	/** Maximum number of ACL rules in the table */
-	uint32_t n_rules;
-
-	/** Number of fields in the ACL rule specification */
-	uint32_t n_rule_fields;
-
-	/** Format specification of the fields of the ACL rule */
-	struct rte_acl_field_def field_format[RTE_ACL_MAX_FIELDS];
-};
-
-/** ACL rule specification for entry add operation */
-struct rte_table_acl_rule_add_params {
-	/** ACL rule priority, with 0 as the highest priority */
-	int32_t  priority;
-
-	/** Values for the fields of the ACL rule to be added to the table */
-	struct rte_acl_field field_value[RTE_ACL_MAX_FIELDS];
-};
-
-/** ACL rule specification for entry delete operation */
-struct rte_table_acl_rule_delete_params {
-	/** Values for the fields of the ACL rule to be deleted from table */
-	struct rte_acl_field field_value[RTE_ACL_MAX_FIELDS];
-};
-
-/** ACL table operations */
-extern struct rte_table_ops rte_table_acl_ops;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_table_array.c b/lib/table/rte_table_array.c
deleted file mode 100644
index 55356e5999..0000000000
--- a/lib/table/rte_table_array.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_array.h"
-
-#include "table_log.h"
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_ARRAY_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_ARRAY_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_ARRAY_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_ARRAY_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-struct __rte_cache_aligned rte_table_array {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t entry_size;
-	uint32_t n_entries;
-	uint32_t offset;
-
-	/* Internal fields */
-	uint32_t entry_pos_mask;
-
-	/* Internal table */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t array[];
-};
-
-static void *
-rte_table_array_create(void *params, int socket_id, uint32_t entry_size)
-{
-	struct rte_table_array_params *p = params;
-	struct rte_table_array *t;
-	uint32_t total_cl_size, total_size;
-
-	/* Check input parameters */
-	if ((p == NULL) ||
-	    (p->n_entries == 0) ||
-		(!rte_is_power_of_2(p->n_entries)))
-		return NULL;
-
-	/* Memory allocation */
-	total_cl_size = (sizeof(struct rte_table_array) +
-			RTE_CACHE_LINE_SIZE) / RTE_CACHE_LINE_SIZE;
-	total_cl_size += (p->n_entries * entry_size +
-			RTE_CACHE_LINE_SIZE) / RTE_CACHE_LINE_SIZE;
-	total_size = total_cl_size * RTE_CACHE_LINE_SIZE;
-	t = rte_zmalloc_socket("TABLE", total_size, RTE_CACHE_LINE_SIZE, socket_id);
-	if (t == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %u bytes for array table",
-			__func__, total_size);
-		return NULL;
-	}
-
-	/* Memory initialization */
-	t->entry_size = entry_size;
-	t->n_entries = p->n_entries;
-	t->offset = p->offset;
-	t->entry_pos_mask = t->n_entries - 1;
-
-	return t;
-}
-
-static int
-rte_table_array_free(void *table)
-{
-	struct rte_table_array *t = table;
-
-	/* Check input parameters */
-	if (t == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	/* Free previously allocated resources */
-	rte_free(t);
-
-	return 0;
-}
-
-static int
-rte_table_array_entry_add(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_array *t = table;
-	struct rte_table_array_key *k = key;
-	uint8_t *table_entry;
-
-	/* Check input parameters */
-	if (table == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (key == NULL) {
-		TABLE_LOG(ERR, "%s: key parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (entry == NULL) {
-		TABLE_LOG(ERR, "%s: entry parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (key_found == NULL) {
-		TABLE_LOG(ERR, "%s: key_found parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if (entry_ptr == NULL) {
-		TABLE_LOG(ERR, "%s: entry_ptr parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-
-	table_entry = &t->array[k->pos * t->entry_size];
-	memcpy(table_entry, entry, t->entry_size);
-	*key_found = 1;
-	*entry_ptr = (void *) table_entry;
-
-	return 0;
-}
-
-static int
-rte_table_array_lookup(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_array *t = (struct rte_table_array *) table;
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_ARRAY_STATS_PKTS_IN_ADD(t, n_pkts_in);
-	*lookup_hit_mask = pkts_mask;
-
-	if ((pkts_mask & (pkts_mask + 1)) == 0) {
-		uint64_t n_pkts = rte_popcount64(pkts_mask);
-		uint32_t i;
-
-		for (i = 0; i < n_pkts; i++) {
-			struct rte_mbuf *pkt = pkts[i];
-			uint32_t entry_pos = RTE_MBUF_METADATA_UINT32(pkt,
-				t->offset) & t->entry_pos_mask;
-
-			entries[i] = (void *) &t->array[entry_pos *
-				t->entry_size];
-		}
-	} else {
-		for ( ; pkts_mask; ) {
-			uint32_t pkt_index = rte_ctz64(pkts_mask);
-			uint64_t pkt_mask = 1LLU << pkt_index;
-			struct rte_mbuf *pkt = pkts[pkt_index];
-			uint32_t entry_pos = RTE_MBUF_METADATA_UINT32(pkt,
-				t->offset) & t->entry_pos_mask;
-
-			entries[pkt_index] = (void *) &t->array[entry_pos *
-				t->entry_size];
-			pkts_mask &= ~pkt_mask;
-		}
-	}
-
-	return 0;
-}
-
-static int
-rte_table_array_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_array *array = table;
-
-	if (stats != NULL)
-		memcpy(stats, &array->stats, sizeof(array->stats));
-
-	if (clear)
-		memset(&array->stats, 0, sizeof(array->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_array_ops)
-struct rte_table_ops rte_table_array_ops = {
-	.f_create = rte_table_array_create,
-	.f_free = rte_table_array_free,
-	.f_add = rte_table_array_entry_add,
-	.f_delete = NULL,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_array_lookup,
-	.f_stats = rte_table_array_stats_read,
-};
diff --git a/lib/table/rte_table_array.h b/lib/table/rte_table_array.h
deleted file mode 100644
index b2a7b95d68..0000000000
--- a/lib/table/rte_table_array.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_ARRAY_H__
-#define __INCLUDE_RTE_TABLE_ARRAY_H__
-
-/**
- * @file
- * RTE Table Array
- *
- * Simple array indexing. Lookup key is the array entry index.
- */
-
-#include <stdint.h>
-
-#include "rte_table.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/** Array table parameters */
-struct rte_table_array_params {
-	/** Number of array entries. Has to be a power of two. */
-	uint32_t n_entries;
-
-	/** Byte offset within input packet meta-data where lookup key (i.e. the
-	    array entry index) is located. */
-	uint32_t offset;
-};
-
-/** Array table key format */
-struct rte_table_array_key {
-	/** Array entry index */
-	uint32_t pos;
-};
-
-/** Array table operations */
-extern struct rte_table_ops rte_table_array_ops;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_table_hash.h b/lib/table/rte_table_hash.h
deleted file mode 100644
index ff8fc9e9ce..0000000000
--- a/lib/table/rte_table_hash.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2017 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_HASH_H__
-#define __INCLUDE_RTE_TABLE_HASH_H__
-
-/**
- * @file
- * RTE Table Hash
- *
- * These tables use the exact match criterion to uniquely associate data to
- * lookup keys.
- *
- * Hash table types:
- * 1. Entry add strategy on bucket full:
- *     a. Least Recently Used (LRU): One of the existing keys in the bucket is
- *        deleted and the new key is added in its place. The number of keys in
- *        each bucket never grows bigger than 4. The logic to pick the key to
- *        be dropped from the bucket is LRU. The hash table lookup operation
- *        maintains the order in which the keys in the same bucket are hit, so
- *        every time a key is hit, it becomes the new Most Recently Used (MRU)
- *        key, i.e. the most unlikely candidate for drop. When a key is added
- *        to the bucket, it also becomes the new MRU key. When a key needs to
- *        be picked and dropped, the most likely candidate for drop, i.e. the
- *        current LRU key, is always picked. The LRU logic requires maintaining
- *        specific data structures per each bucket. Use-cases: flow cache, etc.
- *     b. Extendable bucket (ext): The bucket is extended with space for 4 more
- *        keys. This is done by allocating additional memory at table init time,
- *        which is used to create a pool of free keys (the size of this pool is
- *        configurable and always a multiple of 4). On key add operation, the
- *        allocation of a group of 4 keys only happens successfully within the
- *        limit of free keys, otherwise the key add operation fails. On key
- *        delete operation, a group of 4 keys is freed back to the pool of free
- *        keys when the key to be deleted is the only key that was used within
- *        its group of 4 keys at that time. On key lookup operation, if the
- *        current bucket is in extended state and a match is not found in the
- *        first group of 4 keys, the search continues beyond the first group of
- *        4 keys, potentially until all keys in this bucket are examined. The
- *        extendable bucket logic requires maintaining specific data structures
- *        per table and per each bucket. Use-cases: flow table, etc.
- * 2. Key size:
- *     a. Configurable key size
- *     b. Single key size (8-byte, 16-byte or 32-byte key size)
- */
-
-#include <stdint.h>
-
-#include "rte_table.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/** Hash function */
-typedef uint64_t (*rte_table_hash_op_hash)(
-	void *key,
-	void *key_mask,
-	uint32_t key_size,
-	uint64_t seed);
-
-/** Hash table parameters */
-struct rte_table_hash_params {
-	/** Name */
-	const char *name;
-
-	/** Key size (number of bytes) */
-	uint32_t key_size;
-
-	/** Byte offset within packet meta-data where the key is located */
-	uint32_t key_offset;
-
-	/** Key mask */
-	uint8_t *key_mask;
-
-	/** Number of keys */
-	uint32_t n_keys;
-
-	/** Number of buckets */
-	uint32_t n_buckets;
-
-	/** Hash function */
-	rte_table_hash_op_hash f_hash;
-
-	/** Seed value for the hash function */
-	uint64_t seed;
-};
-
-/** Extendable bucket hash table operations */
-extern struct rte_table_ops rte_table_hash_ext_ops;
-extern struct rte_table_ops rte_table_hash_key8_ext_ops;
-extern struct rte_table_ops rte_table_hash_key16_ext_ops;
-extern struct rte_table_ops rte_table_hash_key32_ext_ops;
-
-/** LRU hash table operations */
-extern struct rte_table_ops rte_table_hash_lru_ops;
-
-extern struct rte_table_ops rte_table_hash_key8_lru_ops;
-extern struct rte_table_ops rte_table_hash_key16_lru_ops;
-extern struct rte_table_ops rte_table_hash_key32_lru_ops;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_table_hash_cuckoo.c b/lib/table/rte_table_hash_cuckoo.c
deleted file mode 100644
index a2b920fa92..0000000000
--- a/lib/table/rte_table_hash_cuckoo.c
+++ /dev/null
@@ -1,327 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2017 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_hash_cuckoo.h"
-
-#include "table_log.h"
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_HASH_CUCKOO_STATS_PKTS_IN_ADD(table, val) \
-	(table->stats.n_pkts_in += val)
-#define RTE_TABLE_HASH_CUCKOO_STATS_PKTS_LOOKUP_MISS(table, val) \
-	(table->stats.n_pkts_lookup_miss += val)
-
-#else
-
-#define RTE_TABLE_HASH_CUCKOO_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_HASH_CUCKOO_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-
-struct rte_table_hash {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t key_size;
-	uint32_t entry_size;
-	uint32_t n_keys;
-	rte_hash_function f_hash;
-	uint32_t seed;
-	uint32_t key_offset;
-
-	/* cuckoo hash table object */
-	struct rte_hash *h_table;
-
-	/* Lookup table */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t memory[];
-};
-
-static int
-check_params_create_hash_cuckoo(struct rte_table_hash_cuckoo_params *params)
-{
-	if (params == NULL) {
-		TABLE_LOG(ERR, "NULL Input Parameters.");
-		return -EINVAL;
-	}
-
-	if (params->name == NULL) {
-		TABLE_LOG(ERR, "Table name is NULL.");
-		return -EINVAL;
-	}
-
-	if (params->key_size == 0) {
-		TABLE_LOG(ERR, "Invalid key_size.");
-		return -EINVAL;
-	}
-
-	if (params->n_keys == 0) {
-		TABLE_LOG(ERR, "Invalid n_keys.");
-		return -EINVAL;
-	}
-
-	if (params->f_hash == NULL) {
-		TABLE_LOG(ERR, "f_hash is NULL.");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void *
-rte_table_hash_cuckoo_create(void *params,
-			int socket_id,
-			uint32_t entry_size)
-{
-	struct rte_table_hash_cuckoo_params *p = params;
-	struct rte_hash *h_table;
-	struct rte_table_hash *t;
-	uint32_t total_size;
-
-	/* Check input parameters */
-	if (check_params_create_hash_cuckoo(params))
-		return NULL;
-
-	/* Memory allocation */
-	total_size = sizeof(struct rte_table_hash) +
-		RTE_CACHE_LINE_ROUNDUP(p->n_keys * entry_size);
-
-	t = rte_zmalloc_socket(p->name, total_size, RTE_CACHE_LINE_SIZE, socket_id);
-	if (t == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %u bytes for cuckoo hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	/* Create cuckoo hash table */
-	struct rte_hash_parameters hash_cuckoo_params = {
-		.entries = p->n_keys,
-		.key_len = p->key_size,
-		.hash_func = p->f_hash,
-		.hash_func_init_val = p->seed,
-		.socket_id = socket_id,
-		.name = p->name
-	};
-
-	h_table = rte_hash_find_existing(p->name);
-	if (h_table == NULL) {
-		h_table = rte_hash_create(&hash_cuckoo_params);
-		if (h_table == NULL) {
-			TABLE_LOG(ERR,
-				"%s: failed to create cuckoo hash table %s",
-				__func__, p->name);
-			rte_free(t);
-			return NULL;
-		}
-	}
-
-	/* initialize the cuckoo hash parameters */
-	t->key_size = p->key_size;
-	t->entry_size = entry_size;
-	t->n_keys = p->n_keys;
-	t->f_hash = p->f_hash;
-	t->seed = p->seed;
-	t->key_offset = p->key_offset;
-	t->h_table = h_table;
-
-	TABLE_LOG(INFO,
-		"%s: Cuckoo hash table %s memory footprint is %u bytes",
-		__func__, p->name, total_size);
-	return t;
-}
-
-static int
-rte_table_hash_cuckoo_free(void *table) {
-	struct rte_table_hash *t = table;
-
-	if (table == NULL)
-		return -EINVAL;
-
-	rte_hash_free(t->h_table);
-	rte_free(t);
-
-	return 0;
-}
-
-static int
-rte_table_hash_cuckoo_entry_add(void *table, void *key, void *entry,
-	int *key_found, void **entry_ptr)
-{
-	struct rte_table_hash *t = table;
-	int pos = 0;
-
-	/* Check input parameters */
-	if ((table == NULL) ||
-		(key == NULL) ||
-		(entry == NULL) ||
-		(key_found == NULL) ||
-		(entry_ptr == NULL))
-		return -EINVAL;
-
-	/*  Find Existing entries */
-	pos = rte_hash_lookup(t->h_table, key);
-	if (pos >= 0) {
-		uint8_t *existing_entry;
-
-		*key_found = 1;
-		existing_entry = &t->memory[pos * t->entry_size];
-		memcpy(existing_entry, entry, t->entry_size);
-		*entry_ptr = existing_entry;
-
-		return 0;
-	}
-
-	if (pos == -ENOENT) {
-		/* Entry not found. Adding new entry */
-		uint8_t *new_entry;
-
-		pos = rte_hash_add_key(t->h_table, key);
-		if (pos < 0)
-			return pos;
-
-		new_entry = &t->memory[pos * t->entry_size];
-		memcpy(new_entry, entry, t->entry_size);
-
-		*key_found = 0;
-		*entry_ptr = new_entry;
-		return 0;
-	}
-
-	return pos;
-}
-
-static int
-rte_table_hash_cuckoo_entry_delete(void *table, void *key,
-	int *key_found, void *entry)
-{
-	struct rte_table_hash *t = table;
-	int pos = 0;
-
-	/* Check input parameters */
-	if ((table == NULL) ||
-		(key == NULL) ||
-		(key_found == NULL))
-		return -EINVAL;
-
-	pos = rte_hash_del_key(t->h_table, key);
-	if (pos >= 0) {
-		*key_found = 1;
-		uint8_t *entry_ptr = &t->memory[pos * t->entry_size];
-
-		if (entry)
-			memcpy(entry, entry_ptr, t->entry_size);
-
-		memset(&t->memory[pos * t->entry_size], 0, t->entry_size);
-		return 0;
-	}
-
-	*key_found = 0;
-	return pos;
-}
-
-static int
-rte_table_hash_cuckoo_lookup(void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *t = table;
-	uint64_t pkts_mask_out = 0;
-	uint32_t i;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-
-	RTE_TABLE_HASH_CUCKOO_STATS_PKTS_IN_ADD(t, n_pkts_in);
-
-	if ((pkts_mask & (pkts_mask + 1)) == 0) {
-		const uint8_t *keys[RTE_PORT_IN_BURST_SIZE_MAX];
-		int32_t positions[RTE_PORT_IN_BURST_SIZE_MAX], status;
-
-		/* Keys for bulk lookup */
-		for (i = 0; i < n_pkts_in; i++)
-			keys[i] = RTE_MBUF_METADATA_UINT8_PTR(pkts[i],
-				t->key_offset);
-
-		/* Bulk Lookup */
-		status = rte_hash_lookup_bulk(t->h_table,
-				(const void **) keys,
-				n_pkts_in,
-				positions);
-		if (status == 0) {
-			for (i = 0; i < n_pkts_in; i++) {
-				if (likely(positions[i] >= 0)) {
-					uint64_t pkt_mask = 1LLU << i;
-
-					entries[i] = &t->memory[positions[i]
-						* t->entry_size];
-					pkts_mask_out |= pkt_mask;
-				}
-			}
-		}
-	} else
-		for (i = 0; i < (uint32_t)(RTE_PORT_IN_BURST_SIZE_MAX
-					- rte_clz64(pkts_mask)); i++) {
-			uint64_t pkt_mask = 1LLU << i;
-
-			if (pkt_mask & pkts_mask) {
-				struct rte_mbuf *pkt = pkts[i];
-				uint8_t *key = RTE_MBUF_METADATA_UINT8_PTR(pkt,
-						t->key_offset);
-				int pos;
-
-				pos = rte_hash_lookup(t->h_table, key);
-				if (likely(pos >= 0)) {
-					entries[i] = &t->memory[pos
-						* t->entry_size];
-					pkts_mask_out |= pkt_mask;
-				}
-			}
-		}
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_CUCKOO_STATS_PKTS_LOOKUP_MISS(t,
-			n_pkts_in - rte_popcount64(pkts_mask_out));
-
-	return 0;
-
-}
-
-static int
-rte_table_hash_cuckoo_stats_read(void *table, struct rte_table_stats *stats,
-	int clear)
-{
-	struct rte_table_hash *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_hash_cuckoo_ops)
-struct rte_table_ops rte_table_hash_cuckoo_ops = {
-	.f_create = rte_table_hash_cuckoo_create,
-	.f_free = rte_table_hash_cuckoo_free,
-	.f_add = rte_table_hash_cuckoo_entry_add,
-	.f_delete = rte_table_hash_cuckoo_entry_delete,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_cuckoo_lookup,
-	.f_stats = rte_table_hash_cuckoo_stats_read,
-};
diff --git a/lib/table/rte_table_hash_cuckoo.h b/lib/table/rte_table_hash_cuckoo.h
deleted file mode 100644
index 55aa12216a..0000000000
--- a/lib/table/rte_table_hash_cuckoo.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2018 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_HASH_CUCKOO_H__
-#define __INCLUDE_RTE_TABLE_HASH_CUCKOO_H__
-
-/**
- * @file
- * RTE Table Hash Cuckoo
- */
-
-#include <stdint.h>
-
-#include <rte_hash.h>
-
-#include "rte_table.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/** Hash table parameters */
-struct rte_table_hash_cuckoo_params {
-	/** Name */
-	const char *name;
-
-	/** Key size (number of bytes) */
-	uint32_t key_size;
-
-	/** Byte offset within packet meta-data where the key is located */
-	uint32_t key_offset;
-
-	/** Key mask */
-	uint8_t *key_mask;
-
-	/** Number of keys */
-	uint32_t n_keys;
-
-	/** Number of buckets */
-	uint32_t n_buckets;
-
-	/** Hash function */
-	rte_hash_function f_hash;
-
-	/** Seed value for the hash function */
-	uint32_t seed;
-};
-
-/** Cuckoo hash table operations */
-extern struct rte_table_ops rte_table_hash_cuckoo_ops;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_table_hash_ext.c b/lib/table/rte_table_hash_ext.c
deleted file mode 100644
index 86e8eeb4c8..0000000000
--- a/lib/table/rte_table_hash_ext.c
+++ /dev/null
@@ -1,1011 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2017 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_hash.h"
-
-#include "table_log.h"
-
-#define KEYS_PER_BUCKET	4
-
-struct bucket {
-	union {
-		uintptr_t next;
-		uint64_t lru_list;
-	};
-	uint16_t sig[KEYS_PER_BUCKET];
-	uint32_t key_pos[KEYS_PER_BUCKET];
-};
-
-#define BUCKET_NEXT(bucket)						\
-	((void *) ((bucket)->next & (~1LU)))
-
-#define BUCKET_NEXT_VALID(bucket)					\
-	((bucket)->next & 1LU)
-
-#define BUCKET_NEXT_SET(bucket, bucket_next)				\
-do									\
-	(bucket)->next = (((uintptr_t) ((void *) (bucket_next))) | 1LU);\
-while (0)
-
-#define BUCKET_NEXT_SET_NULL(bucket)					\
-do									\
-	(bucket)->next = 0;						\
-while (0)
-
-#define BUCKET_NEXT_COPY(bucket, bucket2)				\
-do									\
-	(bucket)->next = (bucket2)->next;				\
-while (0)
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_HASH_EXT_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_HASH_EXT_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_HASH_EXT_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_HASH_EXT_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-struct grinder {
-	struct bucket *bkt;
-	uint64_t sig;
-	uint64_t match;
-	uint32_t key_index;
-};
-
-struct rte_table_hash {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t key_size;
-	uint32_t entry_size;
-	uint32_t n_keys;
-	uint32_t n_buckets;
-	uint32_t n_buckets_ext;
-	rte_table_hash_op_hash f_hash;
-	uint64_t seed;
-	uint32_t key_offset;
-
-	/* Internal */
-	uint64_t bucket_mask;
-	uint32_t key_size_shl;
-	uint32_t data_size_shl;
-	uint32_t key_stack_tos;
-	uint32_t bkt_ext_stack_tos;
-
-	/* Grinder */
-	struct grinder grinders[RTE_PORT_IN_BURST_SIZE_MAX];
-
-	/* Tables */
-	uint64_t *key_mask;
-	struct bucket *buckets;
-	struct bucket *buckets_ext;
-	uint8_t *key_mem;
-	uint8_t *data_mem;
-	uint32_t *key_stack;
-	uint32_t *bkt_ext_stack;
-
-	/* Table memory */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t memory[];
-};
-
-static int
-keycmp(void *a, void *b, void *b_mask, uint32_t n_bytes)
-{
-	uint64_t *a64 = a, *b64 = b, *b_mask64 = b_mask;
-	uint32_t i;
-
-	for (i = 0; i < n_bytes / sizeof(uint64_t); i++)
-		if (a64[i] != (b64[i] & b_mask64[i]))
-			return 1;
-
-	return 0;
-}
-
-static void
-keycpy(void *dst, void *src, void *src_mask, uint32_t n_bytes)
-{
-	uint64_t *dst64 = dst, *src64 = src, *src_mask64 = src_mask;
-	uint32_t i;
-
-	for (i = 0; i < n_bytes / sizeof(uint64_t); i++)
-		dst64[i] = src64[i] & src_mask64[i];
-}
-
-static int
-check_params_create(struct rte_table_hash_params *params)
-{
-	/* name */
-	if (params->name == NULL) {
-		TABLE_LOG(ERR, "%s: name invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* key_size */
-	if ((params->key_size < sizeof(uint64_t)) ||
-		(!rte_is_power_of_2(params->key_size))) {
-		TABLE_LOG(ERR, "%s: key_size invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* n_keys */
-	if (params->n_keys == 0) {
-		TABLE_LOG(ERR, "%s: n_keys invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* n_buckets */
-	if ((params->n_buckets == 0) ||
-		(!rte_is_power_of_2(params->n_buckets))) {
-		TABLE_LOG(ERR, "%s: n_buckets invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* f_hash */
-	if (params->f_hash == NULL) {
-		TABLE_LOG(ERR, "%s: f_hash invalid value", __func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void *
-rte_table_hash_ext_create(void *params, int socket_id, uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *t;
-	uint64_t table_meta_sz, key_mask_sz, bucket_sz, bucket_ext_sz, key_sz;
-	uint64_t key_stack_sz, bkt_ext_stack_sz, data_sz, total_size;
-	uint64_t key_mask_offset, bucket_offset, bucket_ext_offset, key_offset;
-	uint64_t key_stack_offset, bkt_ext_stack_offset, data_offset;
-	uint32_t n_buckets_ext, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		(!rte_is_power_of_2(entry_size)) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		(sizeof(struct bucket) != (RTE_CACHE_LINE_SIZE / 2)))
-		return NULL;
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of bucket extensions (n_buckets_ext) so that
-	 * it is guaranteed that n_keys keys can be stored in the table at any time.
-	 *
-	 * The worst case scenario takes place when all the n_keys keys fall into
-	 * the same bucket. Actually, due to the KEYS_PER_BUCKET scheme, the worst
-	 * case takes place when (n_keys - KEYS_PER_BUCKET + 1) keys fall into the
-	 * same bucket, while the remaining (KEYS_PER_BUCKET - 1) keys each fall
-	 * into a different bucket. This case defeats the purpose of the hash table.
-	 * It indicates unsuitable f_hash or n_keys to n_buckets ratio.
-	 *
-	 * n_buckets_ext = n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1
-	 */
-	n_buckets_ext = p->n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1;
-
-	/* Memory allocation */
-	table_meta_sz = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_table_hash));
-	key_mask_sz = RTE_CACHE_LINE_ROUNDUP(p->key_size);
-	bucket_sz = RTE_CACHE_LINE_ROUNDUP(p->n_buckets * sizeof(struct bucket));
-	bucket_ext_sz =
-		RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(struct bucket));
-	key_sz = RTE_CACHE_LINE_ROUNDUP(p->n_keys * p->key_size);
-	key_stack_sz = RTE_CACHE_LINE_ROUNDUP(p->n_keys * sizeof(uint32_t));
-	bkt_ext_stack_sz =
-		RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(uint32_t));
-	data_sz = RTE_CACHE_LINE_ROUNDUP(p->n_keys * entry_size);
-	total_size = table_meta_sz + key_mask_sz + bucket_sz + bucket_ext_sz +
-		key_sz + key_stack_sz + bkt_ext_stack_sz + data_sz;
-
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes"
-			" for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	t = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (t == NULL) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes"
-			" for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-	TABLE_LOG(INFO, "%s (%u-byte key): Hash table %s memory "
-		"footprint is %" PRIu64 " bytes",
-		__func__, p->key_size, p->name, total_size);
-
-	/* Memory initialization */
-	t->key_size = p->key_size;
-	t->entry_size = entry_size;
-	t->n_keys = p->n_keys;
-	t->n_buckets = p->n_buckets;
-	t->n_buckets_ext = n_buckets_ext;
-	t->f_hash = p->f_hash;
-	t->seed = p->seed;
-	t->key_offset = p->key_offset;
-
-	/* Internal */
-	t->bucket_mask = t->n_buckets - 1;
-	t->key_size_shl = rte_ctz32(p->key_size);
-	t->data_size_shl = rte_ctz32(entry_size);
-
-	/* Tables */
-	key_mask_offset = 0;
-	bucket_offset = key_mask_offset + key_mask_sz;
-	bucket_ext_offset = bucket_offset + bucket_sz;
-	key_offset = bucket_ext_offset + bucket_ext_sz;
-	key_stack_offset = key_offset + key_sz;
-	bkt_ext_stack_offset = key_stack_offset + key_stack_sz;
-	data_offset = bkt_ext_stack_offset + bkt_ext_stack_sz;
-
-	t->key_mask = (uint64_t *) &t->memory[key_mask_offset];
-	t->buckets = (struct bucket *) &t->memory[bucket_offset];
-	t->buckets_ext = (struct bucket *) &t->memory[bucket_ext_offset];
-	t->key_mem = &t->memory[key_offset];
-	t->key_stack = (uint32_t *) &t->memory[key_stack_offset];
-	t->bkt_ext_stack = (uint32_t *) &t->memory[bkt_ext_stack_offset];
-	t->data_mem = &t->memory[data_offset];
-
-	/* Key mask */
-	if (p->key_mask == NULL)
-		memset(t->key_mask, 0xFF, p->key_size);
-	else
-		memcpy(t->key_mask, p->key_mask, p->key_size);
-
-	/* Key stack */
-	for (i = 0; i < t->n_keys; i++)
-		t->key_stack[i] = t->n_keys - 1 - i;
-	t->key_stack_tos = t->n_keys;
-
-	/* Bucket ext stack */
-	for (i = 0; i < t->n_buckets_ext; i++)
-		t->bkt_ext_stack[i] = t->n_buckets_ext - 1 - i;
-	t->bkt_ext_stack_tos = t->n_buckets_ext;
-
-	return t;
-}
-
-static int
-rte_table_hash_ext_free(void *table)
-{
-	struct rte_table_hash *t = table;
-
-	/* Check input parameters */
-	if (t == NULL)
-		return -EINVAL;
-
-	rte_free(t);
-	return 0;
-}
-
-static int
-rte_table_hash_ext_entry_add(void *table, void *key, void *entry,
-	int *key_found, void **entry_ptr)
-{
-	struct rte_table_hash *t = table;
-	struct bucket *bkt0, *bkt, *bkt_prev;
-	uint64_t sig;
-	uint32_t bkt_index, i;
-
-	sig = t->f_hash(key, t->key_mask, t->key_size, t->seed);
-	bkt_index = sig & t->bucket_mask;
-	bkt0 = &t->buckets[bkt_index];
-	sig = (sig >> 16) | 1LLU;
-
-	/* Key is present in the bucket */
-	for (bkt = bkt0; bkt != NULL; bkt = BUCKET_NEXT(bkt))
-		for (i = 0; i < KEYS_PER_BUCKET; i++) {
-			uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-			uint32_t bkt_key_index = bkt->key_pos[i];
-			uint8_t *bkt_key =
-				&t->key_mem[bkt_key_index << t->key_size_shl];
-
-			if ((sig == bkt_sig) && (keycmp(bkt_key, key, t->key_mask,
-				t->key_size) == 0)) {
-				uint8_t *data = &t->data_mem[bkt_key_index <<
-					t->data_size_shl];
-
-				memcpy(data, entry, t->entry_size);
-				*key_found = 1;
-				*entry_ptr = (void *) data;
-				return 0;
-			}
-		}
-
-	/* Key is not present in the bucket */
-	for (bkt_prev = NULL, bkt = bkt0; bkt != NULL; bkt_prev = bkt,
-		bkt = BUCKET_NEXT(bkt))
-		for (i = 0; i < KEYS_PER_BUCKET; i++) {
-			uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-
-			if (bkt_sig == 0) {
-				uint32_t bkt_key_index;
-				uint8_t *bkt_key, *data;
-
-				/* Allocate new key */
-				if (t->key_stack_tos == 0) /* No free keys */
-					return -ENOSPC;
-
-				bkt_key_index = t->key_stack[
-					--t->key_stack_tos];
-
-				/* Install new key */
-				bkt_key = &t->key_mem[bkt_key_index <<
-					t->key_size_shl];
-				data = &t->data_mem[bkt_key_index <<
-					t->data_size_shl];
-
-				bkt->sig[i] = (uint16_t) sig;
-				bkt->key_pos[i] = bkt_key_index;
-				keycpy(bkt_key, key, t->key_mask, t->key_size);
-				memcpy(data, entry, t->entry_size);
-
-				*key_found = 0;
-				*entry_ptr = (void *) data;
-				return 0;
-			}
-		}
-
-	/* Bucket full: extend bucket */
-	if ((t->bkt_ext_stack_tos > 0) && (t->key_stack_tos > 0)) {
-		uint32_t bkt_key_index;
-		uint8_t *bkt_key, *data;
-
-		/* Allocate new bucket ext */
-		bkt_index = t->bkt_ext_stack[--t->bkt_ext_stack_tos];
-		bkt = &t->buckets_ext[bkt_index];
-
-		/* Chain the new bucket ext */
-		BUCKET_NEXT_SET(bkt_prev, bkt);
-		BUCKET_NEXT_SET_NULL(bkt);
-
-		/* Allocate new key */
-		bkt_key_index = t->key_stack[--t->key_stack_tos];
-		bkt_key = &t->key_mem[bkt_key_index << t->key_size_shl];
-
-		data = &t->data_mem[bkt_key_index << t->data_size_shl];
-
-		/* Install new key into bucket */
-		bkt->sig[0] = (uint16_t) sig;
-		bkt->key_pos[0] = bkt_key_index;
-		keycpy(bkt_key, key, t->key_mask, t->key_size);
-		memcpy(data, entry, t->entry_size);
-
-		*key_found = 0;
-		*entry_ptr = (void *) data;
-		return 0;
-	}
-
-	return -ENOSPC;
-}
-
-static int
-rte_table_hash_ext_entry_delete(void *table, void *key, int *key_found,
-void *entry)
-{
-	struct rte_table_hash *t = table;
-	struct bucket *bkt0, *bkt, *bkt_prev;
-	uint64_t sig;
-	uint32_t bkt_index, i;
-
-	sig = t->f_hash(key, t->key_mask, t->key_size, t->seed);
-	bkt_index = sig & t->bucket_mask;
-	bkt0 = &t->buckets[bkt_index];
-	sig = (sig >> 16) | 1LLU;
-
-	/* Key is present in the bucket */
-	for (bkt_prev = NULL, bkt = bkt0; bkt != NULL; bkt_prev = bkt,
-		bkt = BUCKET_NEXT(bkt))
-		for (i = 0; i < KEYS_PER_BUCKET; i++) {
-			uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-			uint32_t bkt_key_index = bkt->key_pos[i];
-			uint8_t *bkt_key = &t->key_mem[bkt_key_index <<
-				t->key_size_shl];
-
-			if ((sig == bkt_sig) && (keycmp(bkt_key, key, t->key_mask,
-				t->key_size) == 0)) {
-				uint8_t *data = &t->data_mem[bkt_key_index <<
-					t->data_size_shl];
-
-				/* Uninstall key from bucket */
-				bkt->sig[i] = 0;
-				*key_found = 1;
-				if (entry)
-					memcpy(entry, data, t->entry_size);
-
-				/* Free key */
-				t->key_stack[t->key_stack_tos++] =
-					bkt_key_index;
-
-				/*Check if bucket is unused */
-				if ((bkt_prev != NULL) &&
-				    (bkt->sig[0] == 0) && (bkt->sig[1] == 0) &&
-				    (bkt->sig[2] == 0) && (bkt->sig[3] == 0)) {
-					/* Unchain bucket */
-					BUCKET_NEXT_COPY(bkt_prev, bkt);
-
-					/* Clear bucket */
-					memset(bkt, 0, sizeof(struct bucket));
-
-					/* Free bucket back to buckets ext */
-					bkt_index = bkt - t->buckets_ext;
-					t->bkt_ext_stack[t->bkt_ext_stack_tos++]
-						= bkt_index;
-				}
-
-				return 0;
-			}
-		}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-static int rte_table_hash_ext_lookup_unoptimized(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *t = (struct rte_table_hash *) table;
-	uint64_t pkts_mask_out = 0;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-
-	for ( ; pkts_mask; ) {
-		struct bucket *bkt0, *bkt;
-		struct rte_mbuf *pkt;
-		uint8_t *key;
-		uint64_t pkt_mask, sig;
-		uint32_t pkt_index, bkt_index, i;
-
-		pkt_index = rte_ctz64(pkts_mask);
-		pkt_mask = 1LLU << pkt_index;
-		pkts_mask &= ~pkt_mask;
-
-		pkt = pkts[pkt_index];
-		key = RTE_MBUF_METADATA_UINT8_PTR(pkt, t->key_offset);
-		sig = (uint64_t) t->f_hash(key, t->key_mask, t->key_size, t->seed);
-
-		bkt_index = sig & t->bucket_mask;
-		bkt0 = &t->buckets[bkt_index];
-		sig = (sig >> 16) | 1LLU;
-
-		/* Key is present in the bucket */
-		for (bkt = bkt0; bkt != NULL; bkt = BUCKET_NEXT(bkt))
-			for (i = 0; i < KEYS_PER_BUCKET; i++) {
-				uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-				uint32_t bkt_key_index = bkt->key_pos[i];
-				uint8_t *bkt_key = &t->key_mem[bkt_key_index <<
-					t->key_size_shl];
-
-				if ((sig == bkt_sig) && (keycmp(bkt_key, key,
-					t->key_mask, t->key_size) == 0)) {
-					uint8_t *data = &t->data_mem[
-					bkt_key_index << t->data_size_shl];
-
-					pkts_mask_out |= pkt_mask;
-					entries[pkt_index] = (void *) data;
-					break;
-				}
-			}
-	}
-
-	*lookup_hit_mask = pkts_mask_out;
-	return 0;
-}
-
-/*
- * mask = match bitmask
- * match = at least one match
- * match_many = more than one match
- * match_pos = position of first match
- *
- *----------------------------------------
- * mask		 match	 match_many	  match_pos
- *----------------------------------------
- * 0000		 0		 0			  00
- * 0001		 1		 0			  00
- * 0010		 1		 0			  01
- * 0011		 1		 1			  00
- *----------------------------------------
- * 0100		 1		 0			  10
- * 0101		 1		 1			  00
- * 0110		 1		 1			  01
- * 0111		 1		 1			  00
- *----------------------------------------
- * 1000		 1		 0			  11
- * 1001		 1		 1			  00
- * 1010		 1		 1			  01
- * 1011		 1		 1			  00
- *----------------------------------------
- * 1100		 1		 1			  10
- * 1101		 1		 1			  00
- * 1110		 1		 1			  01
- * 1111		 1		 1			  00
- *----------------------------------------
- *
- * match = 1111_1111_1111_1110
- * match_many = 1111_1110_1110_1000
- * match_pos = 0001_0010_0001_0011__0001_0010_0001_0000
- *
- * match = 0xFFFELLU
- * match_many = 0xFEE8LLU
- * match_pos = 0x12131210LLU
- */
-
-#define LUT_MATCH						0xFFFELLU
-#define LUT_MATCH_MANY						0xFEE8LLU
-#define LUT_MATCH_POS						0x12131210LLU
-
-#define lookup_cmp_sig(mbuf_sig, bucket, match, match_many, match_pos)	\
-{									\
-	uint64_t bucket_sig[4], mask[4], mask_all;			\
-									\
-	bucket_sig[0] = bucket->sig[0];					\
-	bucket_sig[1] = bucket->sig[1];					\
-	bucket_sig[2] = bucket->sig[2];					\
-	bucket_sig[3] = bucket->sig[3];					\
-									\
-	bucket_sig[0] ^= mbuf_sig;					\
-	bucket_sig[1] ^= mbuf_sig;					\
-	bucket_sig[2] ^= mbuf_sig;					\
-	bucket_sig[3] ^= mbuf_sig;					\
-									\
-	mask[0] = 0;							\
-	mask[1] = 0;							\
-	mask[2] = 0;							\
-	mask[3] = 0;							\
-									\
-	if (bucket_sig[0] == 0)						\
-		mask[0] = 1;						\
-	if (bucket_sig[1] == 0)						\
-		mask[1] = 2;						\
-	if (bucket_sig[2] == 0)						\
-		mask[2] = 4;						\
-	if (bucket_sig[3] == 0)						\
-		mask[3] = 8;						\
-									\
-	mask_all = (mask[0] | mask[1]) | (mask[2] | mask[3]);		\
-									\
-	match = (LUT_MATCH >> mask_all) & 1;				\
-	match_many = (LUT_MATCH_MANY >> mask_all) & 1;			\
-	match_pos = (LUT_MATCH_POS >> (mask_all << 1)) & 3;		\
-}
-
-#define lookup_cmp_key(mbuf, key, match_key, f)				\
-{									\
-	uint64_t *pkt_key = RTE_MBUF_METADATA_UINT64_PTR(mbuf, f->key_offset);\
-	uint64_t *bkt_key = (uint64_t *) key;				\
-	uint64_t *key_mask = f->key_mask;					\
-									\
-	switch (f->key_size) {						\
-	case 8:								\
-	{								\
-		uint64_t xor = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];	\
-		match_key = 0;						\
-		if (xor == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	case 16:							\
-	{								\
-		uint64_t xor[2], or;					\
-									\
-		xor[0] = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];		\
-		xor[1] = (pkt_key[1] & key_mask[1]) ^ bkt_key[1];		\
-		or = xor[0] | xor[1];					\
-		match_key = 0;						\
-		if (or == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	case 32:							\
-	{								\
-		uint64_t xor[4], or;					\
-									\
-		xor[0] = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];		\
-		xor[1] = (pkt_key[1] & key_mask[1]) ^ bkt_key[1];		\
-		xor[2] = (pkt_key[2] & key_mask[2]) ^ bkt_key[2];		\
-		xor[3] = (pkt_key[3] & key_mask[3]) ^ bkt_key[3];		\
-		or = xor[0] | xor[1] | xor[2] | xor[3];			\
-		match_key = 0;						\
-		if (or == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	case 64:							\
-	{								\
-		uint64_t xor[8], or;					\
-									\
-		xor[0] = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];		\
-		xor[1] = (pkt_key[1] & key_mask[1]) ^ bkt_key[1];		\
-		xor[2] = (pkt_key[2] & key_mask[2]) ^ bkt_key[2];		\
-		xor[3] = (pkt_key[3] & key_mask[3]) ^ bkt_key[3];		\
-		xor[4] = (pkt_key[4] & key_mask[4]) ^ bkt_key[4];		\
-		xor[5] = (pkt_key[5] & key_mask[5]) ^ bkt_key[5];		\
-		xor[6] = (pkt_key[6] & key_mask[6]) ^ bkt_key[6];		\
-		xor[7] = (pkt_key[7] & key_mask[7]) ^ bkt_key[7];		\
-		or = xor[0] | xor[1] | xor[2] | xor[3] |		\
-			xor[4] | xor[5] | xor[6] | xor[7];		\
-		match_key = 0;						\
-		if (or == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	default:							\
-		match_key = 0;						\
-		if (keycmp(bkt_key, pkt_key, key_mask, f->key_size) == 0)	\
-			match_key = 1;					\
-	}								\
-}
-
-#define lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index)	\
-{									\
-	uint64_t pkt00_mask, pkt01_mask;				\
-	struct rte_mbuf *mbuf00, *mbuf01;				\
-	uint32_t key_offset = t->key_offset;			\
-									\
-	pkt00_index = rte_ctz64(pkts_mask);			\
-	pkt00_mask = 1LLU << pkt00_index;				\
-	pkts_mask &= ~pkt00_mask;					\
-	mbuf00 = pkts[pkt00_index];					\
-									\
-	pkt01_index = rte_ctz64(pkts_mask);			\
-	pkt01_mask = 1LLU << pkt01_index;				\
-	pkts_mask &= ~pkt01_mask;					\
-	mbuf01 = pkts[pkt01_index];					\
-									\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage0_with_odd_support(t, g, pkts, pkts_mask, pkt00_index, \
-	pkt01_index)							\
-{									\
-	uint64_t pkt00_mask, pkt01_mask;				\
-	struct rte_mbuf *mbuf00, *mbuf01;				\
-	uint32_t key_offset = t->key_offset;			\
-									\
-	pkt00_index = rte_ctz64(pkts_mask);			\
-	pkt00_mask = 1LLU << pkt00_index;				\
-	pkts_mask &= ~pkt00_mask;					\
-	mbuf00 = pkts[pkt00_index];					\
-									\
-	pkt01_index = rte_ctz64(pkts_mask);			\
-	if (pkts_mask == 0)						\
-		pkt01_index = pkt00_index;				\
-	pkt01_mask = 1LLU << pkt01_index;				\
-	pkts_mask &= ~pkt01_mask;					\
-	mbuf01 = pkts[pkt01_index];					\
-									\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index)	\
-{									\
-	struct grinder *g10, *g11;					\
-	uint64_t sig10, sig11, bkt10_index, bkt11_index;		\
-	struct rte_mbuf *mbuf10, *mbuf11;				\
-	struct bucket *bkt10, *bkt11, *buckets = t->buckets;		\
-	uint8_t *key10, *key11;						\
-	uint64_t bucket_mask = t->bucket_mask;				\
-	rte_table_hash_op_hash f_hash = t->f_hash;			\
-	uint64_t seed = t->seed;					\
-	uint32_t key_size = t->key_size;				\
-	uint32_t key_offset = t->key_offset;				\
-									\
-	mbuf10 = pkts[pkt10_index];					\
-	key10 = RTE_MBUF_METADATA_UINT8_PTR(mbuf10, key_offset);	\
-	sig10 = (uint64_t) f_hash(key10, t->key_mask, key_size, seed);	\
-	bkt10_index = sig10 & bucket_mask;				\
-	bkt10 = &buckets[bkt10_index];					\
-									\
-	mbuf11 = pkts[pkt11_index];					\
-	key11 = RTE_MBUF_METADATA_UINT8_PTR(mbuf11, key_offset);	\
-	sig11 = (uint64_t) f_hash(key11, t->key_mask, key_size, seed);	\
-	bkt11_index = sig11 & bucket_mask;				\
-	bkt11 = &buckets[bkt11_index];					\
-									\
-	rte_prefetch0(bkt10);						\
-	rte_prefetch0(bkt11);						\
-									\
-	g10 = &g[pkt10_index];						\
-	g10->sig = sig10;						\
-	g10->bkt = bkt10;						\
-									\
-	g11 = &g[pkt11_index];						\
-	g11->sig = sig11;						\
-	g11->bkt = bkt11;						\
-}
-
-#define lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many)\
-{									\
-	struct grinder *g20, *g21;					\
-	uint64_t sig20, sig21;						\
-	struct bucket *bkt20, *bkt21;					\
-	uint8_t *key20, *key21, *key_mem = t->key_mem;			\
-	uint64_t match20, match21, match_many20, match_many21;		\
-	uint64_t match_pos20, match_pos21;				\
-	uint32_t key20_index, key21_index, key_size_shl = t->key_size_shl;\
-									\
-	g20 = &g[pkt20_index];						\
-	sig20 = g20->sig;						\
-	bkt20 = g20->bkt;						\
-	sig20 = (sig20 >> 16) | 1LLU;					\
-	lookup_cmp_sig(sig20, bkt20, match20, match_many20, match_pos20);\
-	match20 <<= pkt20_index;					\
-	match_many20 |= BUCKET_NEXT_VALID(bkt20);			\
-	match_many20 <<= pkt20_index;					\
-	key20_index = bkt20->key_pos[match_pos20];			\
-	key20 = &key_mem[key20_index << key_size_shl];			\
-									\
-	g21 = &g[pkt21_index];						\
-	sig21 = g21->sig;						\
-	bkt21 = g21->bkt;						\
-	sig21 = (sig21 >> 16) | 1LLU;					\
-	lookup_cmp_sig(sig21, bkt21, match21, match_many21, match_pos21);\
-	match21 <<= pkt21_index;					\
-	match_many21 |= BUCKET_NEXT_VALID(bkt21);			\
-	match_many21 <<= pkt21_index;					\
-	key21_index = bkt21->key_pos[match_pos21];			\
-	key21 = &key_mem[key21_index << key_size_shl];			\
-									\
-	rte_prefetch0(key20);						\
-	rte_prefetch0(key21);						\
-									\
-	pkts_mask_match_many |= match_many20 | match_many21;		\
-									\
-	g20->match = match20;						\
-	g20->key_index = key20_index;					\
-									\
-	g21->match = match21;						\
-	g21->key_index = key21_index;					\
-}
-
-#define lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out, \
-	entries)							\
-{									\
-	struct grinder *g30, *g31;					\
-	struct rte_mbuf *mbuf30, *mbuf31;				\
-	uint8_t *key30, *key31, *key_mem = t->key_mem;			\
-	uint8_t *data30, *data31, *data_mem = t->data_mem;		\
-	uint64_t match30, match31, match_key30, match_key31, match_keys;\
-	uint32_t key30_index, key31_index;				\
-	uint32_t key_size_shl = t->key_size_shl;			\
-	uint32_t data_size_shl = t->data_size_shl;			\
-									\
-	mbuf30 = pkts[pkt30_index];					\
-	g30 = &g[pkt30_index];						\
-	match30 = g30->match;						\
-	key30_index = g30->key_index;					\
-	key30 = &key_mem[key30_index << key_size_shl];			\
-	lookup_cmp_key(mbuf30, key30, match_key30, t);			\
-	match_key30 <<= pkt30_index;					\
-	match_key30 &= match30;						\
-	data30 = &data_mem[key30_index << data_size_shl];		\
-	entries[pkt30_index] = data30;					\
-									\
-	mbuf31 = pkts[pkt31_index];					\
-	g31 = &g[pkt31_index];						\
-	match31 = g31->match;						\
-	key31_index = g31->key_index;					\
-	key31 = &key_mem[key31_index << key_size_shl];			\
-	lookup_cmp_key(mbuf31, key31, match_key31, t);			\
-	match_key31 <<= pkt31_index;					\
-	match_key31 &= match31;						\
-	data31 = &data_mem[key31_index << data_size_shl];		\
-	entries[pkt31_index] = data31;					\
-									\
-	rte_prefetch0(data30);						\
-	rte_prefetch0(data31);						\
-									\
-	match_keys = match_key30 | match_key31;				\
-	pkts_mask_out |= match_keys;					\
-}
-
-/*
- * The lookup function implements a 4-stage pipeline, with each stage processing
- * two different packets. The purpose of pipelined implementation is to hide the
- * latency of prefetching the data structures and loosen the data dependency
- * between instructions.
- *
- *  p00  _______   p10  _______   p20  _______   p30  _______
- *----->|       |----->|       |----->|       |----->|       |----->
- *      |   0   |      |   1   |      |   2   |      |   3   |
- *----->|_______|----->|_______|----->|_______|----->|_______|----->
- *  p01            p11            p21            p31
- *
- * The naming convention is:
- *    pXY = packet Y of stage X, X = 0 .. 3, Y = 0 .. 1
- */
-static int rte_table_hash_ext_lookup(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *t = (struct rte_table_hash *) table;
-	struct grinder *g = t->grinders;
-	uint64_t pkt00_index, pkt01_index, pkt10_index, pkt11_index;
-	uint64_t pkt20_index, pkt21_index, pkt30_index, pkt31_index;
-	uint64_t pkts_mask_out = 0, pkts_mask_match_many = 0;
-	int status = 0;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_HASH_EXT_STATS_PKTS_IN_ADD(t, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 7 packets */
-	if (rte_popcount64(pkts_mask) < 7) {
-		status = rte_table_hash_ext_lookup_unoptimized(table, pkts,
-			pkts_mask, lookup_hit_mask, entries);
-		RTE_TABLE_HASH_EXT_STATS_PKTS_LOOKUP_MISS(t, n_pkts_in -
-				rte_popcount64(*lookup_hit_mask));
-		return status;
-	}
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index);
-
-	/* Pipeline feed */
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-	/* Pipeline feed */
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many);
-
-	/*
-	* Pipeline run
-	*
-	*/
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		pkt30_index = pkt20_index;
-		pkt31_index = pkt21_index;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(t, g, pkts, pkts_mask,
-			pkt00_index, pkt01_index);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2(t, g, pkt20_index, pkt21_index,
-			pkts_mask_match_many);
-
-		/* Pipeline stage 3 */
-		lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index,
-			pkts_mask_out, entries);
-	}
-
-	/* Pipeline feed */
-	pkt30_index = pkt20_index;
-	pkt31_index = pkt21_index;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many);
-
-	/* Pipeline stage 3 */
-	lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out,
-		entries);
-
-	/* Pipeline feed */
-	pkt30_index = pkt20_index;
-	pkt31_index = pkt21_index;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many);
-
-	/* Pipeline stage 3 */
-	lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out,
-		entries);
-
-	/* Pipeline feed */
-	pkt30_index = pkt20_index;
-	pkt31_index = pkt21_index;
-
-	/* Pipeline stage 3 */
-	lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out,
-		entries);
-
-	/* Slow path */
-	pkts_mask_match_many &= ~pkts_mask_out;
-	if (pkts_mask_match_many) {
-		uint64_t pkts_mask_out_slow = 0;
-
-		status = rte_table_hash_ext_lookup_unoptimized(table, pkts,
-			pkts_mask_match_many, &pkts_mask_out_slow, entries);
-		pkts_mask_out |= pkts_mask_out_slow;
-	}
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_EXT_STATS_PKTS_LOOKUP_MISS(t, n_pkts_in - rte_popcount64(pkts_mask_out));
-	return status;
-}
-
-static int
-rte_table_hash_ext_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_hash *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_hash_ext_ops)
-struct rte_table_ops rte_table_hash_ext_ops	 = {
-	.f_create = rte_table_hash_ext_create,
-	.f_free = rte_table_hash_ext_free,
-	.f_add = rte_table_hash_ext_entry_add,
-	.f_delete = rte_table_hash_ext_entry_delete,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_ext_lookup,
-	.f_stats = rte_table_hash_ext_stats_read,
-};
diff --git a/lib/table/rte_table_hash_func.h b/lib/table/rte_table_hash_func.h
deleted file mode 100644
index ca56e6c885..0000000000
--- a/lib/table/rte_table_hash_func.h
+++ /dev/null
@@ -1,263 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2018 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_HASH_FUNC_H__
-#define __INCLUDE_RTE_TABLE_HASH_FUNC_H__
-
-#include <stdint.h>
-
-#include <rte_compat.h>
-#include <rte_common.h>
-
-#if defined(RTE_ARCH_X86_64)
-
-#include <x86intrin.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-static inline uint64_t
-rte_crc32_u64(uint64_t crc, uint64_t v)
-{
-	return _mm_crc32_u64(crc, v);
-}
-
-#ifdef __cplusplus
-}
-#endif
-
-#elif defined(RTE_ARCH_ARM64) && defined(__ARM_FEATURE_CRC32)
-#include "rte_table_hash_func_arm64.h"
-#else
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-static inline uint64_t
-rte_crc32_u64(uint64_t crc, uint64_t v)
-{
-	int i;
-
-	crc = (crc & 0xFFFFFFFFLLU) ^ v;
-	for (i = 63; i >= 0; i--) {
-		uint64_t mask;
-
-		mask = -(crc & 1LLU);
-		crc = (crc >> 1LLU) ^ (0x82F63B78LLU & mask);
-	}
-
-	return crc;
-}
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key8(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t crc0;
-
-	crc0 = rte_crc32_u64(seed, k[0] & m[0]);
-
-	return crc0;
-}
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key16(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t k0, crc0, crc1;
-
-	k0 = k[0] & m[0];
-
-	crc0 = rte_crc32_u64(k0, seed);
-	crc1 = rte_crc32_u64(k0 >> 32, k[1] & m[1]);
-
-	crc0 ^= crc1;
-
-	return crc0;
-}
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key24(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t k0, k2, crc0, crc1;
-
-	k0 = k[0] & m[0];
-	k2 = k[2] & m[2];
-
-	crc0 = rte_crc32_u64(k0, seed);
-	crc1 = rte_crc32_u64(k0 >> 32, k[1] & m[1]);
-
-	crc0 = rte_crc32_u64(crc0, k2);
-
-	crc0 ^= crc1;
-
-	return crc0;
-}
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key32(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t k0, k2, crc0, crc1, crc2, crc3;
-
-	k0 = k[0] & m[0];
-	k2 = k[2] & m[2];
-
-	crc0 = rte_crc32_u64(k0, seed);
-	crc1 = rte_crc32_u64(k0 >> 32, k[1] & m[1]);
-
-	crc2 = rte_crc32_u64(k2, k[3] & m[3]);
-	crc3 = k2 >> 32;
-
-	crc0 = rte_crc32_u64(crc0, crc1);
-	crc1 = rte_crc32_u64(crc2, crc3);
-
-	crc0 ^= crc1;
-
-	return crc0;
-}
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key40(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t k0, k2, crc0, crc1, crc2, crc3;
-
-	k0 = k[0] & m[0];
-	k2 = k[2] & m[2];
-
-	crc0 = rte_crc32_u64(k0, seed);
-	crc1 = rte_crc32_u64(k0 >> 32, k[1] & m[1]);
-
-	crc2 = rte_crc32_u64(k2, k[3] & m[3]);
-	crc3 = rte_crc32_u64(k2 >> 32, k[4] & m[4]);
-
-	crc0 = rte_crc32_u64(crc0, crc1);
-	crc1 = rte_crc32_u64(crc2, crc3);
-
-	crc0 ^= crc1;
-
-	return crc0;
-}
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key48(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t k0, k2, k5, crc0, crc1, crc2, crc3;
-
-	k0 = k[0] & m[0];
-	k2 = k[2] & m[2];
-	k5 = k[5] & m[5];
-
-	crc0 = rte_crc32_u64(k0, seed);
-	crc1 = rte_crc32_u64(k0 >> 32, k[1] & m[1]);
-
-	crc2 = rte_crc32_u64(k2, k[3] & m[3]);
-	crc3 = rte_crc32_u64(k2 >> 32, k[4] & m[4]);
-
-	crc0 = rte_crc32_u64(crc0, (crc1 << 32) ^ crc2);
-	crc1 = rte_crc32_u64(crc3, k5);
-
-	crc0 ^= crc1;
-
-	return crc0;
-}
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key56(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t k0, k2, k5, crc0, crc1, crc2, crc3, crc4, crc5;
-
-	k0 = k[0] & m[0];
-	k2 = k[2] & m[2];
-	k5 = k[5] & m[5];
-
-	crc0 = rte_crc32_u64(k0, seed);
-	crc1 = rte_crc32_u64(k0 >> 32, k[1] & m[1]);
-
-	crc2 = rte_crc32_u64(k2, k[3] & m[3]);
-	crc3 = rte_crc32_u64(k2 >> 32, k[4] & m[4]);
-
-	crc4 = rte_crc32_u64(k5, k[6] & m[6]);
-	crc5 = k5 >> 32;
-
-	crc0 = rte_crc32_u64(crc0, (crc1 << 32) ^ crc2);
-	crc1 = rte_crc32_u64(crc3, (crc4 << 32) ^ crc5);
-
-	crc0 ^= crc1;
-
-	return crc0;
-}
-
-__rte_experimental
-static inline uint64_t
-rte_table_hash_crc_key64(void *key, void *mask, __rte_unused uint32_t key_size,
-	uint64_t seed)
-{
-	uint64_t *k = (uint64_t *)key;
-	uint64_t *m = (uint64_t *)mask;
-	uint64_t k0, k2, k5, crc0, crc1, crc2, crc3, crc4, crc5;
-
-	k0 = k[0] & m[0];
-	k2 = k[2] & m[2];
-	k5 = k[5] & m[5];
-
-	crc0 = rte_crc32_u64(k0, seed);
-	crc1 = rte_crc32_u64(k0 >> 32, k[1] & m[1]);
-
-	crc2 = rte_crc32_u64(k2, k[3] & m[3]);
-	crc3 = rte_crc32_u64(k2 >> 32, k[4] & m[4]);
-
-	crc4 = rte_crc32_u64(k5, k[6] & m[6]);
-	crc5 = rte_crc32_u64(k5 >> 32, k[7] & m[7]);
-
-	crc0 = rte_crc32_u64(crc0, (crc1 << 32) ^ crc2);
-	crc1 = rte_crc32_u64(crc3, (crc4 << 32) ^ crc5);
-
-	crc0 ^= crc1;
-
-	return crc0;
-}
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_table_hash_func_arm64.h b/lib/table/rte_table_hash_func_arm64.h
deleted file mode 100644
index eb04c1ff54..0000000000
--- a/lib/table/rte_table_hash_func_arm64.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2017-2018 Linaro Limited
- */
-
-#ifndef __INCLUDE_RTE_TABLE_HASH_FUNC_ARM64_H__
-#define __INCLUDE_RTE_TABLE_HASH_FUNC_ARM64_H__
-
-#define _CRC32CX(crc, val)	\
-	__asm__("crc32cx %w[c], %w[c], %x[v]":[c] "+r" (crc):[v] "r" (val))
-
-static inline uint64_t
-rte_crc32_u64(uint64_t crc, uint64_t v)
-{
-	uint32_t crc32 = crc;
-
-	_CRC32CX(crc32, v);
-
-	return crc32;
-}
-
-#endif
diff --git a/lib/table/rte_table_hash_key16.c b/lib/table/rte_table_hash_key16.c
deleted file mode 100644
index 5b69106dd7..0000000000
--- a/lib/table/rte_table_hash_key16.c
+++ /dev/null
@@ -1,1190 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2017 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_hash.h"
-#include "rte_lru.h"
-
-#include "table_log.h"
-
-#define KEY_SIZE						16
-
-#define KEYS_PER_BUCKET					4
-
-#define RTE_BUCKET_ENTRY_VALID						0x1LLU
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_HASH_KEY16_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_HASH_KEY16_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_HASH_KEY16_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_HASH_KEY16_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-#ifdef RTE_ARCH_64
-struct rte_bucket_4_16 {
-	/* Cache line 0 */
-	uint64_t signature[4 + 1];
-	uint64_t lru_list;
-	struct rte_bucket_4_16 *next;
-	uint64_t next_valid;
-
-	/* Cache line 1 */
-	uint64_t key[4][2];
-
-	/* Cache line 2 */
-	uint8_t data[];
-};
-#else
-struct rte_bucket_4_16 {
-	/* Cache line 0 */
-	uint64_t signature[4 + 1];
-	uint64_t lru_list;
-	struct rte_bucket_4_16 *next;
-	uint32_t pad;
-	uint64_t next_valid;
-
-	/* Cache line 1 */
-	uint64_t key[4][2];
-
-	/* Cache line 2 */
-	uint8_t data[];
-};
-#endif
-
-struct rte_table_hash {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t n_buckets;
-	uint32_t key_size;
-	uint32_t entry_size;
-	uint32_t bucket_size;
-	uint32_t key_offset;
-	uint64_t key_mask[2];
-	rte_table_hash_op_hash f_hash;
-	uint64_t seed;
-
-	/* Extendible buckets */
-	uint32_t n_buckets_ext;
-	uint32_t stack_pos;
-	uint32_t *stack;
-
-	/* Lookup table */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t memory[];
-};
-
-static int
-keycmp(void *a, void *b, void *b_mask)
-{
-	uint64_t *a64 = a, *b64 = b, *b_mask64 = b_mask;
-
-	return (a64[0] != (b64[0] & b_mask64[0])) ||
-		(a64[1] != (b64[1] & b_mask64[1]));
-}
-
-static void
-keycpy(void *dst, void *src, void *src_mask)
-{
-	uint64_t *dst64 = dst, *src64 = src, *src_mask64 = src_mask;
-
-	dst64[0] = src64[0] & src_mask64[0];
-	dst64[1] = src64[1] & src_mask64[1];
-}
-
-static int
-check_params_create(struct rte_table_hash_params *params)
-{
-	/* name */
-	if (params->name == NULL) {
-		TABLE_LOG(ERR, "%s: name invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* key_size */
-	if (params->key_size != KEY_SIZE) {
-		TABLE_LOG(ERR, "%s: key_size invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* n_keys */
-	if (params->n_keys == 0) {
-		TABLE_LOG(ERR, "%s: n_keys is zero", __func__);
-		return -EINVAL;
-	}
-
-	/* n_buckets */
-	if ((params->n_buckets == 0) ||
-		(!rte_is_power_of_2(params->n_buckets))) {
-		TABLE_LOG(ERR, "%s: n_buckets invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* f_hash */
-	if (params->f_hash == NULL) {
-		TABLE_LOG(ERR, "%s: f_hash function pointer is NULL",
-			__func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void *
-rte_table_hash_create_key16_lru(void *params,
-		int socket_id,
-		uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *f;
-	uint64_t bucket_size, total_size;
-	uint32_t n_buckets, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		((sizeof(struct rte_bucket_4_16) % 64) != 0))
-		return NULL;
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of buckets (n_buckets) so that there a chance
-	 * to store n_keys keys in the table.
-	 *
-	 * Note: Since the buckets do not get extended, it is not possible to
-	 * guarantee that n_keys keys can be stored in the table at any time. In the
-	 * worst case scenario when all the n_keys fall into the same bucket, only
-	 * a maximum of KEYS_PER_BUCKET keys will be stored in the table. This case
-	 * defeats the purpose of the hash table. It indicates unsuitable f_hash or
-	 * n_keys to n_buckets ratio.
-	 *
-	 * MIN(n_buckets) = (n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET
-	 */
-	n_buckets = rte_align32pow2(
-		(p->n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET);
-	n_buckets = RTE_MAX(n_buckets, p->n_buckets);
-
-	/* Memory allocation */
-	bucket_size = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_bucket_4_16) +
-		KEYS_PER_BUCKET * entry_size);
-	total_size = sizeof(struct rte_table_hash) + n_buckets * bucket_size;
-
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-		"for hash table %s",
-		__func__, total_size, p->name);
-		return NULL;
-	}
-
-	f = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-		"for hash table %s",
-		__func__, total_size, p->name);
-		return NULL;
-	}
-	TABLE_LOG(INFO, "%s: Hash table %s memory footprint "
-		"is %" PRIu64 " bytes",
-		__func__, p->name, total_size);
-
-	/* Memory initialization */
-	f->n_buckets = n_buckets;
-	f->key_size = KEY_SIZE;
-	f->entry_size = entry_size;
-	f->bucket_size = bucket_size;
-	f->key_offset = p->key_offset;
-	f->f_hash = p->f_hash;
-	f->seed = p->seed;
-
-	if (p->key_mask != NULL) {
-		f->key_mask[0] = ((uint64_t *)p->key_mask)[0];
-		f->key_mask[1] = ((uint64_t *)p->key_mask)[1];
-	} else {
-		f->key_mask[0] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[1] = 0xFFFFFFFFFFFFFFFFLLU;
-	}
-
-	for (i = 0; i < n_buckets; i++) {
-		struct rte_bucket_4_16 *bucket;
-
-		bucket = (struct rte_bucket_4_16 *) &f->memory[i *
-			f->bucket_size];
-		lru_init(bucket);
-	}
-
-	return f;
-}
-
-static int
-rte_table_hash_free_key16_lru(void *table)
-{
-	struct rte_table_hash *f = table;
-
-	/* Check input parameters */
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	rte_free(f);
-	return 0;
-}
-
-static int
-rte_table_hash_entry_add_key16_lru(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_16 *bucket;
-	uint64_t signature, pos;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket = (struct rte_bucket_4_16 *)
-		&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (i = 0; i < 4; i++) {
-		uint64_t bucket_signature = bucket->signature[i];
-		uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-		if ((bucket_signature == signature) &&
-			(keycmp(bucket_key, key, f->key_mask) == 0)) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			memcpy(bucket_data, entry, f->entry_size);
-			lru_update(bucket, i);
-			*key_found = 1;
-			*entry_ptr = (void *) bucket_data;
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	for (i = 0; i < 4; i++) {
-		uint64_t bucket_signature = bucket->signature[i];
-		uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-		if (bucket_signature == 0) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			bucket->signature[i] = signature;
-			keycpy(bucket_key, key, f->key_mask);
-			memcpy(bucket_data, entry, f->entry_size);
-			lru_update(bucket, i);
-			*key_found = 0;
-			*entry_ptr = (void *) bucket_data;
-
-			return 0;
-		}
-	}
-
-	/* Bucket full: replace LRU entry */
-	pos = lru_pos(bucket);
-	bucket->signature[pos] = signature;
-	keycpy(&bucket->key[pos], key, f->key_mask);
-	memcpy(&bucket->data[pos * f->entry_size], entry, f->entry_size);
-	lru_update(bucket, pos);
-	*key_found = 0;
-	*entry_ptr = (void *) &bucket->data[pos * f->entry_size];
-
-	return 0;
-}
-
-static int
-rte_table_hash_entry_delete_key16_lru(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_16 *bucket;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket = (struct rte_bucket_4_16 *)
-		&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (i = 0; i < 4; i++) {
-		uint64_t bucket_signature = bucket->signature[i];
-		uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-		if ((bucket_signature == signature) &&
-			(keycmp(bucket_key, key, f->key_mask) == 0)) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			bucket->signature[i] = 0;
-			*key_found = 1;
-			if (entry)
-				memcpy(entry, bucket_data, f->entry_size);
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-static void *
-rte_table_hash_create_key16_ext(void *params,
-		int socket_id,
-		uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *f;
-	uint64_t bucket_size, stack_size, total_size;
-	uint32_t n_buckets_ext, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		((sizeof(struct rte_bucket_4_16) % 64) != 0))
-		return NULL;
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of bucket extensions (n_buckets_ext) so that
-	 * it is guaranteed that n_keys keys can be stored in the table at any time.
-	 *
-	 * The worst case scenario takes place when all the n_keys keys fall into
-	 * the same bucket. Actually, due to the KEYS_PER_BUCKET scheme, the worst
-	 * case takes place when (n_keys - KEYS_PER_BUCKET + 1) keys fall into the
-	 * same bucket, while the remaining (KEYS_PER_BUCKET - 1) keys each fall
-	 * into a different bucket. This case defeats the purpose of the hash table.
-	 * It indicates unsuitable f_hash or n_keys to n_buckets ratio.
-	 *
-	 * n_buckets_ext = n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1
-	 */
-	n_buckets_ext = p->n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1;
-
-	/* Memory allocation */
-	bucket_size = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_bucket_4_16) +
-		KEYS_PER_BUCKET * entry_size);
-	stack_size = RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(uint32_t));
-	total_size = sizeof(struct rte_table_hash) +
-		(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	f = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-	TABLE_LOG(INFO, "%s: Hash table %s memory footprint "
-		"is %" PRIu64 " bytes",
-		__func__, p->name, total_size);
-
-	/* Memory initialization */
-	f->n_buckets = p->n_buckets;
-	f->key_size = KEY_SIZE;
-	f->entry_size = entry_size;
-	f->bucket_size = bucket_size;
-	f->key_offset = p->key_offset;
-	f->f_hash = p->f_hash;
-	f->seed = p->seed;
-
-	f->n_buckets_ext = n_buckets_ext;
-	f->stack_pos = n_buckets_ext;
-	f->stack = (uint32_t *)
-		&f->memory[(p->n_buckets + n_buckets_ext) * f->bucket_size];
-
-	if (p->key_mask != NULL) {
-		f->key_mask[0] = (((uint64_t *)p->key_mask)[0]);
-		f->key_mask[1] = (((uint64_t *)p->key_mask)[1]);
-	} else {
-		f->key_mask[0] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[1] = 0xFFFFFFFFFFFFFFFFLLU;
-	}
-
-	for (i = 0; i < n_buckets_ext; i++)
-		f->stack[i] = i;
-
-	return f;
-}
-
-static int
-rte_table_hash_free_key16_ext(void *table)
-{
-	struct rte_table_hash *f = table;
-
-	/* Check input parameters */
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	rte_free(f);
-	return 0;
-}
-
-static int
-rte_table_hash_entry_add_key16_ext(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_16 *bucket0, *bucket, *bucket_prev;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket0 = (struct rte_bucket_4_16 *)
-		&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (bucket = bucket0; bucket != NULL; bucket = bucket->next)
-		for (i = 0; i < 4; i++) {
-			uint64_t bucket_signature = bucket->signature[i];
-			uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-			if ((bucket_signature == signature) &&
-				(keycmp(bucket_key, key, f->key_mask) == 0)) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				memcpy(bucket_data, entry, f->entry_size);
-				*key_found = 1;
-				*entry_ptr = (void *) bucket_data;
-				return 0;
-			}
-		}
-
-	/* Key is not present in the bucket */
-	for (bucket_prev = NULL, bucket = bucket0; bucket != NULL;
-		bucket_prev = bucket, bucket = bucket->next)
-		for (i = 0; i < 4; i++) {
-			uint64_t bucket_signature = bucket->signature[i];
-			uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-			if (bucket_signature == 0) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				bucket->signature[i] = signature;
-				keycpy(bucket_key, key, f->key_mask);
-				memcpy(bucket_data, entry, f->entry_size);
-				*key_found = 0;
-				*entry_ptr = (void *) bucket_data;
-
-				return 0;
-			}
-		}
-
-	/* Bucket full: extend bucket */
-	if (f->stack_pos > 0) {
-		bucket_index = f->stack[--f->stack_pos];
-
-		bucket = (struct rte_bucket_4_16 *) &f->memory[(f->n_buckets +
-			bucket_index) * f->bucket_size];
-		bucket_prev->next = bucket;
-		bucket_prev->next_valid = 1;
-
-		bucket->signature[0] = signature;
-		keycpy(&bucket->key[0], key, f->key_mask);
-		memcpy(&bucket->data[0], entry, f->entry_size);
-		*key_found = 0;
-		*entry_ptr = (void *) &bucket->data[0];
-		return 0;
-	}
-
-	return -ENOSPC;
-}
-
-static int
-rte_table_hash_entry_delete_key16_ext(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_16 *bucket0, *bucket, *bucket_prev;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket0 = (struct rte_bucket_4_16 *)
-		&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (bucket_prev = NULL, bucket = bucket0; bucket != NULL;
-		bucket_prev = bucket, bucket = bucket->next)
-		for (i = 0; i < 4; i++) {
-			uint64_t bucket_signature = bucket->signature[i];
-			uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-			if ((bucket_signature == signature) &&
-				(keycmp(bucket_key, key, f->key_mask) == 0)) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				bucket->signature[i] = 0;
-				*key_found = 1;
-				if (entry)
-					memcpy(entry, bucket_data, f->entry_size);
-
-				if ((bucket->signature[0] == 0) &&
-					(bucket->signature[1] == 0) &&
-					(bucket->signature[2] == 0) &&
-					(bucket->signature[3] == 0) &&
-					(bucket_prev != NULL)) {
-					bucket_prev->next = bucket->next;
-					bucket_prev->next_valid =
-						bucket->next_valid;
-
-					memset(bucket, 0,
-						sizeof(struct rte_bucket_4_16));
-					bucket_index = (((uint8_t *)bucket -
-						(uint8_t *)f->memory)/f->bucket_size) - f->n_buckets;
-					f->stack[f->stack_pos++] = bucket_index;
-				}
-
-				return 0;
-			}
-		}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-#define lookup_key16_cmp(key_in, bucket, pos, f)			\
-{								\
-	uint64_t xor[4][2], or[4], signature[4], k[2];		\
-								\
-	k[0] = key_in[0] & f->key_mask[0];				\
-	k[1] = key_in[1] & f->key_mask[1];				\
-	signature[0] = (~bucket->signature[0]) & 1;		\
-	signature[1] = (~bucket->signature[1]) & 1;		\
-	signature[2] = (~bucket->signature[2]) & 1;		\
-	signature[3] = (~bucket->signature[3]) & 1;		\
-								\
-	xor[0][0] = k[0] ^ bucket->key[0][0];			\
-	xor[0][1] = k[1] ^ bucket->key[0][1];			\
-								\
-	xor[1][0] = k[0] ^ bucket->key[1][0];			\
-	xor[1][1] = k[1] ^ bucket->key[1][1];			\
-								\
-	xor[2][0] = k[0] ^ bucket->key[2][0];			\
-	xor[2][1] = k[1] ^ bucket->key[2][1];			\
-								\
-	xor[3][0] = k[0] ^ bucket->key[3][0];			\
-	xor[3][1] = k[1] ^ bucket->key[3][1];			\
-								\
-	or[0] = xor[0][0] | xor[0][1] | signature[0];		\
-	or[1] = xor[1][0] | xor[1][1] | signature[1];		\
-	or[2] = xor[2][0] | xor[2][1] | signature[2];		\
-	or[3] = xor[3][0] | xor[3][1] | signature[3];		\
-								\
-	pos = 4;						\
-	if (or[0] == 0)						\
-		pos = 0;					\
-	if (or[1] == 0)						\
-		pos = 1;					\
-	if (or[2] == 0)						\
-		pos = 2;					\
-	if (or[3] == 0)						\
-		pos = 3;					\
-}
-
-#define lookup1_stage0(pkt0_index, mbuf0, pkts, pkts_mask, f)	\
-{								\
-	uint64_t pkt_mask;					\
-	uint32_t key_offset = f->key_offset;\
-								\
-	pkt0_index = rte_ctz64(pkts_mask);		\
-	pkt_mask = 1LLU << pkt0_index;				\
-	pkts_mask &= ~pkt_mask;					\
-								\
-	mbuf0 = pkts[pkt0_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf0, key_offset));\
-}
-
-#define lookup1_stage1(mbuf1, bucket1, f)			\
-{								\
-	uint64_t *key;						\
-	uint64_t signature = 0;				\
-	uint32_t bucket_index;				\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf1, f->key_offset);\
-	signature = f->f_hash(key, f->key_mask, KEY_SIZE, f->seed);	\
-								\
-	bucket_index = signature & (f->n_buckets - 1);		\
-	bucket1 = (struct rte_bucket_4_16 *)			\
-		&f->memory[bucket_index * f->bucket_size];	\
-	rte_prefetch0(bucket1);					\
-	rte_prefetch0((void *)(((uintptr_t) bucket1) + RTE_CACHE_LINE_SIZE));\
-}
-
-#define lookup1_stage2_lru(pkt2_index, mbuf2, bucket2,		\
-		pkts_mask_out, entries, f)			\
-{								\
-	void *a;						\
-	uint64_t pkt_mask;					\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf2, f->key_offset);\
-	lookup_key16_cmp(key, bucket2, pos, f);			\
-								\
-	pkt_mask = (bucket2->signature[pos] & 1LLU) << pkt2_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket2->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt2_index] = a;				\
-	lru_update(bucket2, pos);				\
-}
-
-#define lookup1_stage2_ext(pkt2_index, mbuf2, bucket2, pkts_mask_out, entries, \
-	buckets_mask, buckets, keys, f)				\
-{								\
-	struct rte_bucket_4_16 *bucket_next;			\
-	void *a;						\
-	uint64_t pkt_mask, bucket_mask;				\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf2, f->key_offset);\
-	lookup_key16_cmp(key, bucket2, pos, f);			\
-								\
-	pkt_mask = (bucket2->signature[pos] & 1LLU) << pkt2_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket2->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt2_index] = a;				\
-								\
-	bucket_mask = (~pkt_mask) & (bucket2->next_valid << pkt2_index);\
-	buckets_mask |= bucket_mask;				\
-	bucket_next = bucket2->next;				\
-	buckets[pkt2_index] = bucket_next;			\
-	keys[pkt2_index] = key;					\
-}
-
-#define lookup_grinder(pkt_index, buckets, keys, pkts_mask_out, entries,\
-	buckets_mask, f)					\
-{								\
-	struct rte_bucket_4_16 *bucket, *bucket_next;		\
-	void *a;						\
-	uint64_t pkt_mask, bucket_mask;				\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	bucket = buckets[pkt_index];				\
-	key = keys[pkt_index];					\
-	lookup_key16_cmp(key, bucket, pos, f);			\
-								\
-	pkt_mask = (bucket->signature[pos] & 1LLU) << pkt_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt_index] = a;					\
-								\
-	bucket_mask = (~pkt_mask) & (bucket->next_valid << pkt_index);\
-	buckets_mask |= bucket_mask;				\
-	bucket_next = bucket->next;				\
-	rte_prefetch0(bucket_next);				\
-	rte_prefetch0((void *)(((uintptr_t) bucket_next) + RTE_CACHE_LINE_SIZE));\
-	buckets[pkt_index] = bucket_next;			\
-	keys[pkt_index] = key;					\
-}
-
-#define lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01,\
-		pkts, pkts_mask, f)				\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	uint32_t key_offset = f->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-								\
-	mbuf00 = pkts[pkt00_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-								\
-	mbuf01 = pkts[pkt01_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,\
-		mbuf00, mbuf01, pkts, pkts_mask, f)		\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	uint32_t key_offset = f->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-								\
-	mbuf00 = pkts[pkt00_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));	\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	if (pkts_mask == 0)					\
-		pkt01_index = pkt00_index;			\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-								\
-	mbuf01 = pkts[pkt01_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));	\
-}
-
-#define lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f)	\
-{								\
-	uint64_t *key10, *key11;					\
-	uint64_t signature10, signature11;			\
-	uint32_t bucket10_index, bucket11_index;	\
-								\
-	key10 = RTE_MBUF_METADATA_UINT64_PTR(mbuf10, f->key_offset);\
-	signature10 = f->f_hash(key10, f->key_mask,	 KEY_SIZE, f->seed);\
-	bucket10_index = signature10 & (f->n_buckets - 1);	\
-	bucket10 = (struct rte_bucket_4_16 *)				\
-		&f->memory[bucket10_index * f->bucket_size];	\
-	rte_prefetch0(bucket10);				\
-	rte_prefetch0((void *)(((uintptr_t) bucket10) + RTE_CACHE_LINE_SIZE));\
-								\
-	key11 = RTE_MBUF_METADATA_UINT64_PTR(mbuf11, f->key_offset);\
-	signature11 = f->f_hash(key11, f->key_mask,	 KEY_SIZE, f->seed);\
-	bucket11_index = signature11 & (f->n_buckets - 1);	\
-	bucket11 = (struct rte_bucket_4_16 *)			\
-		&f->memory[bucket11_index * f->bucket_size];	\
-	rte_prefetch0(bucket11);				\
-	rte_prefetch0((void *)(((uintptr_t) bucket11) + RTE_CACHE_LINE_SIZE));\
-}
-
-#define lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,\
-		bucket20, bucket21, pkts_mask_out, entries, f)	\
-{								\
-	void *a20, *a21;					\
-	uint64_t pkt20_mask, pkt21_mask;			\
-	uint64_t *key20, *key21;				\
-	uint32_t pos20, pos21;					\
-								\
-	key20 = RTE_MBUF_METADATA_UINT64_PTR(mbuf20, f->key_offset);\
-	key21 = RTE_MBUF_METADATA_UINT64_PTR(mbuf21, f->key_offset);\
-								\
-	lookup_key16_cmp(key20, bucket20, pos20, f);		\
-	lookup_key16_cmp(key21, bucket21, pos21, f);		\
-								\
-	pkt20_mask = (bucket20->signature[pos20] & 1LLU) << pkt20_index;\
-	pkt21_mask = (bucket21->signature[pos21] & 1LLU) << pkt21_index;\
-	pkts_mask_out |= pkt20_mask | pkt21_mask;			\
-								\
-	a20 = (void *) &bucket20->data[pos20 * f->entry_size];	\
-	a21 = (void *) &bucket21->data[pos21 * f->entry_size];	\
-	rte_prefetch0(a20);					\
-	rte_prefetch0(a21);					\
-	entries[pkt20_index] = a20;				\
-	entries[pkt21_index] = a21;				\
-	lru_update(bucket20, pos20);				\
-	lru_update(bucket21, pos21);				\
-}
-
-#define lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21, bucket20, \
-	bucket21, pkts_mask_out, entries, buckets_mask, buckets, keys, f) \
-{								\
-	struct rte_bucket_4_16 *bucket20_next, *bucket21_next;	\
-	void *a20, *a21;					\
-	uint64_t pkt20_mask, pkt21_mask, bucket20_mask, bucket21_mask;\
-	uint64_t *key20, *key21;				\
-	uint32_t pos20, pos21;					\
-								\
-	key20 = RTE_MBUF_METADATA_UINT64_PTR(mbuf20, f->key_offset);\
-	key21 = RTE_MBUF_METADATA_UINT64_PTR(mbuf21, f->key_offset);\
-								\
-	lookup_key16_cmp(key20, bucket20, pos20, f);	\
-	lookup_key16_cmp(key21, bucket21, pos21, f);	\
-								\
-	pkt20_mask = (bucket20->signature[pos20] & 1LLU) << pkt20_index;\
-	pkt21_mask = (bucket21->signature[pos21] & 1LLU) << pkt21_index;\
-	pkts_mask_out |= pkt20_mask | pkt21_mask;		\
-								\
-	a20 = (void *) &bucket20->data[pos20 * f->entry_size];	\
-	a21 = (void *) &bucket21->data[pos21 * f->entry_size];	\
-	rte_prefetch0(a20);					\
-	rte_prefetch0(a21);					\
-	entries[pkt20_index] = a20;				\
-	entries[pkt21_index] = a21;				\
-								\
-	bucket20_mask = (~pkt20_mask) & (bucket20->next_valid << pkt20_index);\
-	bucket21_mask = (~pkt21_mask) & (bucket21->next_valid << pkt21_index);\
-	buckets_mask |= bucket20_mask | bucket21_mask;		\
-	bucket20_next = bucket20->next;				\
-	bucket21_next = bucket21->next;				\
-	buckets[pkt20_index] = bucket20_next;			\
-	buckets[pkt21_index] = bucket21_next;			\
-	keys[pkt20_index] = key20;				\
-	keys[pkt21_index] = key21;				\
-}
-
-static int
-rte_table_hash_lookup_key16_lru(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *f = (struct rte_table_hash *) table;
-	struct rte_bucket_4_16 *bucket10, *bucket11, *bucket20, *bucket21;
-	struct rte_mbuf *mbuf00, *mbuf01, *mbuf10, *mbuf11, *mbuf20, *mbuf21;
-	uint32_t pkt00_index, pkt01_index, pkt10_index;
-	uint32_t pkt11_index, pkt20_index, pkt21_index;
-	uint64_t pkts_mask_out = 0;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-
-	RTE_TABLE_HASH_KEY16_STATS_PKTS_IN_ADD(f, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 5 packets */
-	if (rte_popcount64(pkts_mask) < 5) {
-		for ( ; pkts_mask; ) {
-			struct rte_bucket_4_16 *bucket;
-			struct rte_mbuf *mbuf;
-			uint32_t pkt_index;
-
-			lookup1_stage0(pkt_index, mbuf, pkts, pkts_mask, f);
-			lookup1_stage1(mbuf, bucket, f);
-			lookup1_stage2_lru(pkt_index, mbuf, bucket,
-				pkts_mask_out, entries, f);
-		}
-
-		*lookup_hit_mask = pkts_mask_out;
-		RTE_TABLE_HASH_KEY16_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in -
-			rte_popcount64(pkts_mask_out));
-		return 0;
-	}
-
-	/*
-	 * Pipeline fill
-	 *
-	 */
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline feed */
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/*
-	 * Pipeline run
-	 *
-	 */
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		bucket20 = bucket10;
-		bucket21 = bucket11;
-		mbuf20 = mbuf10;
-		mbuf21 = mbuf11;
-		mbuf10 = mbuf00;
-		mbuf11 = mbuf01;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,
-			mbuf00, mbuf01, pkts, pkts_mask, f);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,
-			bucket20, bucket21, pkts_mask_out, entries, f);
-	}
-
-	/*
-	 * Pipeline flush
-	 *
-	 */
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries, f);
-
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries, f);
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_KEY16_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in -
-		rte_popcount64(pkts_mask_out));
-	return 0;
-} /* lookup LRU */
-
-static int
-rte_table_hash_lookup_key16_ext(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *f = (struct rte_table_hash *) table;
-	struct rte_bucket_4_16 *bucket10, *bucket11, *bucket20, *bucket21;
-	struct rte_mbuf *mbuf00, *mbuf01, *mbuf10, *mbuf11, *mbuf20, *mbuf21;
-	uint32_t pkt00_index, pkt01_index, pkt10_index;
-	uint32_t pkt11_index, pkt20_index, pkt21_index;
-	uint64_t pkts_mask_out = 0, buckets_mask = 0;
-	struct rte_bucket_4_16 *buckets[RTE_PORT_IN_BURST_SIZE_MAX];
-	uint64_t *keys[RTE_PORT_IN_BURST_SIZE_MAX];
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-
-	RTE_TABLE_HASH_KEY16_STATS_PKTS_IN_ADD(f, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 5 packets */
-	if (rte_popcount64(pkts_mask) < 5) {
-		for ( ; pkts_mask; ) {
-			struct rte_bucket_4_16 *bucket;
-			struct rte_mbuf *mbuf;
-			uint32_t pkt_index;
-
-			lookup1_stage0(pkt_index, mbuf, pkts, pkts_mask, f);
-			lookup1_stage1(mbuf, bucket, f);
-			lookup1_stage2_ext(pkt_index, mbuf, bucket,
-				pkts_mask_out, entries, buckets_mask,
-				buckets, keys, f);
-		}
-
-		goto grind_next_buckets;
-	}
-
-	/*
-	 * Pipeline fill
-	 *
-	 */
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline feed */
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/*
-	 * Pipeline run
-	 *
-	 */
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		bucket20 = bucket10;
-		bucket21 = bucket11;
-		mbuf20 = mbuf10;
-		mbuf21 = mbuf11;
-		mbuf10 = mbuf00;
-		mbuf11 = mbuf01;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,
-			mbuf00, mbuf01, pkts, pkts_mask, f);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-			bucket20, bucket21, pkts_mask_out, entries,
-			buckets_mask, buckets, keys, f);
-	}
-
-	/*
-	 * Pipeline flush
-	 *
-	 */
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries,
-		buckets_mask, buckets, keys, f);
-
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries,
-		buckets_mask, buckets, keys, f);
-
-grind_next_buckets:
-	/* Grind next buckets */
-	for ( ; buckets_mask; ) {
-		uint64_t buckets_mask_next = 0;
-
-		for ( ; buckets_mask; ) {
-			uint32_t pkt_index;
-
-			pkt_index = rte_ctz64(buckets_mask);
-			buckets_mask &= ~(1LLU << pkt_index);
-
-			lookup_grinder(pkt_index, buckets, keys, pkts_mask_out,
-				entries, buckets_mask_next, f);
-		}
-
-		buckets_mask = buckets_mask_next;
-	}
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_KEY16_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in -
-		rte_popcount64(pkts_mask_out));
-	return 0;
-} /* lookup EXT */
-
-static int
-rte_table_hash_key16_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_hash *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_hash_key16_lru_ops)
-struct rte_table_ops rte_table_hash_key16_lru_ops = {
-	.f_create = rte_table_hash_create_key16_lru,
-	.f_free = rte_table_hash_free_key16_lru,
-	.f_add = rte_table_hash_entry_add_key16_lru,
-	.f_delete = rte_table_hash_entry_delete_key16_lru,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_lookup_key16_lru,
-	.f_stats = rte_table_hash_key16_stats_read,
-};
-
-RTE_EXPORT_SYMBOL(rte_table_hash_key16_ext_ops)
-struct rte_table_ops rte_table_hash_key16_ext_ops = {
-	.f_create = rte_table_hash_create_key16_ext,
-	.f_free = rte_table_hash_free_key16_ext,
-	.f_add = rte_table_hash_entry_add_key16_ext,
-	.f_delete = rte_table_hash_entry_delete_key16_ext,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_lookup_key16_ext,
-	.f_stats = rte_table_hash_key16_stats_read,
-};
diff --git a/lib/table/rte_table_hash_key32.c b/lib/table/rte_table_hash_key32.c
deleted file mode 100644
index 0963f57828..0000000000
--- a/lib/table/rte_table_hash_key32.c
+++ /dev/null
@@ -1,1223 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2017 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_hash.h"
-#include "rte_lru.h"
-
-#include "table_log.h"
-
-#define KEY_SIZE						32
-
-#define KEYS_PER_BUCKET					4
-
-#define RTE_BUCKET_ENTRY_VALID						0x1LLU
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_HASH_KEY32_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_HASH_KEY32_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_HASH_KEY32_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_HASH_KEY32_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-#ifdef RTE_ARCH_64
-struct rte_bucket_4_32 {
-	/* Cache line 0 */
-	uint64_t signature[4 + 1];
-	uint64_t lru_list;
-	struct rte_bucket_4_32 *next;
-	uint64_t next_valid;
-
-	/* Cache lines 1 and 2 */
-	uint64_t key[4][4];
-
-	/* Cache line 3 */
-	uint8_t data[];
-};
-#else
-struct rte_bucket_4_32 {
-	/* Cache line 0 */
-	uint64_t signature[4 + 1];
-	uint64_t lru_list;
-	struct rte_bucket_4_32 *next;
-	uint32_t pad;
-	uint64_t next_valid;
-
-	/* Cache lines 1 and 2 */
-	uint64_t key[4][4];
-
-	/* Cache line 3 */
-	uint8_t data[];
-};
-#endif
-
-struct rte_table_hash {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t n_buckets;
-	uint32_t key_size;
-	uint32_t entry_size;
-	uint32_t bucket_size;
-	uint32_t key_offset;
-	uint64_t key_mask[4];
-	rte_table_hash_op_hash f_hash;
-	uint64_t seed;
-
-	/* Extendible buckets */
-	uint32_t n_buckets_ext;
-	uint32_t stack_pos;
-	uint32_t *stack;
-
-	/* Lookup table */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t memory[];
-};
-
-static int
-keycmp(void *a, void *b, void *b_mask)
-{
-	uint64_t *a64 = a, *b64 = b, *b_mask64 = b_mask;
-
-	return (a64[0] != (b64[0] & b_mask64[0])) ||
-		(a64[1] != (b64[1] & b_mask64[1])) ||
-		(a64[2] != (b64[2] & b_mask64[2])) ||
-		(a64[3] != (b64[3] & b_mask64[3]));
-}
-
-static void
-keycpy(void *dst, void *src, void *src_mask)
-{
-	uint64_t *dst64 = dst, *src64 = src, *src_mask64 = src_mask;
-
-	dst64[0] = src64[0] & src_mask64[0];
-	dst64[1] = src64[1] & src_mask64[1];
-	dst64[2] = src64[2] & src_mask64[2];
-	dst64[3] = src64[3] & src_mask64[3];
-}
-
-static int
-check_params_create(struct rte_table_hash_params *params)
-{
-	/* name */
-	if (params->name == NULL) {
-		TABLE_LOG(ERR, "%s: name invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* key_size */
-	if (params->key_size != KEY_SIZE) {
-		TABLE_LOG(ERR, "%s: key_size invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* n_keys */
-	if (params->n_keys == 0) {
-		TABLE_LOG(ERR, "%s: n_keys is zero", __func__);
-		return -EINVAL;
-	}
-
-	/* n_buckets */
-	if ((params->n_buckets == 0) ||
-		(!rte_is_power_of_2(params->n_buckets))) {
-		TABLE_LOG(ERR, "%s: n_buckets invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* f_hash */
-	if (params->f_hash == NULL) {
-		TABLE_LOG(ERR, "%s: f_hash function pointer is NULL",
-			__func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void *
-rte_table_hash_create_key32_lru(void *params,
-		int socket_id,
-		uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *f;
-	uint64_t bucket_size, total_size;
-	uint32_t n_buckets, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		((sizeof(struct rte_bucket_4_32) % 64) != 0))
-		return NULL;
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of buckets (n_buckets) so that there a chance
-	 * to store n_keys keys in the table.
-	 *
-	 * Note: Since the buckets do not get extended, it is not possible to
-	 * guarantee that n_keys keys can be stored in the table at any time. In the
-	 * worst case scenario when all the n_keys fall into the same bucket, only
-	 * a maximum of KEYS_PER_BUCKET keys will be stored in the table. This case
-	 * defeats the purpose of the hash table. It indicates unsuitable f_hash or
-	 * n_keys to n_buckets ratio.
-	 *
-	 * MIN(n_buckets) = (n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET
-	 */
-	n_buckets = rte_align32pow2(
-		(p->n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET);
-	n_buckets = RTE_MAX(n_buckets, p->n_buckets);
-
-	/* Memory allocation */
-	bucket_size = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_bucket_4_32) +
-		KEYS_PER_BUCKET * entry_size);
-	total_size = sizeof(struct rte_table_hash) + n_buckets * bucket_size;
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	f = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-	TABLE_LOG(INFO,
-		"%s: Hash table %s memory footprint "
-		"is %" PRIu64 " bytes",
-		__func__, p->name, total_size);
-
-	/* Memory initialization */
-	f->n_buckets = n_buckets;
-	f->key_size = KEY_SIZE;
-	f->entry_size = entry_size;
-	f->bucket_size = bucket_size;
-	f->key_offset = p->key_offset;
-	f->f_hash = p->f_hash;
-	f->seed = p->seed;
-
-	if (p->key_mask != NULL) {
-		f->key_mask[0] = ((uint64_t *)p->key_mask)[0];
-		f->key_mask[1] = ((uint64_t *)p->key_mask)[1];
-		f->key_mask[2] = ((uint64_t *)p->key_mask)[2];
-		f->key_mask[3] = ((uint64_t *)p->key_mask)[3];
-	} else {
-		f->key_mask[0] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[1] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[2] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[3] = 0xFFFFFFFFFFFFFFFFLLU;
-	}
-
-	for (i = 0; i < n_buckets; i++) {
-		struct rte_bucket_4_32 *bucket;
-
-		bucket = (struct rte_bucket_4_32 *) &f->memory[i *
-			f->bucket_size];
-		bucket->lru_list = 0x0000000100020003LLU;
-	}
-
-	return f;
-}
-
-static int
-rte_table_hash_free_key32_lru(void *table)
-{
-	struct rte_table_hash *f = table;
-
-	/* Check input parameters */
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	rte_free(f);
-	return 0;
-}
-
-static int
-rte_table_hash_entry_add_key32_lru(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_32 *bucket;
-	uint64_t signature, pos;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket = (struct rte_bucket_4_32 *)
-		&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (i = 0; i < 4; i++) {
-		uint64_t bucket_signature = bucket->signature[i];
-		uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-		if ((bucket_signature == signature) &&
-			(keycmp(bucket_key, key, f->key_mask) == 0)) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			memcpy(bucket_data, entry, f->entry_size);
-			lru_update(bucket, i);
-			*key_found = 1;
-			*entry_ptr = (void *) bucket_data;
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	for (i = 0; i < 4; i++) {
-		uint64_t bucket_signature = bucket->signature[i];
-		uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-		if (bucket_signature == 0) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			bucket->signature[i] = signature;
-			keycpy(bucket_key, key, f->key_mask);
-			memcpy(bucket_data, entry, f->entry_size);
-			lru_update(bucket, i);
-			*key_found = 0;
-			*entry_ptr = (void *) bucket_data;
-
-			return 0;
-		}
-	}
-
-	/* Bucket full: replace LRU entry */
-	pos = lru_pos(bucket);
-	bucket->signature[pos] = signature;
-	keycpy(&bucket->key[pos], key, f->key_mask);
-	memcpy(&bucket->data[pos * f->entry_size], entry, f->entry_size);
-	lru_update(bucket, pos);
-	*key_found = 0;
-	*entry_ptr = (void *) &bucket->data[pos * f->entry_size];
-
-	return 0;
-}
-
-static int
-rte_table_hash_entry_delete_key32_lru(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_32 *bucket;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket = (struct rte_bucket_4_32 *)
-		&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (i = 0; i < 4; i++) {
-		uint64_t bucket_signature = bucket->signature[i];
-		uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-		if ((bucket_signature == signature) &&
-			(keycmp(bucket_key, key, f->key_mask) == 0)) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			bucket->signature[i] = 0;
-			*key_found = 1;
-			if (entry)
-				memcpy(entry, bucket_data, f->entry_size);
-
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-static void *
-rte_table_hash_create_key32_ext(void *params,
-	int socket_id,
-	uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *f;
-	uint64_t bucket_size, stack_size, total_size;
-	uint32_t n_buckets_ext, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		((sizeof(struct rte_bucket_4_32) % 64) != 0))
-		return NULL;
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of bucket extensions (n_buckets_ext) so that
-	 * it is guaranteed that n_keys keys can be stored in the table at any time.
-	 *
-	 * The worst case scenario takes place when all the n_keys keys fall into
-	 * the same bucket. Actually, due to the KEYS_PER_BUCKET scheme, the worst
-	 * case takes place when (n_keys - KEYS_PER_BUCKET + 1) keys fall into the
-	 * same bucket, while the remaining (KEYS_PER_BUCKET - 1) keys each fall
-	 * into a different bucket. This case defeats the purpose of the hash table.
-	 * It indicates unsuitable f_hash or n_keys to n_buckets ratio.
-	 *
-	 * n_buckets_ext = n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1
-	 */
-	n_buckets_ext = p->n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1;
-
-	/* Memory allocation */
-	bucket_size = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_bucket_4_32) +
-		KEYS_PER_BUCKET * entry_size);
-	stack_size = RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(uint32_t));
-	total_size = sizeof(struct rte_table_hash) +
-		(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	f = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-	TABLE_LOG(INFO,
-		"%s: Hash table %s memory footprint "
-		"is %" PRIu64" bytes",
-		__func__, p->name, total_size);
-
-	/* Memory initialization */
-	f->n_buckets = p->n_buckets;
-	f->key_size = KEY_SIZE;
-	f->entry_size = entry_size;
-	f->bucket_size = bucket_size;
-	f->key_offset = p->key_offset;
-	f->f_hash = p->f_hash;
-	f->seed = p->seed;
-
-	f->n_buckets_ext = n_buckets_ext;
-	f->stack_pos = n_buckets_ext;
-	f->stack = (uint32_t *)
-		&f->memory[(p->n_buckets + n_buckets_ext) * f->bucket_size];
-
-	if (p->key_mask != NULL) {
-		f->key_mask[0] = (((uint64_t *)p->key_mask)[0]);
-		f->key_mask[1] = (((uint64_t *)p->key_mask)[1]);
-		f->key_mask[2] = (((uint64_t *)p->key_mask)[2]);
-		f->key_mask[3] = (((uint64_t *)p->key_mask)[3]);
-	} else {
-		f->key_mask[0] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[1] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[2] = 0xFFFFFFFFFFFFFFFFLLU;
-		f->key_mask[3] = 0xFFFFFFFFFFFFFFFFLLU;
-	}
-
-	for (i = 0; i < n_buckets_ext; i++)
-		f->stack[i] = i;
-
-	return f;
-}
-
-static int
-rte_table_hash_free_key32_ext(void *table)
-{
-	struct rte_table_hash *f = table;
-
-	/* Check input parameters */
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	rte_free(f);
-	return 0;
-}
-
-static int
-rte_table_hash_entry_add_key32_ext(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_32 *bucket0, *bucket, *bucket_prev;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket0 = (struct rte_bucket_4_32 *)
-			&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (bucket = bucket0; bucket != NULL; bucket = bucket->next) {
-		for (i = 0; i < 4; i++) {
-			uint64_t bucket_signature = bucket->signature[i];
-			uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-			if ((bucket_signature == signature) &&
-				(keycmp(bucket_key, key, f->key_mask) == 0)) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				memcpy(bucket_data, entry, f->entry_size);
-				*key_found = 1;
-				*entry_ptr = (void *) bucket_data;
-
-				return 0;
-			}
-		}
-	}
-
-	/* Key is not present in the bucket */
-	for (bucket_prev = NULL, bucket = bucket0; bucket != NULL;
-		bucket_prev = bucket, bucket = bucket->next)
-		for (i = 0; i < 4; i++) {
-			uint64_t bucket_signature = bucket->signature[i];
-			uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-			if (bucket_signature == 0) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				bucket->signature[i] = signature;
-				keycpy(bucket_key, key, f->key_mask);
-				memcpy(bucket_data, entry, f->entry_size);
-				*key_found = 0;
-				*entry_ptr = (void *) bucket_data;
-
-				return 0;
-			}
-		}
-
-	/* Bucket full: extend bucket */
-	if (f->stack_pos > 0) {
-		bucket_index = f->stack[--f->stack_pos];
-
-		bucket = (struct rte_bucket_4_32 *)
-			&f->memory[(f->n_buckets + bucket_index) *
-			f->bucket_size];
-		bucket_prev->next = bucket;
-		bucket_prev->next_valid = 1;
-
-		bucket->signature[0] = signature;
-		keycpy(&bucket->key[0], key, f->key_mask);
-		memcpy(&bucket->data[0], entry, f->entry_size);
-		*key_found = 0;
-		*entry_ptr = (void *) &bucket->data[0];
-		return 0;
-	}
-
-	return -ENOSPC;
-}
-
-static int
-rte_table_hash_entry_delete_key32_ext(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_32 *bucket0, *bucket, *bucket_prev;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket0 = (struct rte_bucket_4_32 *)
-		&f->memory[bucket_index * f->bucket_size];
-	signature |= RTE_BUCKET_ENTRY_VALID;
-
-	/* Key is present in the bucket */
-	for (bucket_prev = NULL, bucket = bucket0; bucket != NULL;
-		bucket_prev = bucket, bucket = bucket->next)
-		for (i = 0; i < 4; i++) {
-			uint64_t bucket_signature = bucket->signature[i];
-			uint8_t *bucket_key = (uint8_t *) &bucket->key[i];
-
-			if ((bucket_signature == signature) &&
-				(keycmp(bucket_key, key, f->key_mask) == 0)) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				bucket->signature[i] = 0;
-				*key_found = 1;
-				if (entry)
-					memcpy(entry, bucket_data, f->entry_size);
-
-				if ((bucket->signature[0] == 0) &&
-					(bucket->signature[1] == 0) &&
-					(bucket->signature[2] == 0) &&
-					(bucket->signature[3] == 0) &&
-					(bucket_prev != NULL)) {
-					bucket_prev->next = bucket->next;
-					bucket_prev->next_valid =
-						bucket->next_valid;
-
-					memset(bucket, 0,
-						sizeof(struct rte_bucket_4_32));
-					bucket_index = (((uint8_t *)bucket -
-						(uint8_t *)f->memory)/f->bucket_size) - f->n_buckets;
-					f->stack[f->stack_pos++] = bucket_index;
-				}
-
-				return 0;
-			}
-		}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-#define lookup_key32_cmp(key_in, bucket, pos, f)			\
-{								\
-	uint64_t xor[4][4], or[4], signature[4], k[4];		\
-								\
-	k[0] = key_in[0] & f->key_mask[0];				\
-	k[1] = key_in[1] & f->key_mask[1];				\
-	k[2] = key_in[2] & f->key_mask[2];				\
-	k[3] = key_in[3] & f->key_mask[3];				\
-								\
-	signature[0] = ((~bucket->signature[0]) & 1);		\
-	signature[1] = ((~bucket->signature[1]) & 1);		\
-	signature[2] = ((~bucket->signature[2]) & 1);		\
-	signature[3] = ((~bucket->signature[3]) & 1);		\
-								\
-	xor[0][0] = k[0] ^ bucket->key[0][0];			\
-	xor[0][1] = k[1] ^ bucket->key[0][1];			\
-	xor[0][2] = k[2] ^ bucket->key[0][2];			\
-	xor[0][3] = k[3] ^ bucket->key[0][3];			\
-								\
-	xor[1][0] = k[0] ^ bucket->key[1][0];			\
-	xor[1][1] = k[1] ^ bucket->key[1][1];			\
-	xor[1][2] = k[2] ^ bucket->key[1][2];			\
-	xor[1][3] = k[3] ^ bucket->key[1][3];			\
-								\
-	xor[2][0] = k[0] ^ bucket->key[2][0];			\
-	xor[2][1] = k[1] ^ bucket->key[2][1];			\
-	xor[2][2] = k[2] ^ bucket->key[2][2];			\
-	xor[2][3] = k[3] ^ bucket->key[2][3];			\
-								\
-	xor[3][0] = k[0] ^ bucket->key[3][0];			\
-	xor[3][1] = k[1] ^ bucket->key[3][1];			\
-	xor[3][2] = k[2] ^ bucket->key[3][2];			\
-	xor[3][3] = k[3] ^ bucket->key[3][3];			\
-								\
-	or[0] = xor[0][0] | xor[0][1] | xor[0][2] | xor[0][3] | signature[0];\
-	or[1] = xor[1][0] | xor[1][1] | xor[1][2] | xor[1][3] | signature[1];\
-	or[2] = xor[2][0] | xor[2][1] | xor[2][2] | xor[2][3] | signature[2];\
-	or[3] = xor[3][0] | xor[3][1] | xor[3][2] | xor[3][3] | signature[3];\
-								\
-	pos = 4;						\
-	if (or[0] == 0)						\
-		pos = 0;					\
-	if (or[1] == 0)						\
-		pos = 1;					\
-	if (or[2] == 0)						\
-		pos = 2;					\
-	if (or[3] == 0)						\
-		pos = 3;					\
-}
-
-#define lookup1_stage0(pkt0_index, mbuf0, pkts, pkts_mask, f)	\
-{								\
-	uint64_t pkt_mask;					\
-	uint32_t key_offset = f->key_offset;	\
-								\
-	pkt0_index = rte_ctz64(pkts_mask);		\
-	pkt_mask = 1LLU << pkt0_index;				\
-	pkts_mask &= ~pkt_mask;					\
-								\
-	mbuf0 = pkts[pkt0_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf0, key_offset));\
-}
-
-#define lookup1_stage1(mbuf1, bucket1, f)				\
-{								\
-	uint64_t *key;						\
-	uint64_t signature;					\
-	uint32_t bucket_index;					\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf1, f->key_offset);	\
-	signature = f->f_hash(key, f->key_mask, KEY_SIZE, f->seed);	\
-								\
-	bucket_index = signature & (f->n_buckets - 1);		\
-	bucket1 = (struct rte_bucket_4_32 *)			\
-		&f->memory[bucket_index * f->bucket_size];	\
-	rte_prefetch0(bucket1);					\
-	rte_prefetch0((void *)(((uintptr_t) bucket1) + RTE_CACHE_LINE_SIZE));\
-	rte_prefetch0((void *)(((uintptr_t) bucket1) + 2 * RTE_CACHE_LINE_SIZE));\
-}
-
-#define lookup1_stage2_lru(pkt2_index, mbuf2, bucket2,		\
-	pkts_mask_out, entries, f)				\
-{								\
-	void *a;						\
-	uint64_t pkt_mask;					\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf2, f->key_offset);\
-	lookup_key32_cmp(key, bucket2, pos, f);			\
-								\
-	pkt_mask = (bucket2->signature[pos] & 1LLU) << pkt2_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket2->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt2_index] = a;				\
-	lru_update(bucket2, pos);				\
-}
-
-#define lookup1_stage2_ext(pkt2_index, mbuf2, bucket2, pkts_mask_out,\
-	entries, buckets_mask, buckets, keys, f)		\
-{								\
-	struct rte_bucket_4_32 *bucket_next;			\
-	void *a;						\
-	uint64_t pkt_mask, bucket_mask;				\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf2, f->key_offset);\
-	lookup_key32_cmp(key, bucket2, pos, f);			\
-								\
-	pkt_mask = (bucket2->signature[pos] & 1LLU) << pkt2_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket2->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt2_index] = a;				\
-								\
-	bucket_mask = (~pkt_mask) & (bucket2->next_valid << pkt2_index);\
-	buckets_mask |= bucket_mask;				\
-	bucket_next = bucket2->next;				\
-	buckets[pkt2_index] = bucket_next;			\
-	keys[pkt2_index] = key;					\
-}
-
-#define lookup_grinder(pkt_index, buckets, keys, pkts_mask_out,	\
-	entries, buckets_mask, f)				\
-{								\
-	struct rte_bucket_4_32 *bucket, *bucket_next;		\
-	void *a;						\
-	uint64_t pkt_mask, bucket_mask;				\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	bucket = buckets[pkt_index];				\
-	key = keys[pkt_index];					\
-								\
-	lookup_key32_cmp(key, bucket, pos, f);			\
-								\
-	pkt_mask = (bucket->signature[pos] & 1LLU) << pkt_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt_index] = a;					\
-								\
-	bucket_mask = (~pkt_mask) & (bucket->next_valid << pkt_index);\
-	buckets_mask |= bucket_mask;				\
-	bucket_next = bucket->next;				\
-	rte_prefetch0(bucket_next);				\
-	rte_prefetch0((void *)(((uintptr_t) bucket_next) + RTE_CACHE_LINE_SIZE));\
-	rte_prefetch0((void *)(((uintptr_t) bucket_next) +	\
-		2 * RTE_CACHE_LINE_SIZE));				\
-	buckets[pkt_index] = bucket_next;			\
-	keys[pkt_index] = key;					\
-}
-
-#define lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01,\
-	pkts, pkts_mask, f)					\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	uint32_t key_offset = f->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-								\
-	mbuf00 = pkts[pkt00_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-								\
-	mbuf01 = pkts[pkt01_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,\
-	mbuf00, mbuf01, pkts, pkts_mask, f)			\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	uint32_t key_offset = f->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-								\
-	mbuf00 = pkts[pkt00_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));	\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	if (pkts_mask == 0)					\
-		pkt01_index = pkt00_index;			\
-								\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-								\
-	mbuf01 = pkts[pkt01_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));	\
-}
-
-#define lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f)	\
-{								\
-	uint64_t *key10, *key11;					\
-	uint64_t signature10, signature11;				\
-	uint32_t bucket10_index, bucket11_index;			\
-								\
-	key10 = RTE_MBUF_METADATA_UINT64_PTR(mbuf10, f->key_offset);	\
-	signature10 = f->f_hash(key10, f->key_mask,	 KEY_SIZE, f->seed); \
-								\
-	bucket10_index = signature10 & (f->n_buckets - 1);		\
-	bucket10 = (struct rte_bucket_4_32 *)			\
-		&f->memory[bucket10_index * f->bucket_size];	\
-	rte_prefetch0(bucket10);					\
-	rte_prefetch0((void *)(((uintptr_t) bucket10) + RTE_CACHE_LINE_SIZE));\
-	rte_prefetch0((void *)(((uintptr_t) bucket10) + 2 * RTE_CACHE_LINE_SIZE));\
-								\
-	key11 = RTE_MBUF_METADATA_UINT64_PTR(mbuf11, f->key_offset);	\
-	signature11 = f->f_hash(key11, f->key_mask, KEY_SIZE, f->seed);\
-								\
-	bucket11_index = signature11 & (f->n_buckets - 1);		\
-	bucket11 = (struct rte_bucket_4_32 *)			\
-		&f->memory[bucket11_index * f->bucket_size];	\
-	rte_prefetch0(bucket11);					\
-	rte_prefetch0((void *)(((uintptr_t) bucket11) + RTE_CACHE_LINE_SIZE));\
-	rte_prefetch0((void *)(((uintptr_t) bucket11) + 2 * RTE_CACHE_LINE_SIZE));\
-}
-
-#define lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,\
-	bucket20, bucket21, pkts_mask_out, entries, f)		\
-{								\
-	void *a20, *a21;					\
-	uint64_t pkt20_mask, pkt21_mask;			\
-	uint64_t *key20, *key21;				\
-	uint32_t pos20, pos21;					\
-								\
-	key20 = RTE_MBUF_METADATA_UINT64_PTR(mbuf20, f->key_offset);\
-	key21 = RTE_MBUF_METADATA_UINT64_PTR(mbuf21, f->key_offset);\
-								\
-	lookup_key32_cmp(key20, bucket20, pos20, f);		\
-	lookup_key32_cmp(key21, bucket21, pos21, f);		\
-								\
-	pkt20_mask = (bucket20->signature[pos20] & 1LLU) << pkt20_index;\
-	pkt21_mask = (bucket21->signature[pos21] & 1LLU) << pkt21_index;\
-	pkts_mask_out |= pkt20_mask | pkt21_mask;		\
-								\
-	a20 = (void *) &bucket20->data[pos20 * f->entry_size];	\
-	a21 = (void *) &bucket21->data[pos21 * f->entry_size];	\
-	rte_prefetch0(a20);					\
-	rte_prefetch0(a21);					\
-	entries[pkt20_index] = a20;				\
-	entries[pkt21_index] = a21;				\
-	lru_update(bucket20, pos20);				\
-	lru_update(bucket21, pos21);				\
-}
-
-#define lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21, bucket20, \
-	bucket21, pkts_mask_out, entries, buckets_mask, buckets, keys, f)\
-{								\
-	struct rte_bucket_4_32 *bucket20_next, *bucket21_next;	\
-	void *a20, *a21;					\
-	uint64_t pkt20_mask, pkt21_mask, bucket20_mask, bucket21_mask;\
-	uint64_t *key20, *key21;				\
-	uint32_t pos20, pos21;					\
-								\
-	key20 = RTE_MBUF_METADATA_UINT64_PTR(mbuf20, f->key_offset);\
-	key21 = RTE_MBUF_METADATA_UINT64_PTR(mbuf21, f->key_offset);\
-								\
-	lookup_key32_cmp(key20, bucket20, pos20, f);		\
-	lookup_key32_cmp(key21, bucket21, pos21, f);		\
-								\
-	pkt20_mask = (bucket20->signature[pos20] & 1LLU) << pkt20_index;\
-	pkt21_mask = (bucket21->signature[pos21] & 1LLU) << pkt21_index;\
-	pkts_mask_out |= pkt20_mask | pkt21_mask;		\
-								\
-	a20 = (void *) &bucket20->data[pos20 * f->entry_size];	\
-	a21 = (void *) &bucket21->data[pos21 * f->entry_size];	\
-	rte_prefetch0(a20);					\
-	rte_prefetch0(a21);					\
-	entries[pkt20_index] = a20;				\
-	entries[pkt21_index] = a21;				\
-								\
-	bucket20_mask = (~pkt20_mask) & (bucket20->next_valid << pkt20_index);\
-	bucket21_mask = (~pkt21_mask) & (bucket21->next_valid << pkt21_index);\
-	buckets_mask |= bucket20_mask | bucket21_mask;		\
-	bucket20_next = bucket20->next;				\
-	bucket21_next = bucket21->next;				\
-	buckets[pkt20_index] = bucket20_next;			\
-	buckets[pkt21_index] = bucket21_next;			\
-	keys[pkt20_index] = key20;				\
-	keys[pkt21_index] = key21;				\
-}
-
-static int
-rte_table_hash_lookup_key32_lru(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *f = (struct rte_table_hash *) table;
-	struct rte_bucket_4_32 *bucket10, *bucket11, *bucket20, *bucket21;
-	struct rte_mbuf *mbuf00, *mbuf01, *mbuf10, *mbuf11, *mbuf20, *mbuf21;
-	uint32_t pkt00_index, pkt01_index, pkt10_index;
-	uint32_t pkt11_index, pkt20_index, pkt21_index;
-	uint64_t pkts_mask_out = 0;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_HASH_KEY32_STATS_PKTS_IN_ADD(f, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 5 packets */
-	if (rte_popcount64(pkts_mask) < 5) {
-		for ( ; pkts_mask; ) {
-			struct rte_bucket_4_32 *bucket;
-			struct rte_mbuf *mbuf;
-			uint32_t pkt_index;
-
-			lookup1_stage0(pkt_index, mbuf, pkts, pkts_mask, f);
-			lookup1_stage1(mbuf, bucket, f);
-			lookup1_stage2_lru(pkt_index, mbuf, bucket,
-					pkts_mask_out, entries, f);
-		}
-
-		*lookup_hit_mask = pkts_mask_out;
-		RTE_TABLE_HASH_KEY32_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in - rte_popcount64(pkts_mask_out));
-		return 0;
-	}
-
-	/*
-	 * Pipeline fill
-	 *
-	 */
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline feed */
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/*
-	 * Pipeline run
-	 *
-	 */
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		bucket20 = bucket10;
-		bucket21 = bucket11;
-		mbuf20 = mbuf10;
-		mbuf21 = mbuf11;
-		mbuf10 = mbuf00;
-		mbuf11 = mbuf01;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,
-			mbuf00, mbuf01, pkts, pkts_mask, f);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2_lru(pkt20_index, pkt21_index,
-			mbuf20, mbuf21, bucket20, bucket21, pkts_mask_out,
-			entries, f);
-	}
-
-	/*
-	 * Pipeline flush
-	 *
-	 */
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_lru(pkt20_index, pkt21_index,
-		mbuf20, mbuf21, bucket20, bucket21, pkts_mask_out, entries, f);
-
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_lru(pkt20_index, pkt21_index,
-		mbuf20, mbuf21, bucket20, bucket21, pkts_mask_out, entries, f);
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_KEY32_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in - rte_popcount64(pkts_mask_out));
-	return 0;
-} /* rte_table_hash_lookup_key32_lru() */
-
-static int
-rte_table_hash_lookup_key32_ext(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *f = (struct rte_table_hash *) table;
-	struct rte_bucket_4_32 *bucket10, *bucket11, *bucket20, *bucket21;
-	struct rte_mbuf *mbuf00, *mbuf01, *mbuf10, *mbuf11, *mbuf20, *mbuf21;
-	uint32_t pkt00_index, pkt01_index, pkt10_index;
-	uint32_t pkt11_index, pkt20_index, pkt21_index;
-	uint64_t pkts_mask_out = 0, buckets_mask = 0;
-	struct rte_bucket_4_32 *buckets[RTE_PORT_IN_BURST_SIZE_MAX];
-	uint64_t *keys[RTE_PORT_IN_BURST_SIZE_MAX];
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_HASH_KEY32_STATS_PKTS_IN_ADD(f, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 5 packets */
-	if (rte_popcount64(pkts_mask) < 5) {
-		for ( ; pkts_mask; ) {
-			struct rte_bucket_4_32 *bucket;
-			struct rte_mbuf *mbuf;
-			uint32_t pkt_index;
-
-			lookup1_stage0(pkt_index, mbuf, pkts, pkts_mask, f);
-			lookup1_stage1(mbuf, bucket, f);
-			lookup1_stage2_ext(pkt_index, mbuf, bucket,
-				pkts_mask_out, entries, buckets_mask, buckets,
-				keys, f);
-		}
-
-		goto grind_next_buckets;
-	}
-
-	/*
-	 * Pipeline fill
-	 *
-	 */
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline feed */
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/*
-	 * Pipeline run
-	 *
-	 */
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		bucket20 = bucket10;
-		bucket21 = bucket11;
-		mbuf20 = mbuf10;
-		mbuf21 = mbuf11;
-		mbuf10 = mbuf00;
-		mbuf11 = mbuf01;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,
-			mbuf00, mbuf01, pkts, pkts_mask, f);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-			bucket20, bucket21, pkts_mask_out, entries,
-			buckets_mask, buckets, keys, f);
-	}
-
-	/*
-	 * Pipeline flush
-	 *
-	 */
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries,
-		buckets_mask, buckets, keys, f);
-
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries,
-		buckets_mask, buckets, keys, f);
-
-grind_next_buckets:
-	/* Grind next buckets */
-	for ( ; buckets_mask; ) {
-		uint64_t buckets_mask_next = 0;
-
-		for ( ; buckets_mask; ) {
-			uint32_t pkt_index;
-
-			pkt_index = rte_ctz64(buckets_mask);
-			buckets_mask &= ~(1LLU << pkt_index);
-
-			lookup_grinder(pkt_index, buckets, keys, pkts_mask_out,
-				entries, buckets_mask_next, f);
-		}
-
-		buckets_mask = buckets_mask_next;
-	}
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_KEY32_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in - rte_popcount64(pkts_mask_out));
-	return 0;
-} /* rte_table_hash_lookup_key32_ext() */
-
-static int
-rte_table_hash_key32_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_hash *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_hash_key32_lru_ops)
-struct rte_table_ops rte_table_hash_key32_lru_ops = {
-	.f_create = rte_table_hash_create_key32_lru,
-	.f_free = rte_table_hash_free_key32_lru,
-	.f_add = rte_table_hash_entry_add_key32_lru,
-	.f_delete = rte_table_hash_entry_delete_key32_lru,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_lookup_key32_lru,
-	.f_stats = rte_table_hash_key32_stats_read,
-};
-
-RTE_EXPORT_SYMBOL(rte_table_hash_key32_ext_ops)
-struct rte_table_ops rte_table_hash_key32_ext_ops = {
-	.f_create = rte_table_hash_create_key32_ext,
-	.f_free = rte_table_hash_free_key32_ext,
-	.f_add = rte_table_hash_entry_add_key32_ext,
-	.f_delete = rte_table_hash_entry_delete_key32_ext,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_lookup_key32_ext,
-	.f_stats = rte_table_hash_key32_stats_read,
-};
diff --git a/lib/table/rte_table_hash_key8.c b/lib/table/rte_table_hash_key8.c
deleted file mode 100644
index 5e9dcf10ee..0000000000
--- a/lib/table/rte_table_hash_key8.c
+++ /dev/null
@@ -1,1157 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2017 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_hash.h"
-#include "rte_lru.h"
-
-#include "table_log.h"
-
-#define KEY_SIZE						8
-
-#define KEYS_PER_BUCKET					4
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_HASH_KEY8_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_HASH_KEY8_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_HASH_KEY8_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_HASH_KEY8_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-#ifdef RTE_ARCH_64
-struct rte_bucket_4_8 {
-	/* Cache line 0 */
-	uint64_t signature;
-	uint64_t lru_list;
-	struct rte_bucket_4_8 *next;
-	uint64_t next_valid;
-
-	uint64_t key[4];
-
-	/* Cache line 1 */
-	uint8_t data[];
-};
-#else
-struct rte_bucket_4_8 {
-	/* Cache line 0 */
-	uint64_t signature;
-	uint64_t lru_list;
-	struct rte_bucket_4_8 *next;
-	uint32_t pad;
-	uint64_t next_valid;
-
-	uint64_t key[4];
-
-	/* Cache line 1 */
-	uint8_t data[];
-};
-#endif
-
-struct rte_table_hash {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t n_buckets;
-	uint32_t key_size;
-	uint32_t entry_size;
-	uint32_t bucket_size;
-	uint32_t key_offset;
-	uint64_t key_mask;
-	rte_table_hash_op_hash f_hash;
-	uint64_t seed;
-
-	/* Extendible buckets */
-	uint32_t n_buckets_ext;
-	uint32_t stack_pos;
-	uint32_t *stack;
-
-	/* Lookup table */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t memory[];
-};
-
-static int
-keycmp(void *a, void *b, void *b_mask)
-{
-	uint64_t *a64 = a, *b64 = b, *b_mask64 = b_mask;
-
-	return a64[0] != (b64[0] & b_mask64[0]);
-}
-
-static void
-keycpy(void *dst, void *src, void *src_mask)
-{
-	uint64_t *dst64 = dst, *src64 = src, *src_mask64 = src_mask;
-
-	dst64[0] = src64[0] & src_mask64[0];
-}
-
-static int
-check_params_create(struct rte_table_hash_params *params)
-{
-	/* name */
-	if (params->name == NULL) {
-		TABLE_LOG(ERR, "%s: name invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* key_size */
-	if (params->key_size != KEY_SIZE) {
-		TABLE_LOG(ERR, "%s: key_size invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* n_keys */
-	if (params->n_keys == 0) {
-		TABLE_LOG(ERR, "%s: n_keys is zero", __func__);
-		return -EINVAL;
-	}
-
-	/* n_buckets */
-	if ((params->n_buckets == 0) ||
-		(!rte_is_power_of_2(params->n_buckets))) {
-		TABLE_LOG(ERR, "%s: n_buckets invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* f_hash */
-	if (params->f_hash == NULL) {
-		TABLE_LOG(ERR, "%s: f_hash function pointer is NULL",
-			__func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void *
-rte_table_hash_create_key8_lru(void *params, int socket_id, uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *f;
-	uint64_t bucket_size, total_size;
-	uint32_t n_buckets, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		((sizeof(struct rte_bucket_4_8) % 64) != 0))
-		return NULL;
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of buckets (n_buckets) so that there a chance
-	 * to store n_keys keys in the table.
-	 *
-	 * Note: Since the buckets do not get extended, it is not possible to
-	 * guarantee that n_keys keys can be stored in the table at any time. In the
-	 * worst case scenario when all the n_keys fall into the same bucket, only
-	 * a maximum of KEYS_PER_BUCKET keys will be stored in the table. This case
-	 * defeats the purpose of the hash table. It indicates unsuitable f_hash or
-	 * n_keys to n_buckets ratio.
-	 *
-	 * MIN(n_buckets) = (n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET
-	 */
-	n_buckets = rte_align32pow2(
-		(p->n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET);
-	n_buckets = RTE_MAX(n_buckets, p->n_buckets);
-
-	/* Memory allocation */
-	bucket_size = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_bucket_4_8) +
-		KEYS_PER_BUCKET * entry_size);
-	total_size = sizeof(struct rte_table_hash) + n_buckets * bucket_size;
-
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes"
-			" for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	f = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes"
-			" for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	TABLE_LOG(INFO, "%s: Hash table %s memory footprint "
-		"is %" PRIu64 " bytes",
-		__func__, p->name, total_size);
-
-	/* Memory initialization */
-	f->n_buckets = n_buckets;
-	f->key_size = KEY_SIZE;
-	f->entry_size = entry_size;
-	f->bucket_size = bucket_size;
-	f->key_offset = p->key_offset;
-	f->f_hash = p->f_hash;
-	f->seed = p->seed;
-
-	if (p->key_mask != NULL)
-		f->key_mask = ((uint64_t *)p->key_mask)[0];
-	else
-		f->key_mask = 0xFFFFFFFFFFFFFFFFLLU;
-
-	for (i = 0; i < n_buckets; i++) {
-		struct rte_bucket_4_8 *bucket;
-
-		bucket = (struct rte_bucket_4_8 *) &f->memory[i *
-			f->bucket_size];
-		bucket->lru_list = 0x0000000100020003LLU;
-	}
-
-	return f;
-}
-
-static int
-rte_table_hash_free_key8_lru(void *table)
-{
-	struct rte_table_hash *f = table;
-
-	/* Check input parameters */
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	rte_free(f);
-	return 0;
-}
-
-static int
-rte_table_hash_entry_add_key8_lru(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_8 *bucket;
-	uint64_t signature, mask, pos;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, &f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket = (struct rte_bucket_4_8 *)
-		&f->memory[bucket_index * f->bucket_size];
-
-	/* Key is present in the bucket */
-	for (i = 0, mask = 1LLU; i < 4; i++, mask <<= 1) {
-		uint64_t bucket_signature = bucket->signature;
-		uint64_t *bucket_key = &bucket->key[i];
-
-		if ((bucket_signature & mask) &&
-			(keycmp(bucket_key, key, &f->key_mask) == 0)) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			memcpy(bucket_data, entry, f->entry_size);
-			lru_update(bucket, i);
-			*key_found = 1;
-			*entry_ptr = (void *) bucket_data;
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	for (i = 0, mask = 1LLU; i < 4; i++, mask <<= 1) {
-		uint64_t bucket_signature = bucket->signature;
-
-		if ((bucket_signature & mask) == 0) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			bucket->signature |= mask;
-			keycpy(&bucket->key[i], key, &f->key_mask);
-			memcpy(bucket_data, entry, f->entry_size);
-			lru_update(bucket, i);
-			*key_found = 0;
-			*entry_ptr = (void *) bucket_data;
-
-			return 0;
-		}
-	}
-
-	/* Bucket full: replace LRU entry */
-	pos = lru_pos(bucket);
-	keycpy(&bucket->key[pos], key, &f->key_mask);
-	memcpy(&bucket->data[pos * f->entry_size], entry, f->entry_size);
-	lru_update(bucket, pos);
-	*key_found = 0;
-	*entry_ptr = (void *) &bucket->data[pos * f->entry_size];
-
-	return 0;
-}
-
-static int
-rte_table_hash_entry_delete_key8_lru(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_8 *bucket;
-	uint64_t signature, mask;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, &f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket = (struct rte_bucket_4_8 *)
-		&f->memory[bucket_index * f->bucket_size];
-
-	/* Key is present in the bucket */
-	for (i = 0, mask = 1LLU; i < 4; i++, mask <<= 1) {
-		uint64_t bucket_signature = bucket->signature;
-		uint64_t *bucket_key = &bucket->key[i];
-
-		if ((bucket_signature & mask) &&
-			(keycmp(bucket_key, key, &f->key_mask) == 0)) {
-			uint8_t *bucket_data = &bucket->data[i * f->entry_size];
-
-			bucket->signature &= ~mask;
-			*key_found = 1;
-			if (entry)
-				memcpy(entry, bucket_data, f->entry_size);
-
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-static void *
-rte_table_hash_create_key8_ext(void *params, int socket_id, uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *f;
-	uint64_t bucket_size, stack_size, total_size;
-	uint32_t n_buckets_ext, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		((sizeof(struct rte_bucket_4_8) % 64) != 0))
-		return NULL;
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of bucket extensions (n_buckets_ext) so that
-	 * it is guaranteed that n_keys keys can be stored in the table at any time.
-	 *
-	 * The worst case scenario takes place when all the n_keys keys fall into
-	 * the same bucket. Actually, due to the KEYS_PER_BUCKET scheme, the worst
-	 * case takes place when (n_keys - KEYS_PER_BUCKET + 1) keys fall into the
-	 * same bucket, while the remaining (KEYS_PER_BUCKET - 1) keys each fall
-	 * into a different bucket. This case defeats the purpose of the hash table.
-	 * It indicates unsuitable f_hash or n_keys to n_buckets ratio.
-	 *
-	 * n_buckets_ext = n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1
-	 */
-	n_buckets_ext = p->n_keys / KEYS_PER_BUCKET + KEYS_PER_BUCKET - 1;
-
-	/* Memory allocation */
-	bucket_size = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_bucket_4_8) +
-		KEYS_PER_BUCKET * entry_size);
-	stack_size = RTE_CACHE_LINE_ROUNDUP(n_buckets_ext * sizeof(uint32_t));
-	total_size = sizeof(struct rte_table_hash) +
-		(p->n_buckets + n_buckets_ext) * bucket_size + stack_size;
-
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR, "%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	f = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (f == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %" PRIu64 " bytes "
-			"for hash table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-	TABLE_LOG(INFO, "%s: Hash table %s memory footprint "
-		"is %" PRIu64 " bytes",
-		__func__, p->name, total_size);
-
-	/* Memory initialization */
-	f->n_buckets = p->n_buckets;
-	f->key_size = KEY_SIZE;
-	f->entry_size = entry_size;
-	f->bucket_size = bucket_size;
-	f->key_offset = p->key_offset;
-	f->f_hash = p->f_hash;
-	f->seed = p->seed;
-
-	f->n_buckets_ext = n_buckets_ext;
-	f->stack_pos = n_buckets_ext;
-	f->stack = (uint32_t *)
-		&f->memory[(p->n_buckets + n_buckets_ext) * f->bucket_size];
-
-	if (p->key_mask != NULL)
-		f->key_mask = ((uint64_t *)p->key_mask)[0];
-	else
-		f->key_mask = 0xFFFFFFFFFFFFFFFFLLU;
-
-	for (i = 0; i < n_buckets_ext; i++)
-		f->stack[i] = i;
-
-	return f;
-}
-
-static int
-rte_table_hash_free_key8_ext(void *table)
-{
-	struct rte_table_hash *f = table;
-
-	/* Check input parameters */
-	if (f == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	rte_free(f);
-	return 0;
-}
-
-static int
-rte_table_hash_entry_add_key8_ext(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_8 *bucket0, *bucket, *bucket_prev;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, &f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket0 = (struct rte_bucket_4_8 *)
-		&f->memory[bucket_index * f->bucket_size];
-
-	/* Key is present in the bucket */
-	for (bucket = bucket0; bucket != NULL; bucket = bucket->next) {
-		uint64_t mask;
-
-		for (i = 0, mask = 1LLU; i < 4; i++, mask <<= 1) {
-			uint64_t bucket_signature = bucket->signature;
-			uint64_t *bucket_key = &bucket->key[i];
-
-			if ((bucket_signature & mask) &&
-				(keycmp(bucket_key, key, &f->key_mask) == 0)) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				memcpy(bucket_data, entry, f->entry_size);
-				*key_found = 1;
-				*entry_ptr = (void *) bucket_data;
-				return 0;
-			}
-		}
-	}
-
-	/* Key is not present in the bucket */
-	for (bucket_prev = NULL, bucket = bucket0;
-		bucket != NULL; bucket_prev = bucket, bucket = bucket->next) {
-		uint64_t mask;
-
-		for (i = 0, mask = 1LLU; i < 4; i++, mask <<= 1) {
-			uint64_t bucket_signature = bucket->signature;
-
-			if ((bucket_signature & mask) == 0) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				bucket->signature |= mask;
-				keycpy(&bucket->key[i], key, &f->key_mask);
-				memcpy(bucket_data, entry, f->entry_size);
-				*key_found = 0;
-				*entry_ptr = (void *) bucket_data;
-
-				return 0;
-			}
-		}
-	}
-
-	/* Bucket full: extend bucket */
-	if (f->stack_pos > 0) {
-		bucket_index = f->stack[--f->stack_pos];
-
-		bucket = (struct rte_bucket_4_8 *) &f->memory[(f->n_buckets +
-			bucket_index) * f->bucket_size];
-		bucket_prev->next = bucket;
-		bucket_prev->next_valid = 1;
-
-		bucket->signature = 1;
-		keycpy(&bucket->key[0], key, &f->key_mask);
-		memcpy(&bucket->data[0], entry, f->entry_size);
-		*key_found = 0;
-		*entry_ptr = (void *) &bucket->data[0];
-		return 0;
-	}
-
-	return -ENOSPC;
-}
-
-static int
-rte_table_hash_entry_delete_key8_ext(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_hash *f = table;
-	struct rte_bucket_4_8 *bucket0, *bucket, *bucket_prev;
-	uint64_t signature;
-	uint32_t bucket_index, i;
-
-	signature = f->f_hash(key, &f->key_mask, f->key_size, f->seed);
-	bucket_index = signature & (f->n_buckets - 1);
-	bucket0 = (struct rte_bucket_4_8 *)
-		&f->memory[bucket_index * f->bucket_size];
-
-	/* Key is present in the bucket */
-	for (bucket_prev = NULL, bucket = bucket0; bucket != NULL;
-		bucket_prev = bucket, bucket = bucket->next) {
-		uint64_t mask;
-
-		for (i = 0, mask = 1LLU; i < 4; i++, mask <<= 1) {
-			uint64_t bucket_signature = bucket->signature;
-			uint64_t *bucket_key = &bucket->key[i];
-
-			if ((bucket_signature & mask) &&
-				(keycmp(bucket_key, key, &f->key_mask) == 0)) {
-				uint8_t *bucket_data = &bucket->data[i *
-					f->entry_size];
-
-				bucket->signature &= ~mask;
-				*key_found = 1;
-				if (entry)
-					memcpy(entry, bucket_data,
-						f->entry_size);
-
-				if ((bucket->signature == 0) &&
-				    (bucket_prev != NULL)) {
-					bucket_prev->next = bucket->next;
-					bucket_prev->next_valid =
-						bucket->next_valid;
-
-					memset(bucket, 0,
-						sizeof(struct rte_bucket_4_8));
-					bucket_index = (((uint8_t *)bucket -
-						(uint8_t *)f->memory)/f->bucket_size) - f->n_buckets;
-					f->stack[f->stack_pos++] = bucket_index;
-				}
-
-				return 0;
-			}
-		}
-	}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-#define lookup_key8_cmp(key_in, bucket, pos, f)			\
-{								\
-	uint64_t xor[4], signature, k;				\
-								\
-	signature = ~bucket->signature;				\
-								\
-	k = key_in[0] & f->key_mask;				\
-	xor[0] = (k ^ bucket->key[0]) | (signature & 1);		\
-	xor[1] = (k ^ bucket->key[1]) | (signature & 2);		\
-	xor[2] = (k ^ bucket->key[2]) | (signature & 4);		\
-	xor[3] = (k ^ bucket->key[3]) | (signature & 8);		\
-								\
-	pos = 4;						\
-	if (xor[0] == 0)					\
-		pos = 0;					\
-	if (xor[1] == 0)					\
-		pos = 1;					\
-	if (xor[2] == 0)					\
-		pos = 2;					\
-	if (xor[3] == 0)					\
-		pos = 3;					\
-}
-
-#define lookup1_stage0(pkt0_index, mbuf0, pkts, pkts_mask, f)	\
-{								\
-	uint64_t pkt_mask;					\
-	uint32_t key_offset = f->key_offset;\
-								\
-	pkt0_index = rte_ctz64(pkts_mask);		\
-	pkt_mask = 1LLU << pkt0_index;				\
-	pkts_mask &= ~pkt_mask;					\
-								\
-	mbuf0 = pkts[pkt0_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf0, key_offset));	\
-}
-
-#define lookup1_stage1(mbuf1, bucket1, f)			\
-{								\
-	uint64_t *key;						\
-	uint64_t signature;					\
-	uint32_t bucket_index;					\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf1, f->key_offset);\
-	signature = f->f_hash(key, &f->key_mask, KEY_SIZE, f->seed);	\
-	bucket_index = signature & (f->n_buckets - 1);		\
-	bucket1 = (struct rte_bucket_4_8 *)			\
-		&f->memory[bucket_index * f->bucket_size];	\
-	rte_prefetch0(bucket1);					\
-}
-
-#define lookup1_stage2_lru(pkt2_index, mbuf2, bucket2,		\
-	pkts_mask_out, entries, f)				\
-{								\
-	void *a;						\
-	uint64_t pkt_mask;					\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf2, f->key_offset);\
-	lookup_key8_cmp(key, bucket2, pos, f);	\
-								\
-	pkt_mask = ((bucket2->signature >> pos) & 1LLU) << pkt2_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket2->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt2_index] = a;				\
-	lru_update(bucket2, pos);				\
-}
-
-#define lookup1_stage2_ext(pkt2_index, mbuf2, bucket2, pkts_mask_out,\
-	entries, buckets_mask, buckets, keys, f)		\
-{								\
-	struct rte_bucket_4_8 *bucket_next;			\
-	void *a;						\
-	uint64_t pkt_mask, bucket_mask;				\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	key = RTE_MBUF_METADATA_UINT64_PTR(mbuf2, f->key_offset);\
-	lookup_key8_cmp(key, bucket2, pos, f);	\
-								\
-	pkt_mask = ((bucket2->signature >> pos) & 1LLU) << pkt2_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket2->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt2_index] = a;				\
-								\
-	bucket_mask = (~pkt_mask) & (bucket2->next_valid << pkt2_index);\
-	buckets_mask |= bucket_mask;				\
-	bucket_next = bucket2->next;				\
-	buckets[pkt2_index] = bucket_next;			\
-	keys[pkt2_index] = key;					\
-}
-
-#define lookup_grinder(pkt_index, buckets, keys, pkts_mask_out, entries,\
-	buckets_mask, f)					\
-{								\
-	struct rte_bucket_4_8 *bucket, *bucket_next;		\
-	void *a;						\
-	uint64_t pkt_mask, bucket_mask;				\
-	uint64_t *key;						\
-	uint32_t pos;						\
-								\
-	bucket = buckets[pkt_index];				\
-	key = keys[pkt_index];					\
-	lookup_key8_cmp(key, bucket, pos, f);			\
-								\
-	pkt_mask = ((bucket->signature >> pos) & 1LLU) << pkt_index;\
-	pkts_mask_out |= pkt_mask;				\
-								\
-	a = (void *) &bucket->data[pos * f->entry_size];	\
-	rte_prefetch0(a);					\
-	entries[pkt_index] = a;					\
-								\
-	bucket_mask = (~pkt_mask) & (bucket->next_valid << pkt_index);\
-	buckets_mask |= bucket_mask;				\
-	bucket_next = bucket->next;				\
-	rte_prefetch0(bucket_next);				\
-	buckets[pkt_index] = bucket_next;			\
-	keys[pkt_index] = key;					\
-}
-
-#define lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01,\
-	pkts, pkts_mask, f)					\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	uint32_t key_offset = f->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-								\
-	mbuf00 = pkts[pkt00_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-								\
-	mbuf01 = pkts[pkt01_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,\
-	mbuf00, mbuf01, pkts, pkts_mask, f)			\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	uint32_t key_offset = f->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-								\
-	mbuf00 = pkts[pkt00_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	if (pkts_mask == 0)					\
-		pkt01_index = pkt00_index;			\
-								\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-								\
-	mbuf01 = pkts[pkt01_index];				\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f)\
-{								\
-	uint64_t *key10, *key11;				\
-	uint64_t signature10, signature11;			\
-	uint32_t bucket10_index, bucket11_index;		\
-	rte_table_hash_op_hash f_hash = f->f_hash;		\
-	uint64_t seed = f->seed;				\
-	uint32_t key_offset = f->key_offset;			\
-								\
-	key10 = RTE_MBUF_METADATA_UINT64_PTR(mbuf10, key_offset);\
-	key11 = RTE_MBUF_METADATA_UINT64_PTR(mbuf11, key_offset);\
-								\
-	signature10 = f_hash(key10, &f->key_mask, KEY_SIZE, seed);	\
-	bucket10_index = signature10 & (f->n_buckets - 1);	\
-	bucket10 = (struct rte_bucket_4_8 *)			\
-		&f->memory[bucket10_index * f->bucket_size];	\
-	rte_prefetch0(bucket10);				\
-								\
-	signature11 = f_hash(key11, &f->key_mask, KEY_SIZE, seed);	\
-	bucket11_index = signature11 & (f->n_buckets - 1);	\
-	bucket11 = (struct rte_bucket_4_8 *)			\
-		&f->memory[bucket11_index * f->bucket_size];	\
-	rte_prefetch0(bucket11);				\
-}
-
-#define lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,\
-	bucket20, bucket21, pkts_mask_out, entries, f)		\
-{								\
-	void *a20, *a21;					\
-	uint64_t pkt20_mask, pkt21_mask;			\
-	uint64_t *key20, *key21;				\
-	uint32_t pos20, pos21;					\
-								\
-	key20 = RTE_MBUF_METADATA_UINT64_PTR(mbuf20, f->key_offset);\
-	key21 = RTE_MBUF_METADATA_UINT64_PTR(mbuf21, f->key_offset);\
-								\
-	lookup_key8_cmp(key20, bucket20, pos20, f);			\
-	lookup_key8_cmp(key21, bucket21, pos21, f);			\
-								\
-	pkt20_mask = ((bucket20->signature >> pos20) & 1LLU) << pkt20_index;\
-	pkt21_mask = ((bucket21->signature >> pos21) & 1LLU) << pkt21_index;\
-	pkts_mask_out |= pkt20_mask | pkt21_mask;		\
-								\
-	a20 = (void *) &bucket20->data[pos20 * f->entry_size];	\
-	a21 = (void *) &bucket21->data[pos21 * f->entry_size];	\
-	rte_prefetch0(a20);					\
-	rte_prefetch0(a21);					\
-	entries[pkt20_index] = a20;				\
-	entries[pkt21_index] = a21;				\
-	lru_update(bucket20, pos20);				\
-	lru_update(bucket21, pos21);				\
-}
-
-#define lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21, bucket20, \
-	bucket21, pkts_mask_out, entries, buckets_mask, buckets, keys, f)\
-{								\
-	struct rte_bucket_4_8 *bucket20_next, *bucket21_next;	\
-	void *a20, *a21;					\
-	uint64_t pkt20_mask, pkt21_mask, bucket20_mask, bucket21_mask;\
-	uint64_t *key20, *key21;				\
-	uint32_t pos20, pos21;					\
-								\
-	key20 = RTE_MBUF_METADATA_UINT64_PTR(mbuf20, f->key_offset);\
-	key21 = RTE_MBUF_METADATA_UINT64_PTR(mbuf21, f->key_offset);\
-								\
-	lookup_key8_cmp(key20, bucket20, pos20, f);			\
-	lookup_key8_cmp(key21, bucket21, pos21, f);			\
-								\
-	pkt20_mask = ((bucket20->signature >> pos20) & 1LLU) << pkt20_index;\
-	pkt21_mask = ((bucket21->signature >> pos21) & 1LLU) << pkt21_index;\
-	pkts_mask_out |= pkt20_mask | pkt21_mask;		\
-								\
-	a20 = (void *) &bucket20->data[pos20 * f->entry_size];	\
-	a21 = (void *) &bucket21->data[pos21 * f->entry_size];	\
-	rte_prefetch0(a20);					\
-	rte_prefetch0(a21);					\
-	entries[pkt20_index] = a20;				\
-	entries[pkt21_index] = a21;				\
-								\
-	bucket20_mask = (~pkt20_mask) & (bucket20->next_valid << pkt20_index);\
-	bucket21_mask = (~pkt21_mask) & (bucket21->next_valid << pkt21_index);\
-	buckets_mask |= bucket20_mask | bucket21_mask;		\
-	bucket20_next = bucket20->next;				\
-	bucket21_next = bucket21->next;				\
-	buckets[pkt20_index] = bucket20_next;			\
-	buckets[pkt21_index] = bucket21_next;			\
-	keys[pkt20_index] = key20;				\
-	keys[pkt21_index] = key21;				\
-}
-
-static int
-rte_table_hash_lookup_key8_lru(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *f = (struct rte_table_hash *) table;
-	struct rte_bucket_4_8 *bucket10, *bucket11, *bucket20, *bucket21;
-	struct rte_mbuf *mbuf00, *mbuf01, *mbuf10, *mbuf11, *mbuf20, *mbuf21;
-	uint32_t pkt00_index, pkt01_index, pkt10_index;
-	uint32_t pkt11_index, pkt20_index, pkt21_index;
-	uint64_t pkts_mask_out = 0;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_HASH_KEY8_STATS_PKTS_IN_ADD(f, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 5 packets */
-	if (rte_popcount64(pkts_mask) < 5) {
-		for ( ; pkts_mask; ) {
-			struct rte_bucket_4_8 *bucket;
-			struct rte_mbuf *mbuf;
-			uint32_t pkt_index;
-
-			lookup1_stage0(pkt_index, mbuf, pkts, pkts_mask, f);
-			lookup1_stage1(mbuf, bucket, f);
-			lookup1_stage2_lru(pkt_index, mbuf, bucket,
-				pkts_mask_out, entries, f);
-		}
-
-		*lookup_hit_mask = pkts_mask_out;
-		RTE_TABLE_HASH_KEY8_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in - rte_popcount64(pkts_mask_out));
-		return 0;
-	}
-
-	/*
-	 * Pipeline fill
-	 *
-	 */
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline feed */
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/*
-	 * Pipeline run
-	 *
-	 */
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		bucket20 = bucket10;
-		bucket21 = bucket11;
-		mbuf20 = mbuf10;
-		mbuf21 = mbuf11;
-		mbuf10 = mbuf00;
-		mbuf11 = mbuf01;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,
-			mbuf00, mbuf01, pkts, pkts_mask, f);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,
-			bucket20, bucket21, pkts_mask_out, entries, f);
-	}
-
-	/*
-	 * Pipeline flush
-	 *
-	 */
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries, f);
-
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_lru(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries, f);
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_KEY8_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in - rte_popcount64(pkts_mask_out));
-	return 0;
-} /* lookup LRU */
-
-static int
-rte_table_hash_lookup_key8_ext(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *f = (struct rte_table_hash *) table;
-	struct rte_bucket_4_8 *bucket10, *bucket11, *bucket20, *bucket21;
-	struct rte_mbuf *mbuf00, *mbuf01, *mbuf10, *mbuf11, *mbuf20, *mbuf21;
-	uint32_t pkt00_index, pkt01_index, pkt10_index;
-	uint32_t pkt11_index, pkt20_index, pkt21_index;
-	uint64_t pkts_mask_out = 0, buckets_mask = 0;
-	struct rte_bucket_4_8 *buckets[RTE_PORT_IN_BURST_SIZE_MAX];
-	uint64_t *keys[RTE_PORT_IN_BURST_SIZE_MAX];
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_HASH_KEY8_STATS_PKTS_IN_ADD(f, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 5 packets */
-	if (rte_popcount64(pkts_mask) < 5) {
-		for ( ; pkts_mask; ) {
-			struct rte_bucket_4_8 *bucket;
-			struct rte_mbuf *mbuf;
-			uint32_t pkt_index;
-
-			lookup1_stage0(pkt_index, mbuf, pkts, pkts_mask, f);
-			lookup1_stage1(mbuf, bucket, f);
-			lookup1_stage2_ext(pkt_index, mbuf, bucket,
-				pkts_mask_out, entries, buckets_mask,
-				buckets, keys, f);
-		}
-
-		goto grind_next_buckets;
-	}
-
-	/*
-	 * Pipeline fill
-	 *
-	 */
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline feed */
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(pkt00_index, pkt01_index, mbuf00, mbuf01, pkts,
-		pkts_mask, f);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/*
-	 * Pipeline run
-	 *
-	 */
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		bucket20 = bucket10;
-		bucket21 = bucket11;
-		mbuf20 = mbuf10;
-		mbuf21 = mbuf11;
-		mbuf10 = mbuf00;
-		mbuf11 = mbuf01;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(pkt00_index, pkt01_index,
-			mbuf00, mbuf01, pkts, pkts_mask, f);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-			bucket20, bucket21, pkts_mask_out, entries,
-			buckets_mask, buckets, keys, f);
-	}
-
-	/*
-	 * Pipeline flush
-	 *
-	 */
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	mbuf10 = mbuf00;
-	mbuf11 = mbuf01;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(mbuf10, mbuf11, bucket10, bucket11, f);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries,
-		buckets_mask, buckets, keys, f);
-
-	/* Pipeline feed */
-	bucket20 = bucket10;
-	bucket21 = bucket11;
-	mbuf20 = mbuf10;
-	mbuf21 = mbuf11;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2_ext(pkt20_index, pkt21_index, mbuf20, mbuf21,
-		bucket20, bucket21, pkts_mask_out, entries,
-		buckets_mask, buckets, keys, f);
-
-grind_next_buckets:
-	/* Grind next buckets */
-	for ( ; buckets_mask; ) {
-		uint64_t buckets_mask_next = 0;
-
-		for ( ; buckets_mask; ) {
-			uint32_t pkt_index;
-
-			pkt_index = rte_ctz64(buckets_mask);
-			buckets_mask &= ~(1LLU << pkt_index);
-
-			lookup_grinder(pkt_index, buckets, keys, pkts_mask_out,
-				entries, buckets_mask_next, f);
-		}
-
-		buckets_mask = buckets_mask_next;
-	}
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_KEY8_STATS_PKTS_LOOKUP_MISS(f, n_pkts_in - rte_popcount64(pkts_mask_out));
-	return 0;
-} /* lookup EXT */
-
-static int
-rte_table_hash_key8_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_hash *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_hash_key8_lru_ops)
-struct rte_table_ops rte_table_hash_key8_lru_ops = {
-	.f_create = rte_table_hash_create_key8_lru,
-	.f_free = rte_table_hash_free_key8_lru,
-	.f_add = rte_table_hash_entry_add_key8_lru,
-	.f_delete = rte_table_hash_entry_delete_key8_lru,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_lookup_key8_lru,
-	.f_stats = rte_table_hash_key8_stats_read,
-};
-
-RTE_EXPORT_SYMBOL(rte_table_hash_key8_ext_ops)
-struct rte_table_ops rte_table_hash_key8_ext_ops = {
-	.f_create = rte_table_hash_create_key8_ext,
-	.f_free = rte_table_hash_free_key8_ext,
-	.f_add = rte_table_hash_entry_add_key8_ext,
-	.f_delete = rte_table_hash_entry_delete_key8_ext,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_lookup_key8_ext,
-	.f_stats = rte_table_hash_key8_stats_read,
-};
diff --git a/lib/table/rte_table_hash_lru.c b/lib/table/rte_table_hash_lru.c
deleted file mode 100644
index 548f5eebf2..0000000000
--- a/lib/table/rte_table_hash_lru.c
+++ /dev/null
@@ -1,959 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2017 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-
-#include "rte_table_hash.h"
-#include "rte_lru.h"
-
-#include "table_log.h"
-
-#define KEYS_PER_BUCKET	4
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_HASH_LRU_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_HASH_LRU_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_HASH_LRU_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_HASH_LRU_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-struct bucket {
-	union {
-		struct bucket *next;
-		uint64_t lru_list;
-	};
-	uint16_t sig[KEYS_PER_BUCKET];
-	uint32_t key_pos[KEYS_PER_BUCKET];
-};
-
-struct grinder {
-	struct bucket *bkt;
-	uint64_t sig;
-	uint64_t match;
-	uint64_t match_pos;
-	uint32_t key_index;
-};
-
-struct rte_table_hash {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t key_size;
-	uint32_t entry_size;
-	uint32_t n_keys;
-	uint32_t n_buckets;
-	rte_table_hash_op_hash f_hash;
-	uint64_t seed;
-	uint32_t key_offset;
-
-	/* Internal */
-	uint64_t bucket_mask;
-	uint32_t key_size_shl;
-	uint32_t data_size_shl;
-	uint32_t key_stack_tos;
-
-	/* Grinder */
-	struct grinder grinders[RTE_PORT_IN_BURST_SIZE_MAX];
-
-	/* Tables */
-	uint64_t *key_mask;
-	struct bucket *buckets;
-	uint8_t *key_mem;
-	uint8_t *data_mem;
-	uint32_t *key_stack;
-
-	/* Table memory */
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t memory[];
-};
-
-static int
-keycmp(void *a, void *b, void *b_mask, uint32_t n_bytes)
-{
-	uint64_t *a64 = a, *b64 = b, *b_mask64 = b_mask;
-	uint32_t i;
-
-	for (i = 0; i < n_bytes / sizeof(uint64_t); i++)
-		if (a64[i] != (b64[i] & b_mask64[i]))
-			return 1;
-
-	return 0;
-}
-
-static void
-keycpy(void *dst, void *src, void *src_mask, uint32_t n_bytes)
-{
-	uint64_t *dst64 = dst, *src64 = src, *src_mask64 = src_mask;
-	uint32_t i;
-
-	for (i = 0; i < n_bytes / sizeof(uint64_t); i++)
-		dst64[i] = src64[i] & src_mask64[i];
-}
-
-static int
-check_params_create(struct rte_table_hash_params *params)
-{
-	/* name */
-	if (params->name == NULL) {
-		TABLE_LOG(ERR, "%s: name invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* key_size */
-	if ((params->key_size < sizeof(uint64_t)) ||
-		(!rte_is_power_of_2(params->key_size))) {
-		TABLE_LOG(ERR, "%s: key_size invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* n_keys */
-	if (params->n_keys == 0) {
-		TABLE_LOG(ERR, "%s: n_keys invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* n_buckets */
-	if ((params->n_buckets == 0) ||
-		(!rte_is_power_of_2(params->n_buckets))) {
-		TABLE_LOG(ERR, "%s: n_buckets invalid value", __func__);
-		return -EINVAL;
-	}
-
-	/* f_hash */
-	if (params->f_hash == NULL) {
-		TABLE_LOG(ERR, "%s: f_hash invalid value", __func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void *
-rte_table_hash_lru_create(void *params, int socket_id, uint32_t entry_size)
-{
-	struct rte_table_hash_params *p = params;
-	struct rte_table_hash *t;
-	uint64_t table_meta_sz, key_mask_sz, bucket_sz, key_sz, key_stack_sz;
-	uint64_t data_sz, total_size;
-	uint64_t key_mask_offset, bucket_offset, key_offset, key_stack_offset;
-	uint64_t data_offset;
-	uint32_t n_buckets, i;
-
-	/* Check input parameters */
-	if ((check_params_create(p) != 0) ||
-		(!rte_is_power_of_2(entry_size)) ||
-		((sizeof(struct rte_table_hash) % RTE_CACHE_LINE_SIZE) != 0) ||
-		(sizeof(struct bucket) != (RTE_CACHE_LINE_SIZE / 2))) {
-		return NULL;
-	}
-
-	/*
-	 * Table dimensioning
-	 *
-	 * Objective: Pick the number of buckets (n_buckets) so that there a chance
-	 * to store n_keys keys in the table.
-	 *
-	 * Note: Since the buckets do not get extended, it is not possible to
-	 * guarantee that n_keys keys can be stored in the table at any time. In the
-	 * worst case scenario when all the n_keys fall into the same bucket, only
-	 * a maximum of KEYS_PER_BUCKET keys will be stored in the table. This case
-	 * defeats the purpose of the hash table. It indicates unsuitable f_hash or
-	 * n_keys to n_buckets ratio.
-	 *
-	 * MIN(n_buckets) = (n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET
-	 */
-	n_buckets = rte_align32pow2(
-		(p->n_keys + KEYS_PER_BUCKET - 1) / KEYS_PER_BUCKET);
-	n_buckets = RTE_MAX(n_buckets, p->n_buckets);
-
-	/* Memory allocation */
-	table_meta_sz = RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_table_hash));
-	key_mask_sz = RTE_CACHE_LINE_ROUNDUP(p->key_size);
-	bucket_sz = RTE_CACHE_LINE_ROUNDUP(n_buckets * sizeof(struct bucket));
-	key_sz = RTE_CACHE_LINE_ROUNDUP(p->n_keys * p->key_size);
-	key_stack_sz = RTE_CACHE_LINE_ROUNDUP(p->n_keys * sizeof(uint32_t));
-	data_sz = RTE_CACHE_LINE_ROUNDUP(p->n_keys * entry_size);
-	total_size = table_meta_sz + key_mask_sz + bucket_sz + key_sz +
-		key_stack_sz + data_sz;
-
-	if (total_size > SIZE_MAX) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %" PRIu64 " bytes for hash "
-			"table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-
-	t = rte_zmalloc_socket(p->name,
-		(size_t)total_size,
-		RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (t == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %" PRIu64 " bytes for hash "
-			"table %s",
-			__func__, total_size, p->name);
-		return NULL;
-	}
-	TABLE_LOG(INFO, "%s (%u-byte key): Hash table %s memory footprint"
-		" is %" PRIu64 " bytes",
-		__func__, p->key_size, p->name, total_size);
-
-	/* Memory initialization */
-	t->key_size = p->key_size;
-	t->entry_size = entry_size;
-	t->n_keys = p->n_keys;
-	t->n_buckets = n_buckets;
-	t->f_hash = p->f_hash;
-	t->seed = p->seed;
-	t->key_offset = p->key_offset;
-
-	/* Internal */
-	t->bucket_mask = t->n_buckets - 1;
-	t->key_size_shl = rte_ctz32(p->key_size);
-	t->data_size_shl = rte_ctz32(entry_size);
-
-	/* Tables */
-	key_mask_offset = 0;
-	bucket_offset = key_mask_offset + key_mask_sz;
-	key_offset = bucket_offset + bucket_sz;
-	key_stack_offset = key_offset + key_sz;
-	data_offset = key_stack_offset + key_stack_sz;
-
-	t->key_mask = (uint64_t *) &t->memory[key_mask_offset];
-	t->buckets = (struct bucket *) &t->memory[bucket_offset];
-	t->key_mem = &t->memory[key_offset];
-	t->key_stack = (uint32_t *) &t->memory[key_stack_offset];
-	t->data_mem = &t->memory[data_offset];
-
-	/* Key mask */
-	if (p->key_mask == NULL)
-		memset(t->key_mask, 0xFF, p->key_size);
-	else
-		memcpy(t->key_mask, p->key_mask, p->key_size);
-
-	/* Key stack */
-	for (i = 0; i < t->n_keys; i++)
-		t->key_stack[i] = t->n_keys - 1 - i;
-	t->key_stack_tos = t->n_keys;
-
-	/* LRU */
-	for (i = 0; i < t->n_buckets; i++) {
-		struct bucket *bkt = &t->buckets[i];
-
-		lru_init(bkt);
-	}
-
-	return t;
-}
-
-static int
-rte_table_hash_lru_free(void *table)
-{
-	struct rte_table_hash *t = table;
-
-	/* Check input parameters */
-	if (t == NULL)
-		return -EINVAL;
-
-	rte_free(t);
-	return 0;
-}
-
-static int
-rte_table_hash_lru_entry_add(void *table, void *key, void *entry,
-	int *key_found, void **entry_ptr)
-{
-	struct rte_table_hash *t = table;
-	struct bucket *bkt;
-	uint64_t sig;
-	uint32_t bkt_index, i;
-
-	sig = t->f_hash(key, t->key_mask, t->key_size, t->seed);
-	bkt_index = sig & t->bucket_mask;
-	bkt = &t->buckets[bkt_index];
-	sig = (sig >> 16) | 1LLU;
-
-	/* Key is present in the bucket */
-	for (i = 0; i < KEYS_PER_BUCKET; i++) {
-		uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-		uint32_t bkt_key_index = bkt->key_pos[i];
-		uint8_t *bkt_key = &t->key_mem[bkt_key_index <<
-			t->key_size_shl];
-
-		if ((sig == bkt_sig) && (keycmp(bkt_key, key, t->key_mask,
-			t->key_size) == 0)) {
-			uint8_t *data = &t->data_mem[bkt_key_index <<
-				t->data_size_shl];
-
-			memcpy(data, entry, t->entry_size);
-			lru_update(bkt, i);
-			*key_found = 1;
-			*entry_ptr = (void *) data;
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	for (i = 0; i < KEYS_PER_BUCKET; i++) {
-		uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-
-		if (bkt_sig == 0) {
-			uint32_t bkt_key_index;
-			uint8_t *bkt_key, *data;
-
-			/* Allocate new key */
-			if (t->key_stack_tos == 0) {
-				/* No keys available */
-				return -ENOSPC;
-			}
-			bkt_key_index = t->key_stack[--t->key_stack_tos];
-
-			/* Install new key */
-			bkt_key = &t->key_mem[bkt_key_index << t->key_size_shl];
-			data = &t->data_mem[bkt_key_index << t->data_size_shl];
-
-			bkt->sig[i] = (uint16_t) sig;
-			bkt->key_pos[i] = bkt_key_index;
-			keycpy(bkt_key, key, t->key_mask, t->key_size);
-			memcpy(data, entry, t->entry_size);
-			lru_update(bkt, i);
-
-			*key_found = 0;
-			*entry_ptr = (void *) data;
-			return 0;
-		}
-	}
-
-	/* Bucket full */
-	{
-		uint64_t pos = lru_pos(bkt);
-		uint32_t bkt_key_index = bkt->key_pos[pos];
-		uint8_t *bkt_key = &t->key_mem[bkt_key_index <<
-			t->key_size_shl];
-		uint8_t *data = &t->data_mem[bkt_key_index << t->data_size_shl];
-
-		bkt->sig[pos] = (uint16_t) sig;
-		keycpy(bkt_key, key, t->key_mask, t->key_size);
-		memcpy(data, entry, t->entry_size);
-		lru_update(bkt, pos);
-
-		*key_found = 0;
-		*entry_ptr = (void *) data;
-		return 0;
-	}
-}
-
-static int
-rte_table_hash_lru_entry_delete(void *table, void *key, int *key_found,
-	void *entry)
-{
-	struct rte_table_hash *t = table;
-	struct bucket *bkt;
-	uint64_t sig;
-	uint32_t bkt_index, i;
-
-	sig = t->f_hash(key, t->key_mask, t->key_size, t->seed);
-	bkt_index = sig & t->bucket_mask;
-	bkt = &t->buckets[bkt_index];
-	sig = (sig >> 16) | 1LLU;
-
-	/* Key is present in the bucket */
-	for (i = 0; i < KEYS_PER_BUCKET; i++) {
-		uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-		uint32_t bkt_key_index = bkt->key_pos[i];
-		uint8_t *bkt_key = &t->key_mem[bkt_key_index <<
-			t->key_size_shl];
-
-		if ((sig == bkt_sig) &&
-			(keycmp(bkt_key, key, t->key_mask, t->key_size) == 0)) {
-			uint8_t *data = &t->data_mem[bkt_key_index <<
-				t->data_size_shl];
-
-			bkt->sig[i] = 0;
-			t->key_stack[t->key_stack_tos++] = bkt_key_index;
-			*key_found = 1;
-			if (entry)
-				memcpy(entry, data, t->entry_size);
-			return 0;
-		}
-	}
-
-	/* Key is not present in the bucket */
-	*key_found = 0;
-	return 0;
-}
-
-static int rte_table_hash_lru_lookup_unoptimized(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *t = (struct rte_table_hash *) table;
-	uint64_t pkts_mask_out = 0;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_HASH_LRU_STATS_PKTS_IN_ADD(t, n_pkts_in);
-
-	for ( ; pkts_mask; ) {
-		struct bucket *bkt;
-		struct rte_mbuf *pkt;
-		uint8_t *key;
-		uint64_t pkt_mask, sig;
-		uint32_t pkt_index, bkt_index, i;
-
-		pkt_index = rte_ctz64(pkts_mask);
-		pkt_mask = 1LLU << pkt_index;
-		pkts_mask &= ~pkt_mask;
-
-		pkt = pkts[pkt_index];
-		key = RTE_MBUF_METADATA_UINT8_PTR(pkt, t->key_offset);
-		sig = (uint64_t) t->f_hash(key, t->key_mask, t->key_size, t->seed);
-
-		bkt_index = sig & t->bucket_mask;
-		bkt = &t->buckets[bkt_index];
-		sig = (sig >> 16) | 1LLU;
-
-		/* Key is present in the bucket */
-		for (i = 0; i < KEYS_PER_BUCKET; i++) {
-			uint64_t bkt_sig = (uint64_t) bkt->sig[i];
-			uint32_t bkt_key_index = bkt->key_pos[i];
-			uint8_t *bkt_key = &t->key_mem[bkt_key_index <<
-				t->key_size_shl];
-
-			if ((sig == bkt_sig) && (keycmp(bkt_key, key, t->key_mask,
-				t->key_size) == 0)) {
-				uint8_t *data = &t->data_mem[bkt_key_index <<
-					t->data_size_shl];
-
-				lru_update(bkt, i);
-				pkts_mask_out |= pkt_mask;
-				entries[pkt_index] = (void *) data;
-				break;
-			}
-		}
-	}
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_LRU_STATS_PKTS_LOOKUP_MISS(t, n_pkts_in - rte_popcount64(pkts_mask_out));
-	return 0;
-}
-
-/*
- * mask = match bitmask
- * match = at least one match
- * match_many = more than one match
- * match_pos = position of first match
- *
- * ----------------------------------------
- * mask		 match	 match_many	  match_pos
- * ----------------------------------------
- * 0000		 0		 0			  00
- * 0001		 1		 0			  00
- * 0010		 1		 0			  01
- * 0011		 1		 1			  00
- * ----------------------------------------
- * 0100		 1		 0			  10
- * 0101		 1		 1			  00
- * 0110		 1		 1			  01
- * 0111		 1		 1			  00
- * ----------------------------------------
- * 1000		 1		 0			  11
- * 1001		 1		 1			  00
- * 1010		 1		 1			  01
- * 1011		 1		 1			  00
- * ----------------------------------------
- * 1100		 1		 1			  10
- * 1101		 1		 1			  00
- * 1110		 1		 1			  01
- * 1111		 1		 1			  00
- * ----------------------------------------
- *
- * match = 1111_1111_1111_1110
- * match_many = 1111_1110_1110_1000
- * match_pos = 0001_0010_0001_0011__0001_0010_0001_0000
- *
- * match = 0xFFFELLU
- * match_many = 0xFEE8LLU
- * match_pos = 0x12131210LLU
- */
-
-#define LUT_MATCH						0xFFFELLU
-#define LUT_MATCH_MANY						0xFEE8LLU
-#define LUT_MATCH_POS						0x12131210LLU
-
-#define lookup_cmp_sig(mbuf_sig, bucket, match, match_many, match_pos)\
-{								\
-	uint64_t bucket_sig[4], mask[4], mask_all;		\
-								\
-	bucket_sig[0] = bucket->sig[0];				\
-	bucket_sig[1] = bucket->sig[1];				\
-	bucket_sig[2] = bucket->sig[2];				\
-	bucket_sig[3] = bucket->sig[3];				\
-								\
-	bucket_sig[0] ^= mbuf_sig;				\
-	bucket_sig[1] ^= mbuf_sig;				\
-	bucket_sig[2] ^= mbuf_sig;				\
-	bucket_sig[3] ^= mbuf_sig;				\
-								\
-	mask[0] = 0;						\
-	mask[1] = 0;						\
-	mask[2] = 0;						\
-	mask[3] = 0;						\
-								\
-	if (bucket_sig[0] == 0)					\
-		mask[0] = 1;					\
-	if (bucket_sig[1] == 0)					\
-		mask[1] = 2;					\
-	if (bucket_sig[2] == 0)					\
-		mask[2] = 4;					\
-	if (bucket_sig[3] == 0)					\
-		mask[3] = 8;					\
-								\
-	mask_all = (mask[0] | mask[1]) | (mask[2] | mask[3]);	\
-								\
-	match = (LUT_MATCH >> mask_all) & 1;			\
-	match_many = (LUT_MATCH_MANY >> mask_all) & 1;		\
-	match_pos = (LUT_MATCH_POS >> (mask_all << 1)) & 3;	\
-}
-
-#define lookup_cmp_key(mbuf, key, match_key, f)				\
-{									\
-	uint64_t *pkt_key = RTE_MBUF_METADATA_UINT64_PTR(mbuf, f->key_offset);\
-	uint64_t *bkt_key = (uint64_t *) key;				\
-	uint64_t *key_mask = f->key_mask;					\
-									\
-	switch (f->key_size) {						\
-	case 8:								\
-	{								\
-		uint64_t xor = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];	\
-		match_key = 0;						\
-		if (xor == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	case 16:							\
-	{								\
-		uint64_t xor[2], or;					\
-									\
-		xor[0] = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];		\
-		xor[1] = (pkt_key[1] & key_mask[1]) ^ bkt_key[1];		\
-		or = xor[0] | xor[1];					\
-		match_key = 0;						\
-		if (or == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	case 32:							\
-	{								\
-		uint64_t xor[4], or;					\
-									\
-		xor[0] = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];		\
-		xor[1] = (pkt_key[1] & key_mask[1]) ^ bkt_key[1];		\
-		xor[2] = (pkt_key[2] & key_mask[2]) ^ bkt_key[2];		\
-		xor[3] = (pkt_key[3] & key_mask[3]) ^ bkt_key[3];		\
-		or = xor[0] | xor[1] | xor[2] | xor[3];			\
-		match_key = 0;						\
-		if (or == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	case 64:							\
-	{								\
-		uint64_t xor[8], or;					\
-									\
-		xor[0] = (pkt_key[0] & key_mask[0]) ^ bkt_key[0];		\
-		xor[1] = (pkt_key[1] & key_mask[1]) ^ bkt_key[1];		\
-		xor[2] = (pkt_key[2] & key_mask[2]) ^ bkt_key[2];		\
-		xor[3] = (pkt_key[3] & key_mask[3]) ^ bkt_key[3];		\
-		xor[4] = (pkt_key[4] & key_mask[4]) ^ bkt_key[4];		\
-		xor[5] = (pkt_key[5] & key_mask[5]) ^ bkt_key[5];		\
-		xor[6] = (pkt_key[6] & key_mask[6]) ^ bkt_key[6];		\
-		xor[7] = (pkt_key[7] & key_mask[7]) ^ bkt_key[7];		\
-		or = xor[0] | xor[1] | xor[2] | xor[3] |		\
-			xor[4] | xor[5] | xor[6] | xor[7];		\
-		match_key = 0;						\
-		if (or == 0)						\
-			match_key = 1;					\
-	}								\
-	break;								\
-									\
-	default:							\
-		match_key = 0;						\
-		if (keycmp(bkt_key, pkt_key, key_mask, f->key_size) == 0)	\
-			match_key = 1;					\
-	}								\
-}
-
-#define lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index)\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	struct rte_mbuf *mbuf00, *mbuf01;			\
-	uint32_t key_offset = t->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-	mbuf00 = pkts[pkt00_index];				\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-	mbuf01 = pkts[pkt01_index];				\
-								\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage0_with_odd_support(t, g, pkts, pkts_mask, pkt00_index, \
-	pkt01_index)						\
-{								\
-	uint64_t pkt00_mask, pkt01_mask;			\
-	struct rte_mbuf *mbuf00, *mbuf01;			\
-	uint32_t key_offset = t->key_offset;		\
-								\
-	pkt00_index = rte_ctz64(pkts_mask);		\
-	pkt00_mask = 1LLU << pkt00_index;			\
-	pkts_mask &= ~pkt00_mask;				\
-	mbuf00 = pkts[pkt00_index];				\
-								\
-	pkt01_index = rte_ctz64(pkts_mask);		\
-	if (pkts_mask == 0)					\
-		pkt01_index = pkt00_index;			\
-								\
-	pkt01_mask = 1LLU << pkt01_index;			\
-	pkts_mask &= ~pkt01_mask;				\
-	mbuf01 = pkts[pkt01_index];				\
-								\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf00, key_offset));\
-	rte_prefetch0(RTE_MBUF_METADATA_UINT8_PTR(mbuf01, key_offset));\
-}
-
-#define lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index)\
-{								\
-	struct grinder *g10, *g11;				\
-	uint64_t sig10, sig11, bkt10_index, bkt11_index;	\
-	struct rte_mbuf *mbuf10, *mbuf11;			\
-	struct bucket *bkt10, *bkt11, *buckets = t->buckets;	\
-	uint8_t *key10, *key11;					\
-	uint64_t bucket_mask = t->bucket_mask;			\
-	rte_table_hash_op_hash f_hash = t->f_hash;		\
-	uint64_t seed = t->seed;				\
-	uint32_t key_size = t->key_size;			\
-	uint32_t key_offset = t->key_offset;			\
-								\
-	mbuf10 = pkts[pkt10_index];				\
-	key10 = RTE_MBUF_METADATA_UINT8_PTR(mbuf10, key_offset);\
-	sig10 = (uint64_t) f_hash(key10, t->key_mask, key_size, seed);\
-	bkt10_index = sig10 & bucket_mask;			\
-	bkt10 = &buckets[bkt10_index];				\
-								\
-	mbuf11 = pkts[pkt11_index];				\
-	key11 = RTE_MBUF_METADATA_UINT8_PTR(mbuf11, key_offset);\
-	sig11 = (uint64_t) f_hash(key11, t->key_mask, key_size, seed);\
-	bkt11_index = sig11 & bucket_mask;			\
-	bkt11 = &buckets[bkt11_index];				\
-								\
-	rte_prefetch0(bkt10);					\
-	rte_prefetch0(bkt11);					\
-								\
-	g10 = &g[pkt10_index];					\
-	g10->sig = sig10;					\
-	g10->bkt = bkt10;					\
-								\
-	g11 = &g[pkt11_index];					\
-	g11->sig = sig11;					\
-	g11->bkt = bkt11;					\
-}
-
-#define lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many)\
-{								\
-	struct grinder *g20, *g21;				\
-	uint64_t sig20, sig21;					\
-	struct bucket *bkt20, *bkt21;				\
-	uint8_t *key20, *key21, *key_mem = t->key_mem;		\
-	uint64_t match20, match21, match_many20, match_many21;	\
-	uint64_t match_pos20, match_pos21;			\
-	uint32_t key20_index, key21_index, key_size_shl = t->key_size_shl;\
-								\
-	g20 = &g[pkt20_index];					\
-	sig20 = g20->sig;					\
-	bkt20 = g20->bkt;					\
-	sig20 = (sig20 >> 16) | 1LLU;				\
-	lookup_cmp_sig(sig20, bkt20, match20, match_many20, match_pos20);\
-	match20 <<= pkt20_index;				\
-	match_many20 <<= pkt20_index;				\
-	key20_index = bkt20->key_pos[match_pos20];		\
-	key20 = &key_mem[key20_index << key_size_shl];		\
-								\
-	g21 = &g[pkt21_index];					\
-	sig21 = g21->sig;					\
-	bkt21 = g21->bkt;					\
-	sig21 = (sig21 >> 16) | 1LLU;				\
-	lookup_cmp_sig(sig21, bkt21, match21, match_many21, match_pos21);\
-	match21 <<= pkt21_index;				\
-	match_many21 <<= pkt21_index;				\
-	key21_index = bkt21->key_pos[match_pos21];		\
-	key21 = &key_mem[key21_index << key_size_shl];		\
-								\
-	rte_prefetch0(key20);					\
-	rte_prefetch0(key21);					\
-								\
-	pkts_mask_match_many |= match_many20 | match_many21;	\
-								\
-	g20->match = match20;					\
-	g20->match_pos = match_pos20;				\
-	g20->key_index = key20_index;				\
-								\
-	g21->match = match21;					\
-	g21->match_pos = match_pos21;				\
-	g21->key_index = key21_index;				\
-}
-
-#define lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out, \
-	entries)						\
-{								\
-	struct grinder *g30, *g31;				\
-	struct rte_mbuf *mbuf30, *mbuf31;			\
-	struct bucket *bkt30, *bkt31;				\
-	uint8_t *key30, *key31, *key_mem = t->key_mem;		\
-	uint8_t *data30, *data31, *data_mem = t->data_mem;	\
-	uint64_t match30, match31, match_pos30, match_pos31;	\
-	uint64_t match_key30, match_key31, match_keys;		\
-	uint32_t key30_index, key31_index;			\
-	uint32_t key_size_shl = t->key_size_shl;		\
-	uint32_t data_size_shl = t->data_size_shl;		\
-								\
-	mbuf30 = pkts[pkt30_index];				\
-	g30 = &g[pkt30_index];					\
-	bkt30 = g30->bkt;					\
-	match30 = g30->match;					\
-	match_pos30 = g30->match_pos;				\
-	key30_index = g30->key_index;				\
-	key30 = &key_mem[key30_index << key_size_shl];		\
-	lookup_cmp_key(mbuf30, key30, match_key30, t);		\
-	match_key30 <<= pkt30_index;				\
-	match_key30 &= match30;					\
-	data30 = &data_mem[key30_index << data_size_shl];	\
-	entries[pkt30_index] = data30;				\
-								\
-	mbuf31 = pkts[pkt31_index];				\
-	g31 = &g[pkt31_index];					\
-	bkt31 = g31->bkt;					\
-	match31 = g31->match;					\
-	match_pos31 = g31->match_pos;				\
-	key31_index = g31->key_index;				\
-	key31 = &key_mem[key31_index << key_size_shl];		\
-	lookup_cmp_key(mbuf31, key31, match_key31, t);		\
-	match_key31 <<= pkt31_index;				\
-	match_key31 &= match31;					\
-	data31 = &data_mem[key31_index << data_size_shl];	\
-	entries[pkt31_index] = data31;				\
-								\
-	rte_prefetch0(data30);					\
-	rte_prefetch0(data31);					\
-								\
-	match_keys = match_key30 | match_key31;			\
-	pkts_mask_out |= match_keys;				\
-								\
-	if (match_key30 == 0)					\
-		match_pos30 = 4;				\
-	lru_update(bkt30, match_pos30);				\
-								\
-	if (match_key31 == 0)					\
-		match_pos31 = 4;				\
-	lru_update(bkt31, match_pos31);				\
-}
-
-/*
- * The lookup function implements a 4-stage pipeline, with each stage processing
- * two different packets. The purpose of pipelined implementation is to hide the
- * latency of prefetching the data structures and loosen the data dependency
- * between instructions.
- *
- *   p00  _______   p10  _______   p20  _______   p30  _______
- * ----->|       |----->|       |----->|       |----->|       |----->
- *       |   0   |      |   1   |      |   2   |      |   3   |
- * ----->|_______|----->|_______|----->|_______|----->|_______|----->
- *   p01            p11            p21            p31
- *
- * The naming convention is:
- *	  pXY = packet Y of stage X, X = 0 .. 3, Y = 0 .. 1
- */
-static int rte_table_hash_lru_lookup(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_hash *t = (struct rte_table_hash *) table;
-	struct grinder *g = t->grinders;
-	uint64_t pkt00_index, pkt01_index, pkt10_index, pkt11_index;
-	uint64_t pkt20_index, pkt21_index, pkt30_index, pkt31_index;
-	uint64_t pkts_mask_out = 0, pkts_mask_match_many = 0;
-	int status = 0;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_HASH_LRU_STATS_PKTS_IN_ADD(t, n_pkts_in);
-
-	/* Cannot run the pipeline with less than 7 packets */
-	if (rte_popcount64(pkts_mask) < 7)
-		return rte_table_hash_lru_lookup_unoptimized(table, pkts,
-			pkts_mask, lookup_hit_mask, entries);
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index);
-
-	/* Pipeline feed */
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-	/* Pipeline feed */
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 0 */
-	lookup2_stage0(t, g, pkts, pkts_mask, pkt00_index, pkt01_index);
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many);
-
-	/*
-	* Pipeline run
-	*
-	*/
-	for ( ; pkts_mask; ) {
-		/* Pipeline feed */
-		pkt30_index = pkt20_index;
-		pkt31_index = pkt21_index;
-		pkt20_index = pkt10_index;
-		pkt21_index = pkt11_index;
-		pkt10_index = pkt00_index;
-		pkt11_index = pkt01_index;
-
-		/* Pipeline stage 0 */
-		lookup2_stage0_with_odd_support(t, g, pkts, pkts_mask,
-			pkt00_index, pkt01_index);
-
-		/* Pipeline stage 1 */
-		lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-		/* Pipeline stage 2 */
-		lookup2_stage2(t, g, pkt20_index, pkt21_index,
-			pkts_mask_match_many);
-
-		/* Pipeline stage 3 */
-		lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index,
-			pkts_mask_out, entries);
-	}
-
-	/* Pipeline feed */
-	pkt30_index = pkt20_index;
-	pkt31_index = pkt21_index;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-	pkt10_index = pkt00_index;
-	pkt11_index = pkt01_index;
-
-	/* Pipeline stage 1 */
-	lookup2_stage1(t, g, pkts, pkt10_index, pkt11_index);
-
-	/* Pipeline stage 2 */
-	lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many);
-
-	/* Pipeline stage 3 */
-	lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out,
-		entries);
-
-	/* Pipeline feed */
-	pkt30_index = pkt20_index;
-	pkt31_index = pkt21_index;
-	pkt20_index = pkt10_index;
-	pkt21_index = pkt11_index;
-
-	/* Pipeline stage 2 */
-	lookup2_stage2(t, g, pkt20_index, pkt21_index, pkts_mask_match_many);
-
-	/* Pipeline stage 3 */
-	lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out,
-		entries);
-
-	/* Pipeline feed */
-	pkt30_index = pkt20_index;
-	pkt31_index = pkt21_index;
-
-	/* Pipeline stage 3 */
-	lookup2_stage3(t, g, pkts, pkt30_index, pkt31_index, pkts_mask_out,
-		entries);
-
-	/* Slow path */
-	pkts_mask_match_many &= ~pkts_mask_out;
-	if (pkts_mask_match_many) {
-		uint64_t pkts_mask_out_slow = 0;
-
-		status = rte_table_hash_lru_lookup_unoptimized(table, pkts,
-			pkts_mask_match_many, &pkts_mask_out_slow, entries);
-		pkts_mask_out |= pkts_mask_out_slow;
-	}
-
-	*lookup_hit_mask = pkts_mask_out;
-	RTE_TABLE_HASH_LRU_STATS_PKTS_LOOKUP_MISS(t, n_pkts_in - rte_popcount64(pkts_mask_out));
-	return status;
-}
-
-static int
-rte_table_hash_lru_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_hash *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_hash_lru_ops)
-struct rte_table_ops rte_table_hash_lru_ops = {
-	.f_create = rte_table_hash_lru_create,
-	.f_free = rte_table_hash_lru_free,
-	.f_add = rte_table_hash_lru_entry_add,
-	.f_delete = rte_table_hash_lru_entry_delete,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_hash_lru_lookup,
-	.f_stats = rte_table_hash_lru_stats_read,
-};
diff --git a/lib/table/rte_table_lpm.c b/lib/table/rte_table_lpm.c
deleted file mode 100644
index 6fd0c30f85..0000000000
--- a/lib/table/rte_table_lpm.c
+++ /dev/null
@@ -1,369 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_byteorder.h>
-#include <rte_log.h>
-#include <rte_lpm.h>
-
-#include "rte_table_lpm.h"
-
-#include "table_log.h"
-
-#ifndef RTE_TABLE_LPM_MAX_NEXT_HOPS
-#define RTE_TABLE_LPM_MAX_NEXT_HOPS                        65536
-#endif
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_LPM_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_LPM_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_LPM_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_LPM_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-struct rte_table_lpm {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t entry_size;
-	uint32_t entry_unique_size;
-	uint32_t n_rules;
-	uint32_t offset;
-
-	/* Handle to low-level LPM table */
-	struct rte_lpm *lpm;
-
-	/* Next Hop Table (NHT) */
-	uint32_t nht_users[RTE_TABLE_LPM_MAX_NEXT_HOPS];
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t nht[];
-};
-
-static void *
-rte_table_lpm_create(void *params, int socket_id, uint32_t entry_size)
-{
-	struct rte_table_lpm_params *p = params;
-	struct rte_table_lpm *lpm;
-	struct rte_lpm_config lpm_config;
-
-	uint32_t total_size, nht_size;
-
-	/* Check input parameters */
-	if (p == NULL) {
-		TABLE_LOG(ERR, "%s: NULL input parameters", __func__);
-		return NULL;
-	}
-	if (p->n_rules == 0) {
-		TABLE_LOG(ERR, "%s: Invalid n_rules", __func__);
-		return NULL;
-	}
-	if (p->number_tbl8s == 0) {
-		TABLE_LOG(ERR, "%s: Invalid number_tbl8s", __func__);
-		return NULL;
-	}
-	if (p->entry_unique_size == 0) {
-		TABLE_LOG(ERR, "%s: Invalid entry_unique_size",
-			__func__);
-		return NULL;
-	}
-	if (p->entry_unique_size > entry_size) {
-		TABLE_LOG(ERR, "%s: Invalid entry_unique_size",
-			__func__);
-		return NULL;
-	}
-	if (p->name == NULL) {
-		TABLE_LOG(ERR, "%s: Table name is NULL",
-			__func__);
-		return NULL;
-	}
-	entry_size = RTE_ALIGN(entry_size, sizeof(uint64_t));
-
-	/* Memory allocation */
-	nht_size = RTE_TABLE_LPM_MAX_NEXT_HOPS * entry_size;
-	total_size = sizeof(struct rte_table_lpm) + nht_size;
-	lpm = rte_zmalloc_socket("TABLE", total_size, RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (lpm == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %u bytes for LPM table",
-			__func__, total_size);
-		return NULL;
-	}
-
-	/* LPM low-level table creation */
-	lpm_config.max_rules = p->n_rules;
-	lpm_config.number_tbl8s = p->number_tbl8s;
-	lpm_config.flags = p->flags;
-	lpm->lpm = rte_lpm_create(p->name, socket_id, &lpm_config);
-
-	if (lpm->lpm == NULL) {
-		rte_free(lpm);
-		TABLE_LOG(ERR, "Unable to create low-level LPM table");
-		return NULL;
-	}
-
-	/* Memory initialization */
-	lpm->entry_size = entry_size;
-	lpm->entry_unique_size = p->entry_unique_size;
-	lpm->n_rules = p->n_rules;
-	lpm->offset = p->offset;
-
-	return lpm;
-}
-
-static int
-rte_table_lpm_free(void *table)
-{
-	struct rte_table_lpm *lpm = table;
-
-	/* Check input parameters */
-	if (lpm == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	/* Free previously allocated resources */
-	rte_lpm_free(lpm->lpm);
-	rte_free(lpm);
-
-	return 0;
-}
-
-static int
-nht_find_free(struct rte_table_lpm *lpm, uint32_t *pos)
-{
-	uint32_t i;
-
-	for (i = 0; i < RTE_TABLE_LPM_MAX_NEXT_HOPS; i++) {
-		if (lpm->nht_users[i] == 0) {
-			*pos = i;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static int
-nht_find_existing(struct rte_table_lpm *lpm, void *entry, uint32_t *pos)
-{
-	uint32_t i;
-
-	for (i = 0; i < RTE_TABLE_LPM_MAX_NEXT_HOPS; i++) {
-		uint8_t *nht_entry = &lpm->nht[i * lpm->entry_size];
-
-		if ((lpm->nht_users[i] > 0) && (memcmp(nht_entry, entry,
-			lpm->entry_unique_size) == 0)) {
-			*pos = i;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static int
-rte_table_lpm_entry_add(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_lpm *lpm = table;
-	struct rte_table_lpm_key *ip_prefix = key;
-	uint32_t nht_pos, nht_pos0_valid;
-	int status;
-	uint32_t nht_pos0 = 0;
-
-	/* Check input parameters */
-	if (lpm == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (ip_prefix == NULL) {
-		TABLE_LOG(ERR, "%s: ip_prefix parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if (entry == NULL) {
-		TABLE_LOG(ERR, "%s: entry parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	if ((ip_prefix->depth == 0) || (ip_prefix->depth > 32)) {
-		TABLE_LOG(ERR, "%s: invalid depth (%d)",
-			__func__, ip_prefix->depth);
-		return -EINVAL;
-	}
-
-	/* Check if rule is already present in the table */
-	status = rte_lpm_is_rule_present(lpm->lpm, ip_prefix->ip,
-		ip_prefix->depth, &nht_pos0);
-	nht_pos0_valid = status > 0;
-
-	/* Find existing or free NHT entry */
-	if (nht_find_existing(lpm, entry, &nht_pos) == 0) {
-		uint8_t *nht_entry;
-
-		if (nht_find_free(lpm, &nht_pos) == 0) {
-			TABLE_LOG(ERR, "%s: NHT full", __func__);
-			return -1;
-		}
-
-		nht_entry = &lpm->nht[nht_pos * lpm->entry_size];
-		memcpy(nht_entry, entry, lpm->entry_size);
-	}
-
-	/* Add rule to low level LPM table */
-	if (rte_lpm_add(lpm->lpm, ip_prefix->ip, ip_prefix->depth, nht_pos) < 0) {
-		TABLE_LOG(ERR, "%s: LPM rule add failed", __func__);
-		return -1;
-	}
-
-	/* Commit NHT changes */
-	lpm->nht_users[nht_pos]++;
-	lpm->nht_users[nht_pos0] -= nht_pos0_valid;
-
-	*key_found = nht_pos0_valid;
-	*entry_ptr = (void *) &lpm->nht[nht_pos * lpm->entry_size];
-	return 0;
-}
-
-static int
-rte_table_lpm_entry_delete(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_lpm *lpm = table;
-	struct rte_table_lpm_key *ip_prefix = key;
-	uint32_t nht_pos;
-	int status;
-
-	/* Check input parameters */
-	if (lpm == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (ip_prefix == NULL) {
-		TABLE_LOG(ERR, "%s: ip_prefix parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if ((ip_prefix->depth == 0) || (ip_prefix->depth > 32)) {
-		TABLE_LOG(ERR, "%s: invalid depth (%d)", __func__,
-			ip_prefix->depth);
-		return -EINVAL;
-	}
-
-	/* Return if rule is not present in the table */
-	status = rte_lpm_is_rule_present(lpm->lpm, ip_prefix->ip,
-		ip_prefix->depth, &nht_pos);
-	if (status < 0) {
-		TABLE_LOG(ERR, "%s: LPM algorithmic error", __func__);
-		return -1;
-	}
-	if (status == 0) {
-		*key_found = 0;
-		return 0;
-	}
-
-	/* Delete rule from the low-level LPM table */
-	status = rte_lpm_delete(lpm->lpm, ip_prefix->ip, ip_prefix->depth);
-	if (status) {
-		TABLE_LOG(ERR, "%s: LPM rule delete failed", __func__);
-		return -1;
-	}
-
-	/* Commit NHT changes */
-	lpm->nht_users[nht_pos]--;
-
-	*key_found = 1;
-	if (entry)
-		memcpy(entry, &lpm->nht[nht_pos * lpm->entry_size],
-			lpm->entry_size);
-
-	return 0;
-}
-
-static int
-rte_table_lpm_lookup(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_lpm *lpm = (struct rte_table_lpm *) table;
-	uint64_t pkts_out_mask = 0;
-	uint32_t i;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_LPM_STATS_PKTS_IN_ADD(lpm, n_pkts_in);
-
-	pkts_out_mask = 0;
-	for (i = 0; i < (uint32_t)(RTE_PORT_IN_BURST_SIZE_MAX -
-		rte_clz64(pkts_mask)); i++) {
-		uint64_t pkt_mask = 1LLU << i;
-
-		if (pkt_mask & pkts_mask) {
-			struct rte_mbuf *pkt = pkts[i];
-			uint32_t ip = rte_bswap32(
-				RTE_MBUF_METADATA_UINT32(pkt, lpm->offset));
-			int status;
-			uint32_t nht_pos;
-
-			status = rte_lpm_lookup(lpm->lpm, ip, &nht_pos);
-			if (status == 0) {
-				pkts_out_mask |= pkt_mask;
-				entries[i] = (void *) &lpm->nht[nht_pos *
-					lpm->entry_size];
-			}
-		}
-	}
-
-	*lookup_hit_mask = pkts_out_mask;
-	RTE_TABLE_LPM_STATS_PKTS_LOOKUP_MISS(lpm, n_pkts_in - rte_popcount64(pkts_out_mask));
-	return 0;
-}
-
-static int
-rte_table_lpm_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_lpm *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_lpm_ops)
-struct rte_table_ops rte_table_lpm_ops = {
-	.f_create = rte_table_lpm_create,
-	.f_free = rte_table_lpm_free,
-	.f_add = rte_table_lpm_entry_add,
-	.f_delete = rte_table_lpm_entry_delete,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_lpm_lookup,
-	.f_stats = rte_table_lpm_stats_read,
-};
diff --git a/lib/table/rte_table_lpm.h b/lib/table/rte_table_lpm.h
deleted file mode 100644
index 59b9bdee89..0000000000
--- a/lib/table/rte_table_lpm.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_LPM_H__
-#define __INCLUDE_RTE_TABLE_LPM_H__
-
-/**
- * @file
- * RTE Table LPM for IPv4
- *
- * This table uses the Longest Prefix Match (LPM) algorithm to uniquely
- * associate data to lookup keys.
- *
- * Use-case: IP routing table. Routes that are added to the table associate a
- * next hop to an IP prefix. The IP prefix is specified as IP address and depth
- * and cover for a multitude of lookup keys (i.e. destination IP addresses)
- * that all share the same data (i.e. next hop). The next hop information
- * typically contains the output interface ID, the IP address of the next hop
- * station (which is part of the same IP network the output interface is
- * connected to) and other flags and counters.
- *
- * The LPM primitive only allows associating an 8-bit number (next hop ID) to
- * an IP prefix, while a routing table can potentially contain thousands of
- * routes or even more. This means that the same next hop ID (and next hop
- * information) has to be shared by multiple routes, which makes sense, as
- * multiple remote networks could be reached through the same next hop.
- * Therefore, when a route is added or updated, the LPM table has to check
- * whether the same next hop is already in use before using a new next hop ID
- * for this route.
- *
- * The comparison between different next hops is done for the first
- * “entry_unique_size” bytes of the next hop information (configurable
- * parameter), which have to uniquely identify the next hop, therefore the user
- * has to carefully manage the format of the LPM table entry (i.e.  the next
- * hop information) so that any next hop data that changes value during
- * run-time (e.g. counters) is placed outside of this area.
- */
-
-#include <stdint.h>
-
-#include "rte_table.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/** LPM table parameters */
-struct rte_table_lpm_params {
-	/** Table name */
-	const char *name;
-
-	/** Maximum number of LPM rules (i.e. IP routes) */
-	uint32_t n_rules;
-
-	/**< Number of tbl8s to allocate. */
-	uint32_t number_tbl8s;
-
-	/**< This field is currently unused. */
-	int flags;
-
-	/** Number of bytes at the start of the table entry that uniquely
-	identify the entry. Cannot be bigger than table entry size. */
-	uint32_t entry_unique_size;
-
-	/** Byte offset within input packet meta-data where lookup key (i.e.
-	the destination IP address) is located. */
-	uint32_t offset;
-};
-
-/** LPM table rule (i.e. route), specified as IP prefix. While the key used by
-the lookup operation is the destination IP address (read from the input packet
-meta-data), the entry add and entry delete operations work with LPM rules, with
-each rule covering for a multitude of lookup keys (destination IP addresses)
-that share the same data (next hop). */
-struct rte_table_lpm_key {
-	/** IP address */
-	uint32_t ip;
-
-	/** IP address depth. The most significant "depth" bits of the IP
-	address specify the network part of the IP address, while the rest of
-	the bits specify the host part of the address and are ignored for the
-	purpose of route specification. */
-	uint8_t depth;
-};
-
-/** LPM table operations */
-extern struct rte_table_ops rte_table_lpm_ops;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_table_lpm_ipv6.c b/lib/table/rte_table_lpm_ipv6.c
deleted file mode 100644
index 9159784dfa..0000000000
--- a/lib/table/rte_table_lpm_ipv6.c
+++ /dev/null
@@ -1,370 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#include <stdalign.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_common.h>
-#include <rte_malloc.h>
-#include <rte_log.h>
-#include <rte_lpm6.h>
-
-#include "rte_table_lpm_ipv6.h"
-
-#include "table_log.h"
-
-#define RTE_TABLE_LPM_MAX_NEXT_HOPS                        256
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_LPM_IPV6_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_LPM_IPV6_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_LPM_IPV6_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_LPM_IPV6_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-struct rte_table_lpm_ipv6 {
-	struct rte_table_stats stats;
-
-	/* Input parameters */
-	uint32_t entry_size;
-	uint32_t entry_unique_size;
-	uint32_t n_rules;
-	uint32_t offset;
-
-	/* Handle to low-level LPM table */
-	struct rte_lpm6 *lpm;
-
-	/* Next Hop Table (NHT) */
-	uint32_t nht_users[RTE_TABLE_LPM_MAX_NEXT_HOPS];
-	alignas(RTE_CACHE_LINE_SIZE) uint8_t nht[];
-};
-
-static void *
-rte_table_lpm_ipv6_create(void *params, int socket_id, uint32_t entry_size)
-{
-	struct rte_table_lpm_ipv6_params *p =
-		params;
-	struct rte_table_lpm_ipv6 *lpm;
-	struct rte_lpm6_config lpm6_config;
-	uint32_t total_size, nht_size;
-
-	/* Check input parameters */
-	if (p == NULL) {
-		TABLE_LOG(ERR, "%s: NULL input parameters", __func__);
-		return NULL;
-	}
-	if (p->n_rules == 0) {
-		TABLE_LOG(ERR, "%s: Invalid n_rules", __func__);
-		return NULL;
-	}
-	if (p->number_tbl8s == 0) {
-		TABLE_LOG(ERR, "%s: Invalid n_rules", __func__);
-		return NULL;
-	}
-	if (p->entry_unique_size == 0) {
-		TABLE_LOG(ERR, "%s: Invalid entry_unique_size",
-			__func__);
-		return NULL;
-	}
-	if (p->entry_unique_size > entry_size) {
-		TABLE_LOG(ERR, "%s: Invalid entry_unique_size",
-			__func__);
-		return NULL;
-	}
-	if (p->name == NULL) {
-		TABLE_LOG(ERR, "%s: Table name is NULL",
-			__func__);
-		return NULL;
-	}
-	entry_size = RTE_ALIGN(entry_size, sizeof(uint64_t));
-
-	/* Memory allocation */
-	nht_size = RTE_TABLE_LPM_MAX_NEXT_HOPS * entry_size;
-	total_size = sizeof(struct rte_table_lpm_ipv6) + nht_size;
-	lpm = rte_zmalloc_socket("TABLE", total_size, RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (lpm == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %u bytes for LPM IPv6 table",
-			__func__, total_size);
-		return NULL;
-	}
-
-	/* LPM low-level table creation */
-	lpm6_config.max_rules = p->n_rules;
-	lpm6_config.number_tbl8s = p->number_tbl8s;
-	lpm6_config.flags = 0;
-	lpm->lpm = rte_lpm6_create(p->name, socket_id, &lpm6_config);
-	if (lpm->lpm == NULL) {
-		rte_free(lpm);
-		TABLE_LOG(ERR,
-			"Unable to create low-level LPM IPv6 table");
-		return NULL;
-	}
-
-	/* Memory initialization */
-	lpm->entry_size = entry_size;
-	lpm->entry_unique_size = p->entry_unique_size;
-	lpm->n_rules = p->n_rules;
-	lpm->offset = p->offset;
-
-	return lpm;
-}
-
-static int
-rte_table_lpm_ipv6_free(void *table)
-{
-	struct rte_table_lpm_ipv6 *lpm = table;
-
-	/* Check input parameters */
-	if (lpm == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	/* Free previously allocated resources */
-	rte_lpm6_free(lpm->lpm);
-	rte_free(lpm);
-
-	return 0;
-}
-
-static int
-nht_find_free(struct rte_table_lpm_ipv6 *lpm, uint32_t *pos)
-{
-	uint32_t i;
-
-	for (i = 0; i < RTE_TABLE_LPM_MAX_NEXT_HOPS; i++) {
-		if (lpm->nht_users[i] == 0) {
-			*pos = i;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static int
-nht_find_existing(struct rte_table_lpm_ipv6 *lpm, void *entry, uint32_t *pos)
-{
-	uint32_t i;
-
-	for (i = 0; i < RTE_TABLE_LPM_MAX_NEXT_HOPS; i++) {
-		uint8_t *nht_entry = &lpm->nht[i * lpm->entry_size];
-
-		if ((lpm->nht_users[i] > 0) && (memcmp(nht_entry, entry,
-			lpm->entry_unique_size) == 0)) {
-			*pos = i;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static int
-rte_table_lpm_ipv6_entry_add(
-	void *table,
-	void *key,
-	void *entry,
-	int *key_found,
-	void **entry_ptr)
-{
-	struct rte_table_lpm_ipv6 *lpm = table;
-	struct rte_table_lpm_ipv6_key *ip_prefix =
-		key;
-	uint32_t nht_pos = 0, nht_pos0 = 0, nht_pos0_valid = 0;
-	int status;
-
-	/* Check input parameters */
-	if (lpm == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (ip_prefix == NULL) {
-		TABLE_LOG(ERR, "%s: ip_prefix parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if (entry == NULL) {
-		TABLE_LOG(ERR, "%s: entry parameter is NULL", __func__);
-		return -EINVAL;
-	}
-
-	if ((ip_prefix->depth == 0) || (ip_prefix->depth > 128)) {
-		TABLE_LOG(ERR, "%s: invalid depth (%d)", __func__,
-			ip_prefix->depth);
-		return -EINVAL;
-	}
-
-	/* Check if rule is already present in the table */
-	status = rte_lpm6_is_rule_present(lpm->lpm, &ip_prefix->ip,
-		ip_prefix->depth, &nht_pos0);
-	nht_pos0_valid = status > 0;
-
-	/* Find existing or free NHT entry */
-	if (nht_find_existing(lpm, entry, &nht_pos) == 0) {
-		uint8_t *nht_entry;
-
-		if (nht_find_free(lpm, &nht_pos) == 0) {
-			TABLE_LOG(ERR, "%s: NHT full", __func__);
-			return -1;
-		}
-
-		nht_entry = &lpm->nht[nht_pos * lpm->entry_size];
-		memcpy(nht_entry, entry, lpm->entry_size);
-	}
-
-	/* Add rule to low level LPM table */
-	if (rte_lpm6_add(lpm->lpm, &ip_prefix->ip, ip_prefix->depth,
-		nht_pos) < 0) {
-		TABLE_LOG(ERR, "%s: LPM IPv6 rule add failed", __func__);
-		return -1;
-	}
-
-	/* Commit NHT changes */
-	lpm->nht_users[nht_pos]++;
-	lpm->nht_users[nht_pos0] -= nht_pos0_valid;
-
-	*key_found = nht_pos0_valid;
-	*entry_ptr = (void *) &lpm->nht[nht_pos * lpm->entry_size];
-	return 0;
-}
-
-static int
-rte_table_lpm_ipv6_entry_delete(
-	void *table,
-	void *key,
-	int *key_found,
-	void *entry)
-{
-	struct rte_table_lpm_ipv6 *lpm = table;
-	struct rte_table_lpm_ipv6_key *ip_prefix =
-		key;
-	uint32_t nht_pos;
-	int status;
-
-	/* Check input parameters */
-	if (lpm == NULL) {
-		TABLE_LOG(ERR, "%s: table parameter is NULL", __func__);
-		return -EINVAL;
-	}
-	if (ip_prefix == NULL) {
-		TABLE_LOG(ERR, "%s: ip_prefix parameter is NULL",
-			__func__);
-		return -EINVAL;
-	}
-	if ((ip_prefix->depth == 0) || (ip_prefix->depth > 128)) {
-		TABLE_LOG(ERR, "%s: invalid depth (%d)", __func__,
-			ip_prefix->depth);
-		return -EINVAL;
-	}
-
-	/* Return if rule is not present in the table */
-	status = rte_lpm6_is_rule_present(lpm->lpm, &ip_prefix->ip,
-		ip_prefix->depth, &nht_pos);
-	if (status < 0) {
-		TABLE_LOG(ERR, "%s: LPM IPv6 algorithmic error",
-			__func__);
-		return -1;
-	}
-	if (status == 0) {
-		*key_found = 0;
-		return 0;
-	}
-
-	/* Delete rule from the low-level LPM table */
-	status = rte_lpm6_delete(lpm->lpm, &ip_prefix->ip, ip_prefix->depth);
-	if (status) {
-		TABLE_LOG(ERR, "%s: LPM IPv6 rule delete failed",
-			__func__);
-		return -1;
-	}
-
-	/* Commit NHT changes */
-	lpm->nht_users[nht_pos]--;
-
-	*key_found = 1;
-	if (entry)
-		memcpy(entry, &lpm->nht[nht_pos * lpm->entry_size],
-			lpm->entry_size);
-
-	return 0;
-}
-
-static int
-rte_table_lpm_ipv6_lookup(
-	void *table,
-	struct rte_mbuf **pkts,
-	uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	void **entries)
-{
-	struct rte_table_lpm_ipv6 *lpm = (struct rte_table_lpm_ipv6 *) table;
-	uint64_t pkts_out_mask = 0;
-	uint32_t i;
-
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-	RTE_TABLE_LPM_IPV6_STATS_PKTS_IN_ADD(lpm, n_pkts_in);
-
-	pkts_out_mask = 0;
-	for (i = 0; i < (uint32_t)(RTE_PORT_IN_BURST_SIZE_MAX -
-		rte_clz64(pkts_mask)); i++) {
-		uint64_t pkt_mask = 1LLU << i;
-
-		if (pkt_mask & pkts_mask) {
-			struct rte_mbuf *pkt = pkts[i];
-			const struct rte_ipv6_addr *ip;
-			int status;
-			uint32_t nht_pos;
-
-			ip = (struct rte_ipv6_addr *)RTE_MBUF_METADATA_UINT8_PTR(pkt, lpm->offset);
-			status = rte_lpm6_lookup(lpm->lpm, ip, &nht_pos);
-			if (status == 0) {
-				pkts_out_mask |= pkt_mask;
-				entries[i] = (void *) &lpm->nht[nht_pos *
-					lpm->entry_size];
-			}
-		}
-	}
-
-	*lookup_hit_mask = pkts_out_mask;
-	RTE_TABLE_LPM_IPV6_STATS_PKTS_LOOKUP_MISS(lpm, n_pkts_in - rte_popcount64(pkts_out_mask));
-	return 0;
-}
-
-static int
-rte_table_lpm_ipv6_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_lpm_ipv6 *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_lpm_ipv6_ops)
-struct rte_table_ops rte_table_lpm_ipv6_ops = {
-	.f_create = rte_table_lpm_ipv6_create,
-	.f_free = rte_table_lpm_ipv6_free,
-	.f_add = rte_table_lpm_ipv6_entry_add,
-	.f_delete = rte_table_lpm_ipv6_entry_delete,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_lpm_ipv6_lookup,
-	.f_stats = rte_table_lpm_ipv6_stats_read,
-};
diff --git a/lib/table/rte_table_lpm_ipv6.h b/lib/table/rte_table_lpm_ipv6.h
deleted file mode 100644
index 3ea8883606..0000000000
--- a/lib/table/rte_table_lpm_ipv6.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_LPM_IPV6_H__
-#define __INCLUDE_RTE_TABLE_LPM_IPV6_H__
-
-/**
- * @file
- * RTE Table LPM for IPv6
- *
- * This table uses the Longest Prefix Match (LPM) algorithm to uniquely
- * associate data to lookup keys.
- *
- * Use-case: IP routing table. Routes that are added to the table associate a
- * next hop to an IP prefix. The IP prefix is specified as IP address and depth
- * and cover for a multitude of lookup keys (i.e. destination IP addresses)
- * that all share the same data (i.e. next hop). The next hop information
- * typically contains the output interface ID, the IP address of the next hop
- * station (which is part of the same IP network the output interface is
- * connected to) and other flags and counters.
- *
- * The LPM primitive only allows associating an 8-bit number (next hop ID) to
- * an IP prefix, while a routing table can potentially contain thousands of
- * routes or even more. This means that the same next hop ID (and next hop
- * information) has to be shared by multiple routes, which makes sense, as
- * multiple remote networks could be reached through the same next hop.
- * Therefore, when a route is added or updated, the LPM table has to check
- * whether the same next hop is already in use before using a new next hop ID
- * for this route.
- *
- * The comparison between different next hops is done for the first
- * “entry_unique_size” bytes of the next hop information (configurable
- * parameter), which have to uniquely identify the next hop, therefore the user
- * has to carefully manage the format of the LPM table entry (i.e.  the next
- * hop information) so that any next hop data that changes value during
- * run-time (e.g. counters) is placed outside of this area.
- */
-
-#include <stdint.h>
-
-#include <rte_common.h>
-#include <rte_ip6.h>
-
-#include "rte_table.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#define RTE_LPM_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_LPM_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
-
-/** LPM table parameters */
-struct rte_table_lpm_ipv6_params {
-	/** Table name */
-	const char *name;
-
-	/** Maximum number of LPM rules (i.e. IP routes) */
-	uint32_t n_rules;
-
-	uint32_t number_tbl8s;
-
-	/** Number of bytes at the start of the table entry that uniquely
-	identify the entry. Cannot be bigger than table entry size. */
-	uint32_t entry_unique_size;
-
-	/** Byte offset within input packet meta-data where lookup key (i.e.
-	the destination IP address) is located. */
-	uint32_t offset;
-};
-
-/** LPM table rule (i.e. route), specified as IP prefix. While the key used by
-the lookup operation is the destination IP address (read from the input packet
-meta-data), the entry add and entry delete operations work with LPM rules, with
-each rule covering for a multitude of lookup keys (destination IP addresses)
-that share the same data (next hop). */
-struct rte_table_lpm_ipv6_key {
-	/** IP address */
-	struct rte_ipv6_addr ip;
-
-	/** IP address depth. The most significant "depth" bits of the IP
-	address specify the network part of the IP address, while the rest of
-	the bits specify the host part of the address and are ignored for the
-	purpose of route specification. */
-	uint8_t depth;
-};
-
-/** LPM table operations */
-extern struct rte_table_ops rte_table_lpm_ipv6_ops;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/rte_table_stub.c b/lib/table/rte_table_stub.c
deleted file mode 100644
index 3d2ac55c49..0000000000
--- a/lib/table/rte_table_stub.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#include <string.h>
-
-#include <eal_export.h>
-#include <rte_malloc.h>
-
-#include "rte_table_stub.h"
-
-#include "table_log.h"
-
-#ifdef RTE_TABLE_STATS_COLLECT
-
-#define RTE_TABLE_LPM_STATS_PKTS_IN_ADD(table, val) \
-	table->stats.n_pkts_in += val
-#define RTE_TABLE_LPM_STATS_PKTS_LOOKUP_MISS(table, val) \
-	table->stats.n_pkts_lookup_miss += val
-
-#else
-
-#define RTE_TABLE_LPM_STATS_PKTS_IN_ADD(table, val)
-#define RTE_TABLE_LPM_STATS_PKTS_LOOKUP_MISS(table, val)
-
-#endif
-
-struct rte_table_stub {
-	struct rte_table_stats stats;
-};
-
-static void *
-rte_table_stub_create(__rte_unused void *params,
-		__rte_unused int socket_id,
-		__rte_unused uint32_t entry_size)
-{
-	struct rte_table_stub *stub;
-	uint32_t size;
-
-	size = sizeof(struct rte_table_stub);
-	stub = rte_zmalloc_socket("TABLE", size, RTE_CACHE_LINE_SIZE,
-		socket_id);
-	if (stub == NULL) {
-		TABLE_LOG(ERR,
-			"%s: Cannot allocate %u bytes for stub table",
-			__func__, size);
-		return NULL;
-	}
-
-	return stub;
-}
-
-static int
-rte_table_stub_lookup(
-	__rte_unused void *table,
-	__rte_unused struct rte_mbuf **pkts,
-	__rte_unused uint64_t pkts_mask,
-	uint64_t *lookup_hit_mask,
-	__rte_unused void **entries)
-{
-	__rte_unused struct rte_table_stub *stub = (struct rte_table_stub *) table;
-	__rte_unused uint32_t n_pkts_in = rte_popcount64(pkts_mask);
-
-	RTE_TABLE_LPM_STATS_PKTS_IN_ADD(stub, n_pkts_in);
-	*lookup_hit_mask = 0;
-	RTE_TABLE_LPM_STATS_PKTS_LOOKUP_MISS(stub, n_pkts_in);
-
-	return 0;
-}
-
-static int
-rte_table_stub_stats_read(void *table, struct rte_table_stats *stats, int clear)
-{
-	struct rte_table_stub *t = table;
-
-	if (stats != NULL)
-		memcpy(stats, &t->stats, sizeof(t->stats));
-
-	if (clear)
-		memset(&t->stats, 0, sizeof(t->stats));
-
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_table_stub_ops)
-struct rte_table_ops rte_table_stub_ops = {
-	.f_create = rte_table_stub_create,
-	.f_free = NULL,
-	.f_add = NULL,
-	.f_delete = NULL,
-	.f_add_bulk = NULL,
-	.f_delete_bulk = NULL,
-	.f_lookup = rte_table_stub_lookup,
-	.f_stats = rte_table_stub_stats_read,
-};
diff --git a/lib/table/rte_table_stub.h b/lib/table/rte_table_stub.h
deleted file mode 100644
index f7e589df16..0000000000
--- a/lib/table/rte_table_stub.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#ifndef __INCLUDE_RTE_TABLE_STUB_H__
-#define __INCLUDE_RTE_TABLE_STUB_H__
-
-/**
- * @file
- * RTE Table Stub
- *
- * The stub table lookup operation produces lookup miss for all input packets.
- */
-
-#include "rte_table.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/** Stub table parameters: NONE */
-
-/** Stub table operations */
-extern struct rte_table_ops rte_table_stub_ops;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/table/table_log.c b/lib/table/table_log.c
deleted file mode 100644
index b329edd2e6..0000000000
--- a/lib/table/table_log.c
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2024 Stephen Hemminger <stephen@networkplumber.org>
- */
-
-#include <rte_log.h>
-
-RTE_LOG_REGISTER_DEFAULT(table_logtype, INFO);
diff --git a/lib/table/table_log.h b/lib/table/table_log.h
deleted file mode 100644
index b24b8614c2..0000000000
--- a/lib/table/table_log.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2023 Red Hat, Inc.
- */
-
-#include <rte_log.h>
-
-extern int table_logtype;
-#define RTE_LOGTYPE_TABLE table_logtype
-
-#define TABLE_LOG(level, ...) \
-	RTE_LOG_LINE(level, TABLE, "" __VA_ARGS__)
-- 
2.53.0

